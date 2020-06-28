require "./connected_components/*"
require "./spanning_tree/*"

module Crystalg::Graph
  # C: type of cost
  class UndirectedGraph(C) < Graph(C)
    getter size : Int32

    def initialize(@size : Int32)
      @graph = Array(Array(Tuple(NodeID, C))).new(@size) {
        Array(Tuple(NodeID, C)).new
      }
    end

    def add(edge : Edge(C))
      @graph[edge.source] << {edge.target, edge.cost}
      @graph[edge.target] << {edge.source, edge.cost}
    end

    def adjacent_nodes(node_id : NodeID) : Array(Tuple(NodeID, C))
      @graph[node_id].map do |e|
        {e[0], e[1]}
      end
    end

    def edges : Array(Edge(C))
      result = Array(Edge(C)).new
      (0...@size).each do |node_id|
        adjacent_nodes(node_id).each do |target_id, cost|
          result << Edge(C).new(node_id, target_id, cost) if node_id < target_id
        end
      end
      result.uniq!
    end

    include ConnectedComponents::ArticulationPoints
    include ConnectedComponents::Bridges(C)
    include SpanningTree::Kruskal(C)
  end
end
