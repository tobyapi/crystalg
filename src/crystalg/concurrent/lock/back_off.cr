module Crystalg::Concurrent::Lock
  class BackOff
    @min_delay : Int32
    @max_delay : Int32
    @limit : Int32
    
    def initialize(@min_delay, @max_delay)
      @limit = @min_delay
      @random = Random.new()
    end
    
    def back_off
      delay = @random.rand(@limit)
      @limit = Math.min(@max_delay, 2 * @limit)
      sleep delay.milliseconds
    end
  end
end