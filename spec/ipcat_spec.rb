require_relative 'spec_helper'

describe 'IPCat' do

  before do
    IPCat.reset_ranges!
    start = IPAddr.new('1.2.3.0').to_i
    stop = IPAddr.new('1.2.3.255').to_i
    IPCat.ranges << IPCat::IPRange.new(start, stop, 'example', 'www.example.com')
  end

  describe '#ranges' do
   it("has a range") { IPCat.ranges.size.must_equal 1 }
  end

  describe '#datacenter?' do
    it("should match 1.2.3.0") { IPCat.datacenter?('1.2.3.0').must_be_instance_of IPCat::IPRange }
    it("should match 1.2.3.1") { IPCat.datacenter?('1.2.3.1').must_be_instance_of IPCat::IPRange }
    it("should match 1.2.3.1") { IPCat.datacenter?('1.2.3.1').must_be_instance_of IPCat::IPRange }
    it("should not match 1.1.1.1") { IPCat.datacenter?('1.1.1.1').must_be_nil }
    it("should not match 2.2.2.2") { IPCat.datacenter?('2.2.2.2').must_be_nil }
  end

end
