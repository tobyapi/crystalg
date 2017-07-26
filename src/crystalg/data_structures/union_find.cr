
module Crystalg::DataStructures
  class UnionFind
    getter size : Int32
    
    def initialize(@size)
      @data = Array(Int32).new(@size, -1)
    end
    
    def unite(x, y)
      x = root x
      y = root y
      if x != y
        x, y = y, x if @data[y] < @data[x]
        @data[x] += @data[y]
        @data[y] = x
      end
    end

    def same?(x, y)
      root(x) == root(y)
    end
    
    def size(x)
      @data[root x].abs
    end
    
    private def root(x)
      @data[x] < 0 ? x : (@data[x] = root @data[x])
    end
  end
end