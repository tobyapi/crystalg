require "atomic"
require "./lock"

module Crystalg::Concurrent::Lock
  class TTASLock
    include Lock

    @state : Atomic(Int8)
    
    def initialize
      @state = Atomic(Int8).new(0)
    end
    
    def lock
      loop do
        loop { break if @state.get == 0 }
        return if @state.swap(1) == 0
      end
    end
    
    def unlock
      @state.set(0)
    end
  end
end