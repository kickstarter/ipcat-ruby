require_relative 'spec_helper'
require 'minitest/benchmark'

describe 'IPCat.bsearch' do

  # Makes +n+ IPRanges
  def make_ranges(n)
    ips = (n*2).times.map{ rand(2**32) }.sort
    ranges = []
    ips.each_slice(2) do |first, last|
      ranges << IPCat::IPRange.new(first, last)
    end

    ranges
  end

  before do
    @ips = 1000.times.map{ rand(2**32) }
    @ranges = MiniTest::Spec.bench_range.inject({}) {|h, n|
      h[n] = make_ranges(n)
      h
    }
  end

  it("should be logarithmic") do
    assert_performance_logarithmic 0.95 do |n|
      IPCat.reset_ranges!(@ranges[n])
      @ips.each { |ip| IPCat.bsearch(ip) }
    end
  end

end
