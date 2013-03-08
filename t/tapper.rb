require 'tapper'
extend Tapper

require 'stringio'

def run(&blk)
  $stdout = StringIO.new
  scope = Object.new
  scope.extend(Tapper)
  scope.instance_eval(&blk)
ensure
  @res = $stdout.string
  $stdout = STDOUT
end

test "#test with description" do
  run do
    test "Hello world"
  end

  assert_equal "ok 1 - Hello world\n", @res
end

test "#test with assertion" do
  loc = nil
  run do
    test "Hello world" do
      loc = [__FILE__, __LINE__+1].join(':')
      flunk
    end
  end

  exp = [
    "not ok 1 - Hello world\n",
    "#  #{loc}\n",
  ]

  assert_equal exp, @res.lines.to_a[0, 2]
end

test "#test carries on" do
  test2_called = false

  run do
    test "Hello world" do
      flunk
    end

    test "Hello world2" do
      test2_called = true
    end
  end

  assert test2_called, "#test didn't carry on"
end

test "#diag" do
  run do
    diag "Hello world"
  end

  assert_equal "#  Hello world\n", @res
end

test "#done with success" do
  ex = assert_raises(SystemExit) do
    run do
      test "Hello world"
      done
    end
  end

  assert_match /^1\.\.1$/, @res
  assert_equal 0, ex.status
end

test "#done with failure" do
  ex = assert_raises(SystemExit) do
    run do
      test "Hello world" do
        flunk
      end
      done
    end
  end

  assert_match /^1\.\.1$/, @res
  assert_equal 1, ex.status
end

done

