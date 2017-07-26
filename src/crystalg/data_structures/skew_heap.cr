
module Crystalg::DataStructures
  class SkewHeap(T)
    class Node(T)
      property left : Node(T) | Nil
      property right : Node(T) | Nil
      getter value : T

      def initialize(@value)
        @left = nil
        @right = nil
      end
    end
    
    @root = nil
    
    def merge(a, b)
      return b if a.nil?
      return a if b.nil?
      a, b = b, a if a.value > b.value
      a.right = merge(a.right, b)
      a.left, a.right = a.right, a.left
      a
    end
    
    def push(x)
      @root = 
        if @root.nil?
          Node(T).new x
        else
          merge(@root.as(Node(T)), Node(T).new x)
        end
    end
 
    def top
      @root.try &.value
    end
 
    def pop
      return if @root.nil?
      tmp = @root.as(Node(T))
      @root = merge(tmp.left, tmp.right)
    end
  end
end