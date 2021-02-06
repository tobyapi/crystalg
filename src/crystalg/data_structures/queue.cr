module Crystalg::DataStructures
  # A queue is a first-in-first-out data structure. In a FIFO data structure,
  # the first element added to the queue will be the first one to be removed.
  #
  # ```
  # queue = Queue(Int32).new
  # queue.push(1).push(2).push(3)
  #
  # puts queue.pop! # => 1
  # puts queue.pop! # => 2
  # puts queue.pop! # => 3
  # ```
  class Queue(T)
    def initialize
      @array = Array(T).new
    end

    def push(val : T)
      @array << val
      self
    end

    def pop
      @array.shift?
      self
    end

    def pop! : T?
      result = @array.first?
      @array.shift?
      result
    end

    def top : T?
      @array.first?
    end

    def empty?
      @array.empty?
    end
  end
end
