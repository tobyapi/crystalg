
module Crystalg::Strings

  class RollingHash
    private PRIME = 1000000007
    def initialize(@str : String)
      @pow = Array(Int64).new(@str.size + 1)
      @phash = Array(Int64).new(@str.size + 1)
      @pow << 1_i64
      @phash << 0_i64
      @str.each_char_with_index do |ch, i|  
        @phash << ch.bytes.first.to_i64 + @phash[i] * PRIME
        @pow << @pow[i] * PRIME
      end
    end

    def hash(t)
      t.chars.reduce(0_i64) { |acc, ch| ch.bytes.first.to_i64 + acc * PRIME }
    end

    def hash(b, e)
      @phash[e] - @phash[b] * @pow[e - b]
    end

    def count(t)
      w = t.size
      result = 0
      if w < @str.size
        h = hash t
        result += (0..@str.size - w).count { |i| hash(i, i+w) == h }
      end
      result
    end

    def lcp(i, j)
      l = 0
      r = @str.size - Math.max(i,j) + 1
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
      suffix_array = (0...@str.size+1).to_a
      suffix_array.sort { |a, b| compare a, b }
    end
  end
end