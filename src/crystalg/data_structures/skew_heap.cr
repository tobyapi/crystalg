
module Crystalg::DataStructures
  class SkewHeap(T)
    class Node(T)
      getter value, left, right
      setter left, right
      
      @left : (Node(T) | Nil) = nil
      @right : (Node(T) | Nil) = nil

      def initialize(@value : T)
      end
    end
    
    @root : (Node(T) | Nil) = nil
    
    def merge(a : (Node(T) | Nil), b : (Node(T) | Nil)) : (Node(T) | Nil)
      return b if a.nil?
      return a if b.nil?
      a, b = b, a if a.value > b.value
      a.right = merge(a.right, b)
      a.left, a.right = a.right, a.left
      a
    end
    
    def push(x : T)
      @root = if @root.nil?
        Node(T).new x
      else
        merge(@root.as(Node(T)), Node(T).new x)
      end
    end
 
    def top : (T | Nil)
      @root.as(Node(T)).value if !@root.nil?
    end
 
    def pop
      return if @root.nil?
      root = @root.as(Node(T))
      @root = merge(root.left, root.right)
    end
  end
end