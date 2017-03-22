module Crystalg::Graph
  class UndirectedGraph < Graph
    def add(edge : Edge)
      @graph[edge.@from]  << {edge.@to, edge.@cost}
      @graph[edge.@to] << {edge.@from, edge.@cost}
    end

    def all_edge : Array(Edge)
      result = Array(Edge).new
      (0...@size).each do |node_id|
        get_adjecent(node_id).each do |edge|
          result << edge if edge.from < edge.to
        end
      end
      result.uniq!
    end

    def articulation_points : Array(NodeID)
      ArticulationPoints.new(self).all
    end

    def bridges : Array(Edge)
      Bridges.new(self).all
    end
  end
end
