require "../core/atomic_stamped_int32"

class TimeoutException < Exception
end

class Exchanger(T)
  EMPTY = 0
  WAITING = 1
  BUSY = 2

  @slot : AtomicStampedReference(T?)
  
  def initialize
    @slot = AtomicStampedReference(T?).new
  end
  
  def exchange(my_item : T, timeout : Time::Span): T?
    start_time = Time.now
    loop do
      raise TimeoutException.new if timeout <= Time.now - start_time
      yr_item, stamp_holder = @slot.get
      stamp = stamp_holder
      case stamp
      when EMPTY
        _, is_success = @slot.compare_and_set(yr_item, my_item, EMPTY, WAITING)
        if is_success
          while Time.now - start_time < timeout
            yr_item, stamp_holder = @slot.get
            if stamp_holder == BUSY
              @slot.set(nil, EMPTY)
              return yr_item
            end
          end
          _, is_success = @slot.compare_and_set(my_item, nil, WAITING, EMPTY)
          raise TimeoutException.new if is_success
          yr_item, stamp_holder = @slot.get
          @slot.set(nil, EMPTY)
          return yr_item
        end
      when WAITING
        _, is_success = @slot.compare_and_set(yr_item, my_item, WAITING, BUSY)
        return yr_item if is_success
      when BUSY
      else
        raise "you've found a bug in the exchanger."
      end
    end
  end
end