module Crystalg::Graph
  class Bridges
    @k : Int32
    @used : Array(Bool)
    @order : Array(Int32)
    @lowlink : Array(Int32)
    @parent : Array(Int32)

    private getter k, used, order, lowlink, parent, bridges, graph
    private setter k, used, order, lowlink, parent, bridges

    getter articulation_points

    def initialize(@graph : UndirectedGraph)
      @k = 0
      @used = Array(Bool).new(graph.@size, false)
      @order = Array(Int32).new(graph.@size, 0)
      @lowlink = Array(Int32).new(graph.@size, 0)
      @parent = Array(Int32).new(graph.@size, -1)
      @bridges = Array(Edge).new
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
          bridges << Edge.new(Math.min(u, edge.@to), Math.max(u, edge.@to), edge.@cost) if order[u] < lowlink[edge.@to]
        elsif edge.@to != prev
          lowlink[u] = Math.min(lowlink[u], order[edge.@to])
        end
      end
    end

    def all : Array(Edge)
      bridges.clear
      dfs(0)
      bridges
    end
  end
end
