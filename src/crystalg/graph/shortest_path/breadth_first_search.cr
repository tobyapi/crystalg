require "../*"
require "../representation/adjacency_list/*"
require "../../data_structures/*"

include Crystalg::DataStructures
include Crystalg::Graph::AdjacencyList

module Crystalg::Graph
  class BFS(T) < Search(T,Queue(State(T)))
    def run(graph, start)
      initializer = ->(graph : Graph(T), start : NodeID, state_container : Queue(State(T))){
        initialize_containers(graph, start, state_container)
      }

      edge_filter = ->(adjecent  : Array(Edge(T)), current : State(T), result : Array(State(T))){
        adjecent.select { |edge| !result[edge.target].visited? }
      }

      next_state_generator = ->(edges : Array(Edge(T)), current : State(T)){
        edges.map do |edge|
          State.new(edge.target, current.@cost + 1, current.@node_id, true)
        end
      }

      run(graph, start, initializer, edge_filter, next_state_generator)
    end
  end
end
