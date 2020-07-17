module Crystalg::DataStructures
  class UnionFind
    getter size : Int32

    def initialize(@size)
      @data = Array(Int32).new(@size, -1)
    end

    def unite(x : NodeID, y : NodeID)
      x = root(x)
      y = root(y)
      if x != y
        x, y = y, x if @data[y] < @data[x]
        @data[x] += @data[y]
        @data[y] = x
      end
    end

    def same?(x : NodeID, y : NodeID)
      root(x) == root(y)
    end

    def size(x : NodeID)
      @data[root(x)].abs
    end

    private def root(x : NodeID)
      @data[x] < 0 ? x : (@data[x] = root(@data[x]))
    end
  end
end
