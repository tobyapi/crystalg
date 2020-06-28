module Crystalg::DataStructures
  class PriorityQueue(A)
    getter size : UInt32

    def initialize
      @heap = Array(A).new
      @size = 0_u32
    end

    def push(val)
      @heap << val
      i = @size
      @size += 1
      while 0 < i
        parent = ((i - 1) / 2).to_i
        break if @heap[parent] <= val
        @heap[i] = @heap[parent]
        i = parent
      end
      @heap[i] = val
    end

    def pop
      @size -= 1
      x = @heap[@size]
      pos = 0
      loop do
        child = 2 * pos + 1
        break if @size <= child
        if child < @size && @heap[child + 1] < @heap[child]
          child += 1
        end
        break if x <= @heap[child]
        @heap[pos] = @heap[child]
        pos = child
      end
      @heap[pos] = x
    end

    def pop!
      return if empty?
      result = top
      pop
      result
    end

    def top
      @heap.first?
    end

    def empty?
      @size == 0
    end
  end
end
