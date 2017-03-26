module Crystalg::Graph::AdjacencyMatrix
  alias NodeID = Int32

  # C: type of cost
  class DirectedGraph(C)
    def initialize(@size : Int32)
      @graph = Array(Array(C)).new(@size) {
        Array(C).new(@size, C::MAX)
      }
    end

    def add(edge : Edge(C))
      @graph[edge.source][edge.target] = edge.cost
    end
  end
end
