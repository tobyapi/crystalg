require "./reentrant_lock"

# :nodoc:
class Thread
  # :nodoc:
  class ConditionVariable
    def wait(mutex : Thread::Mutex | ReentrantLock)
      ret = LibC.pthread_cond_wait(self, mutex)
      raise Errno.new("pthread_cond_wait", ret) unless ret == 0
    end
  end
end

module Crystalg::Concurrent::Lock
  class Semaphore
    @capacity : Int32
    @state : Int32
    @mutex : ReentrantLock
    @condition : Thread::ConditionVariable

    def initialize(@capacity)
      @state = 0
      @mutex = ReentrantLock.new
      @condition = Thread::ConditionVariable.new
    end

    def acquire
      @mutex.lock
      begin
        while @state == @capacity
          @condition.wait @mutex
        end
        @state += 1
      ensure
        @mutex.unlock
      end
    end

    def release
      @mutex.lock
      begin
        @state -= 1
        @condition.broadcast
      ensure
        @mutex.unlock
      end
    end
  end
end
