module Crystalg::Graph::AdjacencyList
  alias NodeID = Int32

  # C: type of capacity
  class FlowGraph(C)
    def initialize(@size)
      @graph = Array(Array(Tuple(NodeID, C))).new(@size) {
        Array(Tuple(NodeID, C)).new
      }
    end

    def add(edge : FlowEdge(C))
      @graph[edge.from] << {edge.to, edge.capacity, @graph[edge.to].size}
      @graph[edge.to] << {edge.from, T.zero, @graph[edge.from].size - 1}
    end
  end
end
