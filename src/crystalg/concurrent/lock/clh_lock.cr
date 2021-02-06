require "atomic"
require "./lock"

module Crystalg::Concurrent::Lock
  class CLHLock
    include Lock

    class QNode
      property locked

      def initialize
        @locked = false
      end
    end

    @tail : Atomic(QNode)
    @[ThreadLocal]
    @my_pred : QNode?
    @[ThreadLocal]
    @my_node : QNode

    def initialize
      @tail = Atomic(QNode).new(QNode.new)
      @my_node = QNode.new
      @my_pred = nil
    end

    def lock
      qnode = @my_node
      qnode.locked = true
      pred = @tail.swap(qnode)
      @my_pred = pred
      loop { break if !pred.locked }
    end

    def unlock
      my_pred = @my_pred
      raise "Attempt to unlock a mutex which is not locked" if my_pred.nil?
      qnode = @my_node
      qnode.locked = false
      @my_node = my_pred
    end
  end
end
