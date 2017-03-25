module Crystalg::Graph
  alias NodeID = Int32

  abstract class Graph(C)
    abstract def size : Int32
    
    def edges : Array(Edge(C))
      result = Array(Edge(C)).new
      (0...size).each do |node_id|
        adjacent(node_id).each do |edge|
          result << edge if edge.source < edge.target
        end
      end
      result.uniq!
    end
  end
end