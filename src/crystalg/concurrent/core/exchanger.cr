require "./atomic_stamped_reference"

module Crystalg::Concurrent::Core
  class Exchanger(T)
    include Crystalg::Concurrent::Core

    EMPTY   = 0
    WAITING = 1
    BUSY    = 2

    getter slot

    @slot = Core::AtomicStampedReference(T).new(nil, 0)

    def exchange(my_item : T, timeout : Time::Span): T?
      start_time = Time.now
      loop do
        raise "timeout" if timeout < Time.now - start_time
        yr_item, stamp = @slot.get
        case stamp
        when EMPTY
          _, is_success = @slot.compare_and_set(yr_item, my_item, EMPTY, WAITING)
          next unless is_success
          while Time.now - start_time < timeout
            yr_item, stamp = @slot.get
            if stamp == BUSY
              @slot.set(nil, EMPTY)
              return yr_item
            end
          end
          _, is_success = @slot.compare_and_set(my_item, nil, WAITING, EMPTY)
          raise "timeout" if is_success
          yr_item, stamp = @slot.get
          @slot.set(nil, EMPTY)
          return yr_item
        when WAITING
          yr_item, is_success = @slot.compare_and_set(yr_item, my_item, WAITING, BUSY)
          return yr_item if is_success
        when BUSY
          next
        end
      end
    end
  end
end