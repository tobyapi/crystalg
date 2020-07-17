module Crystalg::DataStructures
  # A stack is a first-in-last-out data structure. In a FILO data structure, 
  # the first element added to the queue will be the last one to be removed.
  #
  # ```
  # stack = Stack(Int32).new
  # stack.push(1).push(2).push(3)
  #
  # puts stack.pop! # => 3
  # puts stack.pop! # => 2
  # puts stack.pop! # => 1
  # ```
  class Stack(T)
    def initialize
      @array = Array(T).new
    end

    def push(val : T)
      @array << val
      self
    end

    def pop
      @array.pop?
      self
    end

    def pop!: T?
      result = @array.last?
      @array.pop?
      result
    end

    def top: T?
      @array.last?
    end

    def empty?
      @array.empty?
    end
  end
end
