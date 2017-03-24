module Crystalg::Graph::AdjacencyList
  alias NodeID = Int32

  # C: type of cost
  class DirectedGraph(C)
    def initialize(@size)
      @graph = Array(Array(Tuple(NodeID, C))).new(@size) {
        Array(Tuple(NodeID, C)).new
      }
    end

    def add(edge : Edge(C))
      @graph[edge.from] << {edge.to, edge.cost}
    end

    def adjecent(node_id : NodeID) : Array(Edge(C))
      @graph[node_id].map do |e|
        Edge(C).new(node_id, e[0], e[1])
      end
    end
  end
end
