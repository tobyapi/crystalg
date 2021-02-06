require "atomic"
require "./back_off"

module Crystalg::Concurrent::Lock
  class WaitGroup
    @counter : Atomic(Int32)

    def initialize
      @counter = Atomic(Int32).new(0)
    end

    def add(delta : Int32)
      loop do
        _, is_success = @counter.add(delta)
        break if is_success
      end
    end

    def done
      add(-1)
    end

    def wait
      back_off = BackOff.new(1, 5)
      while @counter.get != 0
        back_off.back_off
      end
    end
  end
end
