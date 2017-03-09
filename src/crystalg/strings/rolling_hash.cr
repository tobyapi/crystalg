
module Crystalg::Strings

  class RollingHash
    private PRIME = 1000000007
    def initialize(@str : String)
      @pow = Array(Int64).new(@str.size + 1)
      @phash = Array(Int64).new(@str.size + 1)
      @pow << 1.to_i64
      @phash << 0.to_i64
      @str.each_char_with_index { |ch, i|  
        @phash << ch.bytes.first.to_i64 + @phash[i] * PRIME
        @pow << @pow[i] * PRIME
      }
    end

    def hash(t : String) : Int64
      acc = 0.to_i64
      t.each_char_with_index { |ch, i| 
        acc = ch.bytes.first.to_i64 + acc * PRIME 
      }
      acc
    end

    def hash(b : Int32, e : Int32) : Int64 
      @phash[e] - @phash[b] * @pow[e-b]
    end

    def count(t : String) : Int32
      w = t.size
      count = 0
      if w < @str.size
        h = hash t
        (0..@str.size - w).each { |i| 
          count += 1 if hash(i, i+w) == h  
        }
      end
      count
    end

    def lcp(i : Int32, j : Int32) : Int32
      l = 0
      r = n - max(i,j) + 1
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
    
    def compare?(i : Int32, j : Int32): Bool
      k = lcp i, j
      if i + k >= @size
        true
      elif j + k >= @size
        false
      else
        @str[i+k] <= @str[j+k]
      end
    end
    
  end
end