require "../graph"
require "../../data_structures/*"

module Crystalg::Graph::SpanningTree
  module Kruskal(C)
    def kruskal : Array(Edge(C))
      union_find = UnionFind.new(@size)
      result = Array(Edge(C)).new

      edges.sort.each do |edge|
        if !union_find.same?(edge.source, edge.target)
          union_find.unite(edge.source, edge.target)
          result << edge
        end
      end
      result
    end
  end
end
