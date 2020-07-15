module Crystalg::DataStructures
  # A leftist heap is a priority queue allowed merging heaps.
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

    # Pushes a new value to heap. `O(log n)`
    #
    # ```
    # heap = LeftistHeap(Int32).new
    # heap.push(2)
    # heap.top # => 2
    # ```
    def push(x)
      @root =
        if @root.nil?
          Node(T).new x
        else
          merge(@root.as(Node(T)), Node(T).new x)
        end

        self
    end

    # Returns the higheset priority value or nil if heap is empty. `O(1)`.
    #
    # ```
    # heap = LeftistHeap(Int32).new
    #
    # heap.top # => nil
    # heap.push(1).top # => 1
    # ```
    def top
      @root.try &.value
    end

    # Pops the highest priority value from heap. `O(log n)`.
    #
    # ```
    # heap = LeftistHeap(Int32).new
    #
    # heap.push(3).push(2).push(1)
    # heap.pop
    # heap.top # => 2
    # ```
    def pop
      return if @root.nil?
      root = @root.as(Node(T))
      @root = merge(root.left, root.right)

      self
    end
  end
end
