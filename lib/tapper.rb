# Place this in test/
#
# Run your tests with:
#
#   prove -e 'ruby -Ilib:test' -v t/*.rb
#
# See the bottom for usage.

require 'minitest/unit'

module Tapper
  include MiniTest::Assertions
  extend self

  def tapper_context
    @tapper_context ||= {:current => 0, :ok => true }
  end

  CTX = {
    :current => 0,
    :ok => true
  }

  PASSTHROUGH_EXCEPTIONS = [NoMemoryError, SignalException, Interrupt, SystemExit]

  def diag(str)
    puts str.gsub(/^/, '#  ')
  end

  def test(name)
    id = tapper_context[:current] += 1
    yield if block_given?
    puts "ok #{id} - #{name}"
  rescue *PASSTHROUGH_EXCEPTIONS
    raise

  rescue MiniTest::Assertion
    tapper_context[:ok] = false
    puts "not ok #{id} - #{name}"

    # Try to figure out where the assertion happened:
    last_before_assertion = ""
    $!.backtrace.reverse_each do |s|
      break if s =~ /in .(assert|refute|flunk|pass|fail|raise|must|wont)/
      last_before_assertion = s
    end

    diag last_before_assertion.sub(/:in .*$/, '')
    diag $!.to_s

  rescue Exception
    tapper_context[:ok] = false
    puts "not ok #{id} - #{name}"
    bt = MiniTest.filter_backtrace($!.backtrace).join "\n    "

    diag "#{$!.class}: #{$!.message}"
    diag bt
  end

  def done
    puts "1..#{tapper_context[:current]}"
    status_code = tapper_context[:ok] ? 0 : 1
    exit status_code
  end
end

