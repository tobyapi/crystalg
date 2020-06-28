module Crystalg::Strings
  class SuffixArray
    getter suffix_array : Array(Int32)
    getter rank : Array(Int32)

    def initialize(@target : String)
      @target += '\0'
      @suffix_array = (0...@target.size).to_a
      @rank = @target.chars.map { |char| char.bytes.first.to_i32 }
      @lcp = Array(Int32).new(@target.size, 0)
    end

    def construct
      n = @target.size

      # suffix array in O(n log^2 n)
      len = 1
      while len < n
        tmp = Array(Int64).new(n, 0_i64)
        (0...n).each do |i|
          tmp[i] = (@rank[i].to_i64 << 32) + (i + len < n ? @rank[i + len] + 1 : 0)
        end

        @suffix_array = @suffix_array.sort { |a, b| tmp[a] <=> tmp[b] }

        (0...n).each do |i|
          j = @suffix_array[i]
          k = @suffix_array[i - 1]
          @rank[j] =
            if i > 0 && tmp[k] == tmp[j]
              @rank[k]
            else
              i
            end
        end
        len *= 2
      end

      # longest common prefixes array in O(n)
      h = 0
      (0...n).each do |i|
        if @rank[i] + 1 < n
          j = @suffix_array[@rank[i] + 1]
          while Math.max(i, j) + h < n && @target[i + h] == @target[j + h]
            h += 1
          end
          @lcp[@rank[i]] = h
          h -= 1 if h > 0
        end
      end
    end
  end
end
