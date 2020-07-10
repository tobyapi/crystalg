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

    private def child_index(k : Int32): Tuple(Int32, Int32)
      {k * 2 + 1, k * 2 + 2}
    end

    private def propagate(k : Int32)
      @value[k] += @delta[k]
      if k + 1 < @n
        left, right = child_index(k)
        @delta[left] += @delta[k]
        @delta[right] += @delta[k]
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
        left_child, right_child = child_index(k)
        mid = ((l + r) / 2).to_i
        add(a, b, v, left_child, l, mid)
        add(a, b, v, right_child, mid, r)
        @value[k] = Math.min(@value[left_child], @value[right_child])
      end
    end

    private def min(a, b, k, l, r)
      propagate k
      return T::MAX if r <= a || b <= l
      return @value[k] if a <= l && r <= b
      left_child, right_child = child_index(k)
      mid = ((l + r) / 2).to_i
      left_result = min(a, b, left_child, l, mid)
      right_result = min(a, b, right_child, mid, r)
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
