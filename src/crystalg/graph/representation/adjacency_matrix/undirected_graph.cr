module Crystalg::Graph::AdjacencyMatrix
  alias NodeID = Int32

  # E: type of edge
  # C: type of cost
  class UndirectedGraph(E,C)
    def initialize(@size)
      @graph = Array(Array(C)).new(@size) {
        Array(C).new(@size, C::MAX)
      }
    end

    def add(edge : E)
      @graph[edge.from][edge.to] = edge.cost
      @graph[edge.to][edge.from] = edge.cost
    end
  end
end
