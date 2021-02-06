require "../lock/ttas_lock"

module Crystalg::Concurrent::DataStructure
  class UnboundedQueue(T)
    private class Node(T)
      getter value : T?
      property next : Node(T)?

      def initialize(@value = nil)
        @next = nil
      end
    end

    @enqueue_mutex : Crystalg::Concurrent::Lock::TTASLock
    @dequeue_mutex : Crystalg::Concurrent::Lock::TTASLock
    @head : Node(T)
    @tail : Node(T)

    def initialize
      @enqueue_mutex = Crystalg::Concurrent::Lock::TTASLock.new
      @dequeue_mutex = Crystalg::Concurrent::Lock::TTASLock.new
      @head = @tail = Node(T).new
    end

    def enqueue(value : T)
      @enqueue_mutex.lock
      begin
        e = Node(T).new(value)
        @tail.next = e
        @tail = e
      ensure
        @enqueue_mutex.unlock
      end
    end

    def dequeue : T?
      @dequeue_mutex.lock
      result = nil
      begin
        nxt = @head.next
        raise EmptyException.new if nxt.nil?
        result = nxt.value
        @head = @head.next.as(Node(T))
      ensure
        @dequeue_mutex.unlock
      end
      result
    end
  end
end
