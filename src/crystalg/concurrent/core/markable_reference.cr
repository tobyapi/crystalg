module Crystalg::Concurrent::Core
  class MarkableReference(T)
    MASK = 1
    @value : UInt64
    
    def initialize(reference : T, mark = false)
      @value = (pointerof(reference).address & ~MASK)
      @value |= 1 if mark
    end

    def reference : T
      Pointer(T).new(@value & ~MASK).value
    end

    def mark : Bool
      (@value & MASK) == 1
    end
  end
end