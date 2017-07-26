
module Crystalg::Strings
  class AhoCorasick
    class Node
      property parent : Int32
      property link : Int32
      property char : Char
      property is_leaf : Bool
        
      def initialize
        @parent = 0
        @link = -1
        @char = '\0'
        @is_leaf = false
        @children = Array(Int32).new(128, -1)
        @next = Array(Int32).new(128, -1)
      end
      
      def set_char(@char : Char)
      end
      
      def get_char
        @char
      end
    end
    
    property size : Int32
    property nodes : Array(Node)
    ROOT = 0
    
    def initialize(max_node)
      @size = 0
      @nodes = Array(Node).new(max_node) { Node.new }
      @nodes[ROOT].link = ROOT
      @nodes[ROOT].parent = -1
    end
    
    def add(str)
      cur = ROOT
      str.each_char do |ch|
        c = ch.bytes.first
        if @nodes[cur].@children[c] == -1
          @size += 1
          @nodes[@size].parent = cur
          @nodes[@size].char = ch
          @nodes[cur].@children[c] = @size
        end
        cur = @nodes[cur].@children[c]
      end
      @nodes[cur].is_leaf = true
    end
    
    def failure(id)
      if @nodes[id].link == -1
        if @nodes[id].parent == ROOT
          @nodes[id].link = ROOT
        else
          @nodes[id].link = goto(failure(@nodes[id].parent), @nodes[id].char)
        end
      end
      @nodes[id].link
    end
    
    def goto(id, char)
      c = char.bytes.first
      if @nodes[id].@next[c] == -1
        if @nodes[id].@children[c] != -1
          @nodes[id].@next[c] = @nodes[id].@children[c]
        elsif id == ROOT
          @nodes[id].@next[c] = ROOT
        else
          @nodes[id].@next[c] = goto(failure(id), char)
        end
      end
      @nodes[id].@next[c]
    end
    
    def contain?(target : String)
      cur = ROOT
      target.each_char do |ch|
        cur = @nodes[cur].@children[ch.bytes.first]
        return false if cur < 0
      end
      @nodes[cur].is_leaf
    end
    
    def match?(target : String)
      cur = ROOT
      target.each_char { |ch| cur = goto(cur, ch) }
      @nodes[cur].is_leaf
    end
  end
end