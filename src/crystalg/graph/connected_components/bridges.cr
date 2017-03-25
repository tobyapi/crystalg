require "../*"

module Crystalg::Graph
  class Bridges(T)
    @k : Int32
    @used : Array(Bool)
    @order : Array(Int32)
    @lowlink : Array(Int32)
    @parent : Array(Int32)

    private getter k, used, order, lowlink, parent, bridges, graph
    private setter k, used, order, lowlink, parent, bridges

    getter articulation_points

    def initialize(@graph : UndirectedGraph(T))
      @k = 0
      @used = Array(Bool).new(graph.@size, false)
      @order = Array(Int32).new(graph.@size, 0)
      @lowlink = Array(Int32).new(graph.@size, 0)
      @parent = Array(Int32).new(graph.@size, -1)
      @bridges = Array(Edge(T)).new
    end

    def dfs(u : NodeID, prev : NodeID = -1)
      used[u] = true
      order[u] = lowlink[u] = @k
      @k += 1

      graph.adjacent(u).each do |edge|
        if !used[edge.target]
          parent[edge.target] = u
          dfs(edge.target, u)
          lowlink[u] = Math.min(lowlink[u], lowlink[edge.target])
          bridges << Edge.new(Math.min(u, edge.target), Math.max(u, edge.target), edge.cost) if order[u] < lowlink[edge.target]
        elsif edge.target != prev
          lowlink[u] = Math.min(lowlink[u], order[edge.target])
        end
      end
    end

    def all : Array(Edge(T))
      bridges.clear
      dfs(0)
      bridges
    end
  end
end
