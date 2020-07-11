module Crystalg::DataStructures
  # FenwickTree2D is FenwickTree extended 2D.
  # 
  # ```
  # fenwick = FenwickTree2D(Int32).new(3, 4)
  #
  # # Create following grid:
  # #  1  2  3
  # #  4  5  6
  # #  7  8  9
  # # 10 11 12
  #
  # fenwick[0, 0] = 1
  # fenwick[1, 0] = 2
  # fenwick[2, 0] = 3
  # fenwick[0, 1] = 4
  # fenwick[1, 1] = 5
  # fenwick[2, 1] = 6
  # fenwick[0, 2] = 7
  # fenwick[1, 2] = 8
  # fenwick[2, 2] = 9
  # fenwick[0, 3] = 10
  # fenwick[1, 3] = 11
  # fenwick[2, 3] = 12
  #
  # # Sum of the above grid is:
  # # 0   0   0   0
  # # 0   1   3   6 
  # # 0   5  12  21
  # # 0  12  27  45
  # # 0  22  48  78
  # 
  # fenwick.sum(0, 0) # => 0
  # fenwick.sum(2, 0) # => 0
  # fenwick.sum(2, 3) # => 27
  # fenwick.sum(2, 4) # => 48
  # ```
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
