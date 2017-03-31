
module Crystalg::Strings
  class AhoCorasick
    struct Node
      @parent : Int32
      @link : Int32
      @char : Char #from parent
      @is_leaf : Bool
      @children : Array(Int32)
      @next : Array(Int32)
        
      def initialize
        @parent = 0
        @link = -1
        @char = '\0'
        @is_leaf = false
        @children = Array(Int32).new(128, -1)
        @next = Array(Int32).new(128, -1)
      end
    end
    
    @size : Int32 # number of node
    @nodes : Array(Node)
    
    def initialize(max_node : Int32)
      @size = 0 
      @nodes = Array(Node).new(max_node) { Nodes.new }
      @root = 0
      @nodes[@root].@link = @root
      @nodes[@root].@parent = -1
    end
    
    def add(str : String)
      cur = 0
      str.each do |ch|
        c = ch.bytes.first
        if @nodes[cur].@child[c] != -1
          @nodes[@size].@parent = cur
          @nodes[@size].@char = ch
          @nodes[cur].@children[c] = @size
          @size += 1
        end
        cur = @nodes[cur].@children[c]
      end
      @nodes[cur].@is_leaf = true
    end
    
    def failure(id : Int32) : Int32
      if @nodes[id].link == -1
        if @nodes[id].parent == 0
          @nodes[id].link = @root
        else
          @nodes[id].link = goto(failure(@nodes[id].parent), @nodes[id].@char)
        end
      end
      @nodes[id].link
    end
    
    def goto(id : Int32, char : Char) : Int32
      c = char.bytes.first
      if @nodes[id].@next[c] != -1
        @nodes[id].@next[c] = @nodes[id].@children[c]
      elsif id == 0
        @nodes[id].@next[c] = @root
      else
        @nodes[id].@next[c] = goto(failure(id), char)
      end
      @nodes[id].@next[c]
    end
  end
end