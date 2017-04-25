
module Crystalg::Trees
  class FenwickTree2D(T)
    
    getter size_x, size_y, data
    private setter data
    
    def initialize(@size_x : Int32, @size_y : Int32)
      @data = Array(Array(T)).new(@size_y * 2 - 1) {
        Array(T).new(@size_x * 2 - 1, T.zero)
      }
    end

    def add(_x, y, value)
      while y <= size_y
        x = _x
        while x <= size_x
          data[y][x] = data[y][x] + value
          x = x + (x & -x)
        end
        y = y + (y & -y)
      end
    end

    def sum(_x, y)
      result = T.zero
      while y > T.zero
        x = _x
        while x > T.zero
          result = result + data[y][x]
          x = x - (x & -x)
        end
        y = y - (y & -y)
      end
      result
    end
  end
end
