

module Crystalg::DataStructures
  class Stack(A)
    private property array : Array(A)

    def initialize
      @array = Array(A).new
    end

    def push(val)
      array << val
    end

    def pop
      array.pop?
    end
    
    def pop!
      result = array.last?
      array.pop?
      result
    end
    
    def top
      array.last?
    end
    
    def empty?
      array.empty?
    end
  end
end
