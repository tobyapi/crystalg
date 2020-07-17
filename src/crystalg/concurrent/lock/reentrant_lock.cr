require "./lock"

module Crystalg::Concurrent::Lock
  class ReentrantLock < Thread::Mutex
    include Lock
    
    @lock : Thread::Mutex
    @condition : Thread::ConditionVariable
    @owner : UInt64
    @hold_count : Int32
    
    def initialize(@lock = Thread::Mutex.new)
      @condition = Thread::ConditionVariable.new
      @owner = 0
      @hold_count = 0
    end
    
    def lock
      me = Fiber.current.hash
      @lock.lock
      begin
        if @owner == me
          @hold_count += 1
          return
        end
        while @hold_count != 0
          @condition.wait @lock
        end
        @owner = me
        @hold_count = 1
      ensure
        @lock.unlock
      end
    end
    
    def unlock
      @lock.lock
      begin
        raise "illegal monitor state" if @hold_count == 0 || @owner != Fiber.current.hash
        @hold_count -= 1
        @condition.signal if @hold_count == 0
      ensure
        @lock.unlock
      end
    end
  end
end