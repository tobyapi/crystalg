

module Crystalg::DataStructures
  class Queue(A)
    private getter array : Array(A)
    private setter array

    def initialize
      @array = Array(A).new
    end

    def push(val : A) : Nil
      @array << val
    end

    def pop : Nil
      @array.shift?
    end
    
    def pop! : (A | Nil)
      result = @array.first?
      @array.shift?
      result
    end
    
    def top() : (A | Nil)
      @array.first?
    end
    
    def empty?
      @array.empty?
    end
  end
end
