require "../*"
require "../../data_structures/*"

include Crystalg::DataStructures

module Crystalg::Graph
  class Prim(T) < Search(T,PriorityQueue(State(T)))
    def run(graph : Graph(T), start : NodeID): Array(State(T))
      initializer = ->(graph : Graph(T), start : NodeID, state_container : PriorityQueue(State(T))){
        initialize_containers(graph, start, state_container)
      }

      edge_filter = ->(adjacent  : Array(Edge(T)), current : State(T), result : Array(State(T))){
        adjacent.select do |edge|
          !result[edge.target].visited? || current.@cost + edge.cost < result[edge.target].@cost
        end
      }

      next_state_generator = ->(edges : Array(Edge(T)), current : State(T)){
        edges.map do |edge|
          State.new(edge.target, edge.cost, current.@node_id, true)
        end
      }

      result = run(graph, start, initializer, edge_filter, next_state_generator)
      result.shift
      result
    end
  end
end
