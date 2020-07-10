module Crystalg::DataStructures

  # A PriorityQueue is a queue ordered by priority of elements.
  #
  # ```
  # min_heap = PriorityQueue(Int32).new
  # [10, 8 , 2, 11].each { |e| min_heap.push(e) }
  # min_heap.top # => 2
  # min_heap.pop().top() # => 8
  #
  # min_heap.pop! # => 8
  # min_heap.top # => 10
  #
  # max_heap = PriorityQueue(Int32).new(:max)
  # [10, 8 , 2, 11].each { |e| max_heap.push(e) }
  # max_heap.pop! # => 11
  # max_heap.pop! # => 10
  # max_heap.pop! # => 8
  # max_heap.pop! # => 2
  # ```
  class PriorityQueue(A)
    getter size : UInt32

    # Creates a new `PriorityQueue`. The `order` parameter must be `:min` or `:max`.
    #
    # ```
    # queue = PriorityQueue(Int32).new
    # queue = PriorityQueue(Int32).new(:min)
    # queue = PriorityQueue(Int32).new(:max)
    # ```
    def initialize(@order = :min)
      Helper.assert(@order == :min || @order == :max)
      @heap = Array(A).new
      @size = 0_u32
    end

    # Append. This method returns self, so several calls can be chained.
    def push(val : A)
      @heap << val
      i = @size
      @size += 1
      while 0 < i
        parent = ((i - 1) / 2).to_i
        break if @order == :min && @heap[parent] <= val
        break if @order == :max && val <= @heap[parent]
        @heap[i] = @heap[parent]
        i = parent
      end
      @heap[i] = val
      self
    end

    # Removes the highest priority value based on `order` property. This method returns self, so several calls can be chained.
    def pop
      @size -= 1
      x = @heap[@size]
      pos = 0
      loop do
        child = 2 * pos + 1
        break if @size <= child
        if (@order == :min && child < @size && @heap[child + 1] < @heap[child]) ||
           (@order == :max && child < @size && @heap[child] < @heap[child + 1])
          child += 1
        end
        break if @order == :min && x <= @heap[child]
        break if @order == :max && @heap[child] <= x
        @heap[pos] = @heap[child]
        pos = child
      end
      @heap[pos] = x
      self
    end

    # Removes the highest priority value based on `order` property and returns the removed value. Returns nil if PriorityQueue is empty.
    def pop!: A?
      return if empty?
      result = top
      pop
      result
    end

    # Returns the highest priority value without removing the value. Returns nil if PriorityQueue is empty.
    def top: A?
      @heap.first?
    end

    # Returns true if PriorityQueue is empty.
    def empty?: Bool
      @size == 0
    end
  end
end
