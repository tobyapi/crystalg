module Crystalg::DataStructures
  # A leftist heap is a priority queue allowed merging heaps.
  class LeftistHeap(T)
    private class Node(T)
      property rank : Int32
      property left : Node(T)?
      property right : Node(T)?
      getter value : T

      def initialize(@value)
        @rank = 0
        @left = nil
        @right = nil
      end
    end

    #:nodoc:
    setter root : Node(T)?
    @root : Node(T)? = nil

    private def meld(a : Node(T)?, b : Node(T)?)
      return b if a.nil?
      return a if b.nil?
      a, b = b, a if a.value > b.value
      a.right = meld(a.right, b)
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
    def push(x : T)
      @root =
        if @root.nil?
          Node(T).new(x)
        else
          meld(@root.as(Node(T)), Node(T).new x)
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
    def top : T?
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
      @root = meld(root.left, root.right)

      self
    end

    # Adds all elements of the meldable heap Q passed as parameter to this heap, and then emptying Q. `O(log n)`.
    #
    # ```
    # heap1 = LeftistHeap(Int32).new
    # heap2 = LeftistHeap(Int32).new
    # [1, 2, 3].each { |e| heap1.push(e) }
    # [4, 5, 6].each { |e| heap2.push(e) }
    #
    # heap1.absorb(heap2)
    #
    # heap2.top # => nil
    #
    # heap1.top     # => 1
    # heap1.pop.top # => 2
    # heap1.pop.top # => 3
    # heap1.pop.top # => 4
    # heap1.pop.top # => 5
    # heap1.pop.top # => 6
    # heap1.pop.top # => nil
    # ```
    def absorb(other : LeftistHeap(T))
      @root = meld(@root, other.@root)
      other.root = nil

      self
    end
  end
end
