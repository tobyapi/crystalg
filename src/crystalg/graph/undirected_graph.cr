module Crystalg::Graph
  class UndirectedGraph < Graph
    def add(edge : Edge)
      @graph[edge.@from]  << {edge.@to, edge.@cost}
      @graph[edge.@to] << {edge.@from, edge.@cost}
    end

    def articulation_points : Array(NodeID)
      ArticulationPoints.new(self).all
    end

    def bridges : Array(Edge)
      Array(Edge).new
    end
  end
end
