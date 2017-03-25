require "../*"
require "../../data_structures/*"

include Crystalg::DataStructures

module Crystalg::Graph
  class Kruskal(T) < Search(T,PriorityQueue(State(T)))
    def run(graph : Graph(T), start : NodeID): Array(State(T))
      initializer = ->(graph : Graph(T), start : NodeID, state_container : PriorityQueue(State(T))){
        (0...graph.size).each do |i|
          graph.adjacent(i).each do |edge|
            state_container.push(State.new(edge.target, edge.cost, edge.source))
          end
        end
        result_container = Array(State(T)).new(graph.size) { |i| State(T).new(i, 0, -1) }
        { state_container, result_container }
      }

      union_find = UnionFind.new(graph.@size)

      edge_filter = ->(adjecent  : Array(Edge(T)), current : State(T), result : Array(State(T))){
        result = Array(Edge(T)).new
        if !union_find.same?(current.@from, current.@node_id)
          result << Edge.new(current.@from, current.@node_id, current.@cost)
          union_find.unite(current.@from, current.@node_id)
        end
        result
      }

      next_state_generator = ->(edges : Array(Edge(T)), current : State(T)){
        edges.map do |edge|
          State.new(edge.target, edge.cost, edge.source, true)
        end
      }

      run(graph, start, initializer, edge_filter, next_state_generator).select{ |e| e.visited? }
    end
  end
end
