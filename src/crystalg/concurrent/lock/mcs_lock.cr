require "atomic"
require "./lock"

class MCSLock
  include Lock

  @tail : Atomic(QNode?)
  @[ThreadLocal]
  @my_node : QNode

  class QNode
    property locked, nxt
    
    @locked : Atomic(Int8)
    @nxt : QNode?
    
    def initialize
      @locked = Atomic(Int8).new(0)
      @nxt = nil
    end
  end

  
  def initialize
    @tail = Atomic(QNode?).new(nil)
    @my_node = QNode.new
  end
  
  def lock
    qnode = @my_node
    pred = @tail.swap(qnode)
    return if pred.nil?
    qnode.locked.set(1)
    pred.nxt = qnode
    loop { break if !qnode.locked }
  end
  
  def unlock
    qnode = @my_node
    if qnode.nxt.nil?
      _, is_success = @tail.compare_and_set(qnode, nil)
      return if is_success
      loop { break if !qnode.nxt.nil? }
    end
    nxt = qnode.nxt
    nxt.locked.set(0) if !nxt.nil?
    qnode.nxt = nil
  end
end