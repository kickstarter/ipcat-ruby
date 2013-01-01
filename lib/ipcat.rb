##
# IPCat
# Ruby lib for https://github.com/client9/ipcat/

require 'ipaddr'
require 'ipcat/iprange'
require 'ipcat/version'


class IPCat
  class << self
    def matches?(ip)
      bsearch(ip_to_fixnum(ip))
    end

    def ip_to_fixnum(ip)
      Fixnum === ip ? ip : IPAddr.new(ip).to_i
    end

    def ranges
      @ranges ||= []
    end

    def reset_ranges!(new_ranges = [])
      @ranges = new_ranges
    end

    def load_csv!(path='https://raw.github.com/client9/ipcat/master/datacenters.csv')
      reset_ranges!

      require 'open-uri'
      open(path).readlines.each do |line|
        next if line =~/\s*#/ # Skip comments
        first, last, name, url = line.split(',')
        self.ranges << IPRange.new(first, last, name, url).freeze
      end
      self.ranges.freeze
    end

    def load!
      reset_ranges!
      # NB: loading an array of marshaled ruby objects takes ~15ms;
      # versus ~100ms to load a CSV file
      path = File.join(File.dirname(__FILE__), '..', 'data', 'datacenters')
      @ranges = Marshal.load(File.read(path))
      @ranges.each(&:freeze)
      @ranges.freeze
    rescue
      load_csv!
    end

    # Assume ranges is an array of comparable objects
    def bsearch(needle, haystack=ranges, first=0, last=ranges.size-1)
      return nil if last < first # not found, or empty range

      cur = first + (last - first)/2
      case ranges[cur] <=> needle
      when -1 # needle is larger than cur value
        bsearch(needle, haystack, cur+1, last)
      when 1 # needle is smaller than cur value
        bsearch(needle, haystack, first, cur-1)
      when 0
        ranges[cur]
      end
    end
  end
end

# Load dataset
IPCat.load!
