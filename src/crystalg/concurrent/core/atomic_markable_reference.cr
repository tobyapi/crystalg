require "atomic"

require "./markable_reference"

module Crystalg::Concurrent::Core
  class AtomicMarkableReference(T)
    MASK = 1_u64
    @word : Atomic(UInt64)

    def initialize(reference : T, mark = false)
      @word = pack(reference, mark)
    end
    
    def compare_and_set(expected_reference : T, new_reference : T, expected_mark : Bool, new_mark : Bool): Tuple(T, Bool)
      expected_value = pack(expected_reference, expected_mark)
      new_value = pack(new_reference, new_mark)
      _, is_success = @word.compare_and_set(expected_value, new_value)
      return {nil, false} if !is_success
      {get(new_mark), true}
    end
    
    def attempt_mark(expected_reference : T, new_mark : Bool): Bool
      _, is_succsess = compare_and_set(expected_reference, expected_reference, !new_mark, new_mark)
      is_succsess
    end
    
    def get(marked : Bool): Tuple(T, Bool)
      {Pointer(T).new(@word & ~MASK).value, (@word & MASK) == 1_u64}
    end
    
    private def pack(reference : T, mark : Bool)
      word = (pointerof(reference).address & ~MASK)
      if mark
        word | 1_u64
      else
        word | 0_u64
      end
    end
  end
end