require "../graph"

module Crystalg::Graph::AdjacencyList
  
  # C: type of capacity
  class FlowGraph(C)
    getter size
    
    def initialize(@size : Int32)
      @graph = Array(Array(Tuple(NodeID, C, Int32))).new(@size) {
        Array(Tuple(NodeID, C, Int32)).new
      }
    end
    
    def add(edge : FlowEdge(C))
      @graph[edge.source] << {edge.target, edge.capacity, @graph[edge.target].size}
      @graph[edge.target] << {edge.source, C.zero, @graph[edge.source].size - 1}
    end
    
    def adjacent(node_id : NodeID) : Array(FlowEdge(C))
      @graph[node_id].map do |e|
        FlowEdge(C).new(node_id, e[0], e[1])
      end
    end
    
    def flow(v : NodeID, index : Int32, f : C): C
      e = @graph[v][index]
      r = @graph[e[0]][e[2]]
      @graph[v][index] = {e[0], e[1] - f, e[2]}
      @graph[e[0]][e[2]] = {r[0], r[1] + f, r[2]}
      f
    end
  end
end
