module Crystalg::DataStructures
  class PersistentUnionFind
    def initialize(size)
      @parent = Array(Array(Tuple(NodeID, Int32))).new(size) { [{-1, 0}] }
      @current = 0
    end

    def unite(u : NodeID, v : NodeID) : Bool
      @current += 1
      u, v = root(u, @current), root(v, @current)
      return false if u == v
      u, v = v, u if @parent[u].last.first > @parent[v].last.first
      @parent[u] << {@parent[u].last.first + @parent[v].last.first, @current}
      @parent[v] << {u, @current}
      true
    end

    def same?(u : NodeID, v : NodeID, time : Int32) : Bool
      root(u, time) == root(v, time)
    end

    def root(u : NodeID, time : NodeID) : NodeID
      parent_id, parent_time = @parent[u].last
      return root(parent_id, time) if parent_id >= 0 && parent_time <= time
      u
    end

    def size(u : NodeID, time : NodeID) : Int32
      u = root(u, time)
      left, right = 0, @parent[u].size
      while right - left > 1
        middle = (left + right) / 2
        if @parent[u][middle].last <= time
          left = middle
        else
          right = middle
        end
      end
      -@parent[u][left].first
    end
  end
end
