
module Crystalg::DataStructures
  class PriorityQueue(A)
    getter array : Array(A)
    getter size : Int32
    
    def initialize()
      @array = Array(A).new
      @size = 0
    end

    def push(val : A) : Nil
      @array << val
      
      i = @size
      @size += 1
      while(i > 0)
        parent = (i - 1) / 2
        break if @array[parent] <= val
        @array[i] = @array[parent]
        i = parent
      end
      @array[i] = val
    end

    def pop : Nil
      @size -= 1
      x = @array[@size]
      
      i = 0
      while(i * 2 + 1 < @size)
        left_child = i * 2 + 1
        right_child = i * 2 + 2
        left_child = right_child if left_child < @size && @array[right_child] < @array[left_child]
        break if @array[left_child] >= x
        @array[i] = @array[left_child]
        i = left_child
      end
      @array[i] = x
    end
    
    def pop! : (A | Nil)
      if !empty?()
        result = top
        pop
        result
      end
    end
    
    def top() : (A | Nil)
      @array.first?
    end
    
    def empty?
      @size == 0
    end
  end
end
