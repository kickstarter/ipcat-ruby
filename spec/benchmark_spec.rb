# frozen_string_literal: true

require_relative 'spec_helper'
require 'minitest/benchmark'

describe 'IPCat.bsearch Benchmark' do
  # Makes +n+ IPRanges
  def make_ranges(n)
    ips = Array.new((n * 2)) { rand(2**32) }.sort
    ranges = []
    ips.each_slice(2) do |first, last|
      ranges << IPCat::IPRange.new(first, last)
    end

    ranges
  end

  before do
    @ips = Array.new(1000) { rand(2**32) }
    @ranges = bench_range.each_with_object({}) do |n, h|
      h[n] = make_ranges(n)
    end
  end

  it('should be logarithmic') do
    assert_performance_logarithmic 0.95 do |n|
      IPCat.reset_ranges!(@ranges[n])
      @ips.each do |ip|
        10.times { IPCat.bsearch(ip) }
      end
    end
  end
end
