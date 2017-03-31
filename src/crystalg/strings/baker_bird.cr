require "../*"

module Crystalg::Strings
  class BakerBird
    def initialize(@text : Array(String))
      size = @text.reduce(0) do |acc, str|
        acc + str.size
      end
      @aho_corasick = AhoCorasick.new(size)
    end
    
    def search(pattern : Array(String)): Array(Tuple(Int32, Int32))
      ph, th, pw = pattern.size, @text.size, pattern[0].size
      
      pattern.each do |row|
        @aho_corasick.add row
      end
      
      acc = Array(Int32).new
      pattern.each do |str|
        node_id = 0
        str.each_char do |char|
          node_id = @aho_corasick.goto node_id, char
          acc << node_id if @aho_corasick.@nodes[node_id].is_leaf
        end
      end
      
      td = Array(Array(Int32)).new(@text[0].size) do
        Array(Int32).new(@text.size)
      end
      
      til = @text[0].size
      
      td.each_with_index do |row, i|
        node_id = 0
        row.each_with_index do |e, j|
          node_id = @aho_corasick.goto node_id, @text[i][j]
          td[til - j - 1][i] = node_id
        end
      end
      
      result = Array(Tuple(Int32, Int32)).new
      a = Array(Int32).new(acc.size + @text.size + 2, -1)
      td.each_with_index do |t, i|
        s = acc
        s << -1
        t.each { |e| s << e }
        j = -1
        (0...acc.size).each do |k|
          while j >= 0 && s[k] != s[j]
            j = a[j]
          end
          a[k+1] = j
        end
        (acc.size+1..acc.size+@text.size+1).each do |k|
          result << {k - acc.size * 2 - 1, @text.size - i - pattern.size} if a[k] == acc.size
        end
      end
      result
    end
  end
end