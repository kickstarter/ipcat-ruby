require 'test/unit'
require_relative 'ipcat'

class IPCatTest < Test::Unit::TestCase

  def setup
    if IPCat.ranges.empty?
      start = Time.now
      IPCat.load!
      puts "Loaded %i IPCat ranges in %.2f seconds" % [IPCat.ranges.size, Time.now - start]
    end
    # Test the first, last, middle, and a random values
    @test_ranges = IPCat.ranges.values_at(0, -1, IPCat.ranges.size / 2, rand(IPCat.ranges.size))
  end

  def test_load
    assert !IPCat.ranges.empty?
  end

  def test_matches
    @test_ranges.each do |r|
      # Test, first, last, middle, and random value
      [r.first, r.last, r.first + (r.size)/2, r.first + rand(r.size)].each do |value|
        assert IPCat.matches?(value), "#{value} did not match"
        value_as_string = IPCat.i_to_ip_str(value)
        assert IPCat.matches?(value_as_string), "#{value_as_string} did not match"
      end
    end
  end

end
