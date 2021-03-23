# frozen_string_literal: true

require_relative 'spec_helper'

describe 'IPCat::IPRange' do
  attr_accessor :range

  before do
    IPCat.reset_ranges!
    first = IPAddr.new('1.2.3.0').to_i
    last = IPAddr.new('1.2.3.255').to_i
    @range = IPCat::IPRange.new(first, last, 'example', 'www.example.com')
  end

  describe '#initialize' do
    it 'should fail if last < first' do
      expect { IPCat::IPRange.new(2, 1) }.must_raise ArgumentError
    end
  end

  describe '#<=> for integers' do
    it('should match first')   { expect(range <=> range.first).must_equal 0 }
    it('should match last')    { expect(range <=> range.last).must_equal 0 }
    it('should match first-1') { expect(range <=> range.first - 1).must_equal 1 }
    it('should match last+1')  { expect(range <=> range.last + 1).must_equal(-1) }
  end
end
