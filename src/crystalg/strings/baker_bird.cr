require "../*"

module Crystalg::Strings
  class BakerBird
    def initialize(@text : Array(String))
      size = @text.reduce(0) { |acc, str| acc + str.size }
      @aho_corasick = AhoCorasick.new(size)
    end
    
    def search(pattern)
      pattern.each { |row| @aho_corasick.add row }
      acc = Array(Int32).new
      pattern.each do |str|
        node_id = 0
        str.each_char do |char|
          node_id = @aho_corasick.goto node_id, char
          acc << node_id if @aho_corasick.@nodes[node_id].is_leaf
        end
      end

      til = @text[0].size
      td = Array(Array(Int32)).new(til) { Array(Int32).new(@text.size, 0) }

      @text.each_with_index do |row, i|
        node_id = 0
        row.each_char_with_index do |e, j|
          node_id = @aho_corasick.goto node_id, @text[i][j]
          td[til - j - 1][i] = node_id
        end
      end

      result = Array(Tuple(Int32, Int32)).new
      a = Array(Int32).new(acc.size + @text.size + 2, -1)
      sl = acc.size + @text.size + 1
      (0...til).each do |i|
        s = acc.dup
        s << -1

        (0...@text.size).each { |j| s << td[i][j] }
        j = -1
        (0...sl).each do |k|
          while j >= 0 && s[k] != s[j]
            j = a[j]
          end
          j += 1
          a[k + 1] = j
        end
        (acc.size+1 .. sl).each do |k|
          result << {k - acc.size * 2 - 1, til - i - pattern[0].size} if a[k] == acc.size
        end
      end
      result
    end
  end
end