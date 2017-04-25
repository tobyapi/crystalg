
module Crystalg::DataStructures
  class LeftistHeap(T)    
    class Node(T)
      getter rank, value, left, right
      setter rank, left, right
      
      @left : (Node(T) | Nil) = nil
      @right : (Node(T) | Nil) = nil
      
      def initialize(@value : T)
        @rank = 0
      end
    end
    
    @root : (Node(T) | Nil) = nil
    
    def merge(a, b)
      return b if a.nil?
      return a if b.nil?
      a, b = b, a if a.value > b.value
      a.right = merge(a.right, b)
      if a.left.nil? || a.left.as(Node(T)).rank < a.right.as(Node(T)).rank
        a.left, a.right = a.right, a.left
      end
      a.rank = (a.right.nil? ? 0 : a.right.as(Node(T)).rank) + 1
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
      @root.as(Node(T)).value if !@root.nil?
    end
 
    def pop
      return if @root.nil?
      root = @root.as(Node(T))
      @root = merge(root.left, root.right)
    end
  end
end