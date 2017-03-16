
module Crystalg::Trees
  class FenwickTree(T)
    def initialize(@size : Int32)
      @data = Array(T).new(@size * 2 - 1, 0)
    end

    def add(key : Int32, value : T)
      while key <= @size
        @data[key] = @data[key] + value
        key = key + (key & (-key))
      end
    end

    def sum(key : Int32): T
      result = 0
      while key > 0
        result = result + @data[key]
        key = key - (key & -key)
      end
      result
    end
  end
end
