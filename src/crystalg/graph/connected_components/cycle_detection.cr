require "../*"

module Crystalg::Graph
  class CycleDetection(T)
    private getter used, flag
    private setter used

    @used : Array(Int32)
    @flag : Bool

    def initialize(@graph : DirectedGraph(T))
      @used = Array(Int32).new(@graph.size, 0)
      @flag = false
    end

    private def dfs(u : NodeID)
      return if used[u] == 1 || flag
      used[u] = 2
      @graph.adjacent(u).each do |e|
        if used[e.target] == 2
          @flag = true
          return
        end
        dfs(e.target) if used[e.target] == 0
      end
      used[u] = 1
    end

    def has_cycle?
      (0...@graph.@size).each do |node_id|
        dfs node_id
      end
      flag
    end
  end
end
