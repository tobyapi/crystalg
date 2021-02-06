module Crystalg::DataStructures
  # FenwickTree2D is FenwickTree extended 2D.
  #
  # ```
  # fenwick = FenwickTree2D(Int32).new(4, 3)
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
    @width : Int32
    @height : Int32

    # Creates FenwickTree2D(T).
    def initialize(@height, @width)
      @data = Array(FenwickTree(T)).new(@height * 2 - 1) {
        FenwickTree(T).new(@width * 2 - 1)
      }
    end

    # Sets the given value at the given row and column. `O(log^2 n)`.
    def []=(row, col, value)
      row += 1
      while row <= @height
        @data[row][col] = value
        row = row + (row & -row)
      end
    end

    # Adds elements in a square surrounded [0, row) and [0, col). `O(log^2 n)`.
    def sum(row, col)
      result = T.zero
      while row > T.zero
        result += @data[row].sum col
        row = row - (row & -row)
      end
      result
    end
  end
end
