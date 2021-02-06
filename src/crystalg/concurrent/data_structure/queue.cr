module Crystalg::Concurrent::DataStructure
  class Node(T)
    getter value : T?
    property next : Atomic(Node(T)?)

    def initialize(@value = nil)
      @next = Atomic(Node(T)?).new(nil)
    end
  end

  class Queue(T)
    @head : Atomic(Node(T))
    @tail : Atomic(Node(T))

    def initialize
      @head = @tail = Atomic(Node(T)).new(Node(T).new)
    end

    def enqueue(value : T)
      node = Node(T).new(value)
      loop do
        last = @tail.get
        nxt = last.next.get
        next if last != @tail.get
        if nxt.nil?
          _, is_success = last.next.compare_and_set(nxt, node)
          if is_success
            @tail.compare_and_set(last, node)
            return
          end
        else
          @tail.compare_and_set(last, nxt)
        end
      end
    end

    def dequeue : T?
      loop do
        first = @head.get
        last = @tail.get
        nxt = first.next.get
        next if first != @head.get
        if first == last
          raise EmptyException.new if nxt.nil?
          @tail.compare_and_set(last, nxt)
        else
          nxt = nxt.as(Node(T))
          value = nxt.value
          return value if @head.compare_and_set(first, nxt)
        end
      end
    end
  end
end
