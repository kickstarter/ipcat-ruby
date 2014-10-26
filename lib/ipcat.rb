##
# IPCat
# Ruby lib for https://github.com/client9/ipcat/

require 'ipaddr'
require 'ipcat/iprange'
require 'ipcat/version'


class IPCat
  class << self
    def datacenter?(ip)
      ip_as_int = ip_to_integer(ip)
      ranges.bsearch {|range| range <=> ip_as_int }
    end
    alias_method :classify, :datacenter?

    def ip_to_integer(ip)
      Integer === ip ? ip : IPAddr.new(ip).to_i
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
      open(path).readlines[1..-1].each do |line|
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
  end
end

# Load dataset
IPCat.load!
