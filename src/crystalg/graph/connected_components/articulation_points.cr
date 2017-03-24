require "../*"

module Crystalg::Graph

  class ArticulationPoints
    @k : Int32
    @used : Array(Bool)
    @order : Array(Int32)
    @lowlink : Array(Int32)
    @parent : Array(Int32)

    private getter k, used, order, lowlink, parent, graph
    private setter k, used, order, lowlink, parent

    getter articulation_points

    def initialize(@graph : UndirectedGraph)
      @k = 0
      @used = Array(Bool).new(graph.@size, false)
      @order = Array(Int32).new(graph.@size, 0)
      @lowlink = Array(Int32).new(graph.@size, 0)
      @parent = Array(Int32).new(graph.@size, -1)
    end

    def dfs(u : NodeID, prev : NodeID = -1)
      used[u] = true
      order[u] = lowlink[u] = @k
      @k += 1

      graph.get_adjecent(u).each do |edge|
        if !used[edge.@to]
          parent[edge.@to] = u
          dfs(edge.@to, u)
          lowlink[u] = Math.min(lowlink[u], lowlink[edge.@to])
        elsif edge.@to != prev
          lowlink[u] = Math.min(lowlink[u], order[edge.@to])
        end
      end
    end

    def all : Array(NodeID)
      count = 0
      result = Array(NodeID).new
      dfs(0)
      (0...graph.@size).each do |i|
        count += 1 if parent[i] == 0 && i != 0
        result << parent[i] if parent[i] > 0 && lowlink[i] >= order[parent[i]]
      end
      result << 0 if count >= 2
      result.sort!.uniq!
    end
  end
end
