require "atomic"
require "./lock"

module Crystalg::Concurrent::Lock
  class TASLock
    include Lock

    @state : Atomic(Int8)

    def initialize
      @state = Atomic(Int8).new(0)
    end

    def lock
      loop { break if @state.swap(1) == 0 }
    end

    def unlock
      @state.set(0)
    end
  end
end
