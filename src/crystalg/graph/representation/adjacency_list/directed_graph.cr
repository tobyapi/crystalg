require "../graph"

module Crystalg::Graph::AdjacencyList

  # C: type of cost
  class DirectedGraph(C) < Graph(C)
    getter size
    
    def initialize(@size : Int32)
      @graph = Array(Array(Tuple(NodeID, C))).new(@size) {
        Array(Tuple(NodeID, C)).new
      }
    end

    def add(edge : Edge(C))
      @graph[edge.source] << {edge.target, edge.cost}
    end

    def adjacent(node_id : NodeID) : Array(Edge(C))
      @graph[node_id].map do |e|
        Edge(C).new(node_id, e[0], e[1])
      end
    end
    
    def edges : Array(Edge(C))
      result = Array(Edge(C)).new
      (0...@size).each do |node_id|
        result.concat adjacent node_id
      end
      result.uniq!
    end
    
    def has_cycle?
      CycleDetection.new(self).has_cycle?
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
      adjacent(u).each do |e|
        topological_sort used, order, e.target if !used[e.target]
      end
      order << u
    end
  end
end
