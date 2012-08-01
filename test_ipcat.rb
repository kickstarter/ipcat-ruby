require 'test/unit'
require_relative 'ipcat'

class IPCatTest < Test::Unit::TestCase

  def setup
    if IPCat.ranges.empty?
      start = Time.now
      IPCat.load!
      puts "Loaded IPCat databases in %.2f seconds" % (Time.now - start)
    end
  end

  def test_load
    assert !IPCat.ranges.empty?
  end



end
