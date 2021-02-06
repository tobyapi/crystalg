module Crystalg::DataStructures
  # Fenwick Tree can efficiently update elements and calculate prefix sums
  # in a table of numbers. Type argument `T` must be the Group.
  #
  # ```
  # fenwick = FenwickTree(Int32).new(5)
  #
  # fenwick[0] = 1
  # fenwick[1] = 3
  # fenwick[2] = 5
  # fenwick[3] = 7
  # fenwick[4] = 11
  #
  # # sum method returns sum of [0, index). If given index is 0, returns 0.
  # fenwick.sum(0) # => 0
  # fenwick.sum(3) # => 9
  # fenwick.sum(5) # => 27
  # ```
  class FenwickTree(T)
    @size : Int32

    # Creates FenwickTree(T).
    def initialize(@size : Int32)
      @data = Array(T).new(@size * 2 - 1, T.zero)
    end

    # Sets the given value at the given index. `O(log n)`.
    def []=(index : Int, value : T)
      key = index + 1
      while key <= @size
        @data[key] += value
        key = key + (key & -key)
      end
    end

    # Adds elements that index less than or equeals `key` in the collection together. `O(log n)`.
    def sum(index : Int)
      result = T.zero
      while index > T.zero
        result += @data[index]
        index = index - (index & -index)
      end
      result
    end
  end
end
