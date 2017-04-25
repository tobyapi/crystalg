
module Crystalg::Strings

  class RollingHash
    private PRIME = 1000000007
    
    def initialize(@str : String)
      @pow = Array(Int64).new(@str.size + 1)
      @phash = Array(Int64).new(@str.size + 1)
      @pow << 1.to_i64
      @phash << 0.to_i64
      @str.each_char_with_index do |ch, i|  
        @phash << ch.bytes.first.to_i64 + @phash[i] * PRIME
        @pow << @pow[i] * PRIME
      end
    end

    def hash(t)
      acc = 0.to_i64
      t.each_char { |ch| acc = ch.bytes.first.to_i64 + acc * PRIME }
      acc
    end

    def hash(b, e)
      @phash[e] - @phash[b] * @pow[e - b]
    end

    def count(t)
      w = t.size
      count = 0
      if w < @str.size
        h = hash t
        (0..@str.size - w).each do |i| 
          count += 1 if hash(i, i+w) == h  
        end
      end
      count
    end

    def lcp(i, j)
      l = 0
      r = @str.size - Math.max(i, j) + 1
      while l + 1 < r
        m = (l + r) >> 1
        if hash(i,i+m) == hash(j,j+m) 
          l = m
        else
          r = m
        end
      end
      l
    end
    
    private def compare(i, j)
      k = lcp i, j
      if i + k >= @str.size
        -1
      elsif j + k >= @str.size
        1
      elsif @str[i+k] == @str[j+k]
        0
      else
        @str[i+k] < @str[j+k] ? -1 : 1
      end
    end
    
    def get_suffix_array
      n = @str.size + 1
      suffix_array = Array.new(n, 0)
      (0...n).each { |i| suffix_array[i] = i }
      suffix_array.sort { |a, b| compare a, b }
    end
  end
end