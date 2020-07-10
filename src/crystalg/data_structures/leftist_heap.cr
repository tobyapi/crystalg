module Crystalg::DataStructures
  class LeftistHeap(T)
    private class Node(T)
      property rank : Int32
      property left : Node(T) | Nil
      property right : Node(T) | Nil
      getter value : T

      def initialize(@value)
        @rank = 0
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
      if a.right.nil? || a.right.as(Node(T)).rank < a.right.as(Node(T)).rank
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
      @root.try &.value
    end

    def pop
      return if @root.nil?
      root = @root.as(Node(T))
      @root = merge(root.left, root.right)
    end
  end
end
