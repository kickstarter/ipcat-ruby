class IPCat
  class IPRange

    attr_accessor :first, :last, :name, :url

    def initialize(first, last, name=nil, url=nil)
      @first = IPCat.ip_to_fixnum(first)
      @last  = IPCat.ip_to_fixnum(last)
      @name, @url = name, url
      raise ArgumentError.new("first must be <= last") if @first > @last
    end

    def <=>(obj)
      case obj
      when Fixnum
        compare_with_fixnum(obj)
      when IPRange
        # Assume all IPRanges are non-overlapping
        first <=> obj.first
      end
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
