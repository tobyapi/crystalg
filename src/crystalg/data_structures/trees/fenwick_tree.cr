
module Crystalg::Trees
  class FenwickTree(T)
    getter size, data
    private setter data
    
    def initialize(@size : Int32)
      @data = Array(T).new(@size * 2 - 1, T.zero)
    end

    def add(key, value)
      while key <= size
        data[key] = data[key] + value
        key = key + (key & (-key))
      end
    end

    def sum(key)
      result = T.zero
      while key > T.zero
        result = result + data[key]
        key = key - (key & -key)
      end
      result
    end
  end
end
