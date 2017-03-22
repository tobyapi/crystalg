require "./*"

module Crystalg::Graph
  class DirectedGraph < Graph
    def add(edge : Edge)
      @graph[edge.@from] << {edge.@to, edge.@cost}
    end

    def topological_sort : Array(NodeID)
      used = Array(Bool).new(@size, false)
      order = Array(NodeID).new
      (0...@size).each do |i|
        topological_sort used, order, i if !used[i]
      end
      order.reverse!
    end

    private def topological_sort(used : Array(Bool), order : Array(NodeID), u : NodeID)
      used[u] = true
      get_adjecent(u).each do |e|
        topological_sort used, order, e.@to if !used[e.@to]
      end
      order << u
    end
  end
end
