require "atomic"

module Crystalg::Concurrent::Core
  class AtomicStampedReference(T)
    private class A(T)
      def initialize(@value : T?, @stamp : Int32)
      end

      def unwrap
        {@value, @stamp}
      end
    end

    @ref : Atomic(A(T))

    def initialize(value : T?, stamp : Int32)
      @ref = Atomic(A(T)).new(A(T).new(value, stamp))
    end

    def compare_and_set(expected_ref : T?, new_ref : T?, expected_stamp : Int, new_stamp : Int32)
      old_wrapped_ref = @ref.get
      old_ref, old_stamp = old_wrapped_ref.unwrap

      if old_ref == expected_ref && old_stamp == expected_stamp
        new_wrapped_ref = A(T).new(new_ref, new_stamp)
        result, is_success = @ref.compare_and_set(old_wrapped_ref, new_wrapped_ref)
        return result.unwrap if is_success
      end
      return nil, false
    end

    def get : Tuple(T?, Int32)
      @ref.get.unwrap
    end

    def set(ref : T?, stamp : Int32)
      @ref.set(A(T).new(ref, stamp))
    end
  end
end
