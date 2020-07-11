module Crystalg::DataStructures
  class FenwickTree2D(T)
    @size_x : Int32
    @size_y : Int32

    def initialize(@size_x, @size_y)
      @data = Array(FenwickTree(T)).new(@size_y * 2 - 1) {
        FenwickTree(T).new(@size_x * 2 - 1)
      }
    end

    def []=(x, y, value)
      y += 1
      while y <= @size_y
        @data[y][x] = value
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
