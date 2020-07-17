require "atomic"
require "./lock"

module Crystalg::Concurrent::Lock
  class ALock
    include Lock

    @[ThreadLocal]
    @my_slot_index : Int32
    @tail : Atomic(Int32)
    @size : Int32
    @flag : Array(Bool)
    
    def initialize(@size)
      @my_slot_index = 0
      @tail = Atomic(Int32).new(0)
      @flag = Array(Bool).new(@size, false)
      @flag[0] = true
    end
    
    def lock
      slot = @tail.add(1) % @size
      @my_slot_index = slot
      loop { break if @flat[slot] }
    end
    
    def unlock
      slot = @my_slot_index
      @flag[slot] = false
      @flag[(slot + 1) % @size] = true
    end
  end
end