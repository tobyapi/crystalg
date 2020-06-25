require "./connected_components/*"
require "./shortest_path/*"

module Crystalg::Graph::AdjacencyList

  # C: type of cost
  class DirectedGraph(C) < Graph(C)
    getter size : Int32

    def initialize(@size : Int32)
      @graph = Array(Array(Tuple(NodeID, C))).new(@size) {
        Array(Tuple(NodeID, C)).new
      }
    end

    def add(edge : Edge(C))
      @graph[edge.source] << {edge.target, edge.cost}
    end

    def adjacent_nodes(node_id : NodeID) : Array(Tuple(C, NodeID))
      @graph[node_id].map do |e|
        {e[0], e[1]}
      end
    end

    def edges : Array(Edge(C))
      result = Array(Edge(C)).new
      (0...@size).each do |node_id|
        node_edges = adjacent_nodes(node_id).map do |target_id, cost|
          Edge(C).new(node_id, target_id, cost)
        end
        result.concat(node_edges)
      end
      result.uniq!
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
      adjacent_nodes(u).each do |target_id, _cost|
        topological_sort(used, order, target_id) if !used[target_id]
      end
      order << u
    end

    include ConnectecComponents::CycleDetection
    include ShortestPath::Dijkstra(C)
  end
end
