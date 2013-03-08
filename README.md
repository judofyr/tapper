# Tapper

```ruby
require 'tapper'
extend Tapper

test "foo bar" do
  assert_equal 2, 1 + 1
end

done
```

Tapper is a tiny library for writing tests that *must* run in a separate
process. The only way to invoke Tapper is by running the test file
itself (which will output progress in the TAP format). This gives you
full control over the test run and ensures that you have a clean
environement when the test runs.

It's recommended that you run Tapper through a TAP runner:

```sh
# Use Perl's prove
prove -e 'ruby' t/*.rb
```

## API

### Tapper

`Tapper` is a module with three public methods. You can either invoke
the methods directly on `Tapper`, or extend an object yourself:

```ruby
## Extend main:
extend Tapper

test "Hello world" do
  # ...
end

## Call directly:
Tapper.test "Hello world" do
  # ...
end
```

#### #test(name)

```ruby
test "Hello world"
test "Hello world" do
  assert_equal 2, 1 + 1
end
```

Runs a new test.

You can use MiniTest assertions inside the block.

If you don't provide a block, the test will automatically pass.

#### #diag(msg)

```ruby
diag "Hello world"
```

Outputs diagnostic messages.

#### #done

```ruby
done
```

Outputs the final TAP command and exits the process with the correct
status code.

