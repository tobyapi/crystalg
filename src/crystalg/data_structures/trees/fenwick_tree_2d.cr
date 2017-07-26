
module Crystalg::Trees
  class FenwickTree2D(T)
    @size_x : UInt32
    @size_y : UInt32
    
    def initialize(@size_x, @size_y)
      @data = Array(FenwickTree(T)).new(@size_y * 2 - 1) {
        FenwickTree(T).new(@size_x * 2 - 1)
      }
    end

    def add(x, y, value)
      while y <= @size_y
        @data[y].add x, value
        y = y + (y & -y)
      end
    end

    def sum(x, y)
      result = T.zero
      while y > T.zero
        result += @data[y].sum x
        y = y - (y & -y)
      end
      result
    end
  end
end
