require "atomic"
require "time/span"

# TimeOut Lock
class TOLock

  class QNode
    property pred : QNode?

    def initialize
      @pred = nil
    end
  end

  AVAILABLE = QNode.new
  @tail : Atomic(QNode?)
  @[ThreadLocal]
  @my_node : QNode

  def initialize
    @tail = Atomic(QNode?).new(nil)
    @my_node = QNode.new
  end

  def lock
    qnode = QNode.new
    @my_node = qnode
    my_pred = @tail.swap(qnode)
    return true if my_pred.nil? || my_pred.pred == AVAILABLE
    loop do
      pred_pred = my_pred.pred
      return if pred_pred == AVAILABLE
      my_pred = pred_pred unless pred_pred.nil?
    end
  end

  def unlock
    qnode = @my_node
    _, is_success = @tail.compare_and_set(qnode, nil)
    qnode.pred = AVAILABLE if !is_success
  end

  def try_lock(patience : Time::Span)
    start_time = Time.now
    qnode = QNode.new
    @my_node = qnode
    my_pred = @tail.swap(qnode)
    return true if my_pred.nil? || my_pred.pred == AVAILABLE
    while Time.now - start_time < patience
      pred_pred = my_pred.pred
      return true if pred_pred == AVAILABLE
      my_pred = pred_pred if !pred_pred.nil?
    end
    _, is_success = @tail.compare_and_set(qnode, my_pred)
    qnode.pred = my_pred if !is_success
    false
  end
end
