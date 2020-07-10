struct Int
  def left
    self * 2 + 1
  end

  def right
    self * 2 + 2
  end
end

module Crystalg::DataStructures
  class SegmetTree(T)
    getter size : Int32

    def initialize(@size)
      @n = 1
      while @n < @size
        @n *= 2
      end
      @value = Array(T).new(@n * 2 + 1, T.zero)
      @delta = Array(T).new(@n * 2 + 1, T.zero)
    end

    private def propagate(k : Int32)
      @value[k] += @delta[k]
      if k + 1 < @n
        @delta[k.left] += @delta[k]
        @delta[k.right] += @delta[k]
      end
      @delta[k] = T.zero
    end

    private def add(a, b, v, k, l, r)
      propagate k
      return if r <= a || b <= l
      if a <= l && r <= b
        @delta[k] = @delta[k] + v
        propagate k
      else
        mid = ((l + r) / 2).to_i
        add(a, b, v, k.left, l, mid)
        add(a, b, v, k.right, mid, r)
        @value[k] = Math.min(@value[k.left], @value[k.right])
      end
    end

    private def min(a, b, k, l, r)
      propagate k
      return T::MAX if r <= a || b <= l
      return @value[k] if a <= l && r <= b
      mid = ((l + r) / 2).to_i
      left_result = min(a, b, k.left, l, mid)
      right_result = min(a, b, k.right, mid, r)
      Math.min(left_result, right_result)
    end

    def add(a, b, v)
      add(a, b, v, 0, 0, @size)
    end

    def min(a, b)
      min(a, b, 0, 0, @size)
    end
  end
end
