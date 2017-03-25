require "../graph"

module Crystalg::Graph::AdjacencyList

  # C: type of cost
  class UndirectedGraph(C) < Graph(C)
    getter size
    
    def initialize(@size : Int32)
      @graph = Array(Array(Tuple(NodeID, C))).new(@size) {
        Array(Tuple(NodeID, C)).new
      }
    end

    def add(edge : Edge(C))
      @graph[edge.source] << {edge.target, edge.cost}
      @graph[edge.target] << {edge.source, edge.cost}
    end

    def adjacent(node_id : NodeID) : Array(Edge(C))
      @graph[node_id].map do |e|
        Edge(C).new(node_id, e[0], e[1])
      end
    end
    
    def edges : Array(Edge(C))
      result = Array(Edge(C)).new
      (0...@size).each do |node_id|
        adjacent(node_id).each do |edge|
          result << edge if edge.source < edge.target
        end
      end
      result.uniq!
    end
    
    def articulation_points : Array(NodeID)
      ArticulationPoints.new(self).all
    end

    def bridges : Array(Edge(C))
      Bridges.new(self).all
    end
  end
end
