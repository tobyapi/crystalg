
module Crystalg::DataStructures
  class UnionFind
    def initialize(@size : Int32)
      @data = Array(Int32).new(@size, -1)
    end
    
    def unite(x : Int32, y : Int32) : Nil
      x = root x
      y = root y
      if x != y
        x, y = y, x if @data[y] < @data[x]
        @data[x] += @data[y]
        @data[y] = x
      end
    end

    def same?(x : Int32, y : Int32) : Bool
      root(x) == root(y)
    end
    
    def size(x : Int32) : Int32
      -@data[root x]
    end
    
    private def root(x  : Int32) : Int32
      @data[x] < 0 ? x : (@data[x] = root @data[x]);
    end
  end
end