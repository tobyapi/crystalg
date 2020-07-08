module Crystalg::DataStructures
  class PriorityQueue(A)
    getter size : UInt32

    def initialize(@mode = :min)
      Helper.assert(@mode == :min || @mode == :max)
      @heap = Array(A).new
      @size = 0_u32
    end

    def push(val)
      @heap << val
      i = @size
      @size += 1
      while 0 < i
        parent = ((i - 1) / 2).to_i
        break if @mode == :min && @heap[parent] <= val
        break if @mode == :max && val <= @heap[parent]
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
        if (@mode == :min && child < @size && @heap[child + 1] < @heap[child]) ||
           (@mode == :max && child < @size && @heap[child] < @heap[child + 1])
          child += 1
        end
        break if @mode == :min && x <= @heap[child]
        break if @mode == :max && @heap[child] <= x
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
