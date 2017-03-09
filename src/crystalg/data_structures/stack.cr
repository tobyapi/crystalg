

module Crystalg::DataStructures
  class Stack(A)
    private getter array : Array(A)
    private setter array

    def initialize
      @array = Array(A).new
    end

    def push(val : A) : Nil
      @array << val
    end

    def pop : Nil
      @array.pop?
    end
    
    def pop! : (A | Nil)
      result = @array.last?
      @array.pop?
      result
    end
    
    def top() : (A | Nil)
      @array.last?
    end
    
    def empty?
      @array.empty?
    end
  end
end
