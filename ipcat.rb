##
# IPCat
# Ruby lib for https://github.com/client9/ipcat/

require 'ipaddr'
require 'open-uri'

class IPCat
  VERSION = '0.0.1'

  class << self
    def matches?(ip)
      bsearch(ip_to_fixnum(ip), ranges)
    end

    def ip_to_fixnum(ip)
      Fixnum === ip ? ip : IPAddr.new(ip).to_i
    end

    def ranges
      @ranges ||= []
    end

    def load!(path='https://raw.github.com/client9/ipcat/master/datacenters.csv')
      open(path).readlines.each do |line|
        next if line =~/\s*#/
          first, last = line.split(',')[0,2]
        IPRange.new(first, last)
      end
    end

    # Assume's haystack is an array of comparable objects
    def bsearch(needle, haystack, first=0, last=nil)
      last ||= haystack.size - 1
      return nil if last < first # not found, or empty haystack

      cur = first + (last - first)/2
      case haystack[cur] <=> needle
      when -1 # needle is larger than cur value
        bsearch(needle, haystack, cur+1, last)
      when 1 # needle is smaller than cur value
        bsearch(needle, haystack, first, cur-1)
      when 0
        cur
      end
    end

    # Sigh, why isn't this part of IPAddr?
    def i_to_ip_str(i)
      exp = 1
      parts = []
      while i > 0
        parts << i % 256
        i /= 256
        exp += 1
      end
      parts.reverse * '.'
    end
  end


  class IPRange

    include Comparable

    attr_accessor :first, :last

    def initialize(first, last)
      @first = IPCat.ip_to_fixnum(first)
      @last  = IPCat.ip_to_fixnum(last)
      raise ArgumentError.new("first must be <= last") if @first > @last
      raise ArgumentError.new("Ranges are expected to be sorted") if IPCat.ranges.last && IPCat.ranges.last.last >= @first
      (IPCat.ranges ||= []) << self
    end

    def <=>(obj)
      case obj
      when Fixnum
        compare_with_fixnum(obj)
      when String
        compare_with_fixnum(IPAddr.new(obj).to_i)
      when IPRange
        # Assume all IPRanges are non-overlapping
        first <=> obj.first
      end
    end

    def size
      last - first
    end

    protected
    def compare_with_fixnum(i)
      if first > i
        1
      elsif last < i
        -1
      else
        0
      end
    end
  end
end
