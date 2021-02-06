module Crystalg::DataStructures
  # A randomized meldable heap is a priority queue allowed merging heaps
  # by supporting internal method called meld.
  class RandomizedMeldableHeap(T)
    # :nodoc:
    class Node(T)
      property value : T
      property left : Node(T)?
      property right : Node(T)?

      def initialize(@value : T)
      end
    end

    # :nodoc:
    property root : Node(T)?

    @rng : Crystalg::Random::Xor128
    @size : Int32

    # Creates a new `RandomizedMeldableHeap(T)`. The `order` parameter must be `:min` or `:max`.
    def initialize(@order = :min, seed : UInt64 = 123456789)
      Helper.assert(@order == :min || @order == :max)
      @rng = Crystalg::Random::Xor128.new(seed)
      @root = nil
      @size = 0
    end

    # :nodoc:
    def meld(q1 : Node(T)?, q2 : Node(T)?)
      return q2 if q1.nil?
      return q1 if q2.nil?
      q1, q2 = q2, q1 if @order == :min && q2.value < q1.value
      q1, q2 = q2, q1 if @order == :max && q1.value < q2.value

      if @rng.get % 2 == 0
        q1.left = meld(q1.left, q2)
      else
        q1.right = meld(q1.right, q2)
      end
      q1
    end

    # Returns number of elements in a heap. 0 if a heap is empty. `O(1)`.
    #
    # ```
    # heap = RandomizedMeldableHeap(Int32).new
    #
    # heap.size         # => 0
    # heap.push(1).size # => 1
    # ```
    def size : Int32
      @size
    end

    # Pushes a new value to heap. `O(log n)`
    #
    # ```
    # heap = RandomizedMeldableHeap(Int32).new
    # heap.push(2)
    # heap.top # => 2
    # ```
    def push(value : T)
      @root = meld(Node(T).new(value), @root)
      return if @root.nil?
      @size += 1

      self
    end

    # Pops the highest priority value from heap. `O(log n)`.
    #
    # ```
    # heap = RandomizedMeldableHeap(Int32).new
    #
    # heap.push(3).push(2).push(1)
    # heap.pop
    # heap.top # => 2
    # ```
    def pop
      return if @root.nil?
      @root = meld(@root.as(Node(T)).left, @root.as(Node(T)).right)
      @size -= 1

      self
    end

    # Returns the higheset priority value or nil if heap is empty. `O(1)`.
    #
    # ```
    # heap = RandomizedMeldableHeap(Int32).new
    #
    # heap.top         # => nil
    # heap.push(1).top # => 1
    # ```
    def top
      @root.as(Node(T)).value if !@root.nil?
    end

    private def remove_rec(node : Node(T)?, value : T) : Node(T)?
      return nil if node.nil?
      return node if @order == :min && value < node.value
      return node if @order == :max && node.value < value
      while !node.nil? && node.value == value
        node = meld(node.left, node.right)
      end
      return nil if node.nil?
      node.left = remove_rec(node.left, value)
      node.right = remove_rec(node.right, value)
      node
    end

    # Removes all values equal a parameter from heap. `O(k log n)`. `k` is number of removed elements.
    #
    # ```
    # heap = RandomizedMeldableHeap(Int32).new
    #
    # [10, 1, 2, 2, 2, 11, 2].each { |e| heap.push(e) }
    #
    # heap.remove(2)
    #
    # heap.top     # => 1
    # heap.pop.top # => 10
    # heap.pop.top # => 11
    # heap.pop.top # => nil
    # ```
    def remove(value : T)
      @root = remove_rec(@root, value)
      self
    end

    # Adds all elements of the meldable heap Q passed as parameter to this heap, and then emptying Q. `O(log n)`.
    #
    # ```
    # heap1 = RandomizedMeldableHeap(Int32).new
    # heap2 = RandomizedMeldableHeap(Int32).new
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
    def absorb(other : RandomizedMeldableHeap(T))
      @root = meld(@root, other.root)
      other.root = nil
      self
    end
  end
end
