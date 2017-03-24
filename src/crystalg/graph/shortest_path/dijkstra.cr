require "../*"
require "../../data_structures/*"

include Crystalg::DataStructures

module Crystalg::Graph
  class Dijkstra < Search(PriorityQueue(State))
    def run(graph : Graph, start : NodeID): Array(State)
      initializer = ->(graph : Graph, start : NodeID, state_container : PriorityQueue(State)){
        initialize_containers(graph, start, state_container)
      }

      edge_filter = ->(adjecent  : Array(Edge), current : State, result : Array(State)){
        adjecent.select do |edge|
          !result[edge.@to].visited? || current.@cost + edge.@cost < result[edge.@to].@cost
        end
      }

      next_state_generator = ->(edges : Array(Edge), current : State){
        edges.map do |edge|
          State.new(edge.@to, current.@cost + edge.@cost, current.@node_id, true)
        end
      }

      run(graph, start, initializer, edge_filter, next_state_generator)
    end
  end
end
