module Crystalg::DataStructures
  class Queue(A)
    def initialize
      @array = Array(A).new
    end

    def push(val)
      @array << val
    end

    def pop
      @array.shift?
    end

    def pop!
      result = @array.first?
      @array.shift?
      result
    end

    def top
      @array.first?
    end

    def empty?
      @array.empty?
    end
  end
end
