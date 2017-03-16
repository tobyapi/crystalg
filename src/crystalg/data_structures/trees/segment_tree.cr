struct Int
  def left
    self * 2 + 1
  end

  def right
    self * 2 + 2
  end
end

module Crystalg::Trees
  class SegmetTree
    def initialize(@size : Int32)
      @n = 1
      while @n < @size
         @n = @n * 2
      end
      @value = Array(Int32).new(@n * 2 + 1, 0)
      @delta = Array(Int32).new(@n * 2 + 1, 0)
    end

    private def propagate(k : Int32)
      @value[k] = @value[k] + @delta[k]
      if k + 1 < @n
        @delta[k.left] = @delta[k.left] + @delta[k]
        @delta[k.right] = @delta[k.right] + @delta[k]
      end
      @delta[k] = 0
    end

    private def add(a : Int32, b : Int32, v : Int32, k : Int32, l : Int32, r : Int32)
      propagate k
      return if r <= a || b <= l
      if a <= l && r <= b
        @delta[k] = @delta[k] + v
        propagate k
      else
        mid = (l + r) / 2
        add(a, b, v, k.left, l, mid)
        add(a, b, v, k.right, mid, r)
        @value[k] = Math.min(@value[k.left], @value[k.right])
      end
    end

    private def min(a : Int32, b : Int32, k : Int32, l : Int32, r : Int32)
      propagate k
      return 2147483647 if r <= a || b <= l
      return @value[k] if a <= l && r <= b
      mid = (l + r) / 2
      left_result = min(a,b,k.left,l,mid)
      right_result = min(a,b,k.right,mid,r)
      Math.min(left_result, right_result)
    end

    def add(a : Int32, b : Int32, v : Int32)
      add(a, b, v, 0, 0, @size)
    end

    def min(a : Int32, b : Int32)
      min(a, b, 0, 0, @size)
    end
  end
end
