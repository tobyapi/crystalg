require "./*"
require "../graph"
require "../../data_structures/*"

include Crystalg::DataStructures

module Crystalg::Graph
  class DFS < Search(Stack(State))
    def run(graph : Graph, start : NodeID): Array(State)
      initializer = ->(graph : Graph, start : NodeID, state_container : Stack(State)){
        initialize_containers(graph, start, state_container)
      }
      
      edge_filter = ->(adjecent  : Array(Edge), current : State, result : Array(State)){
        adjecent.select do |edge| !result[edge.@to].visited? end
      }
      
      next_state_generator = ->(edges : Array(Edge), current : State){
        edges.map do |edge|  
          State.new(edge.@to, current.@cost + 1, current.@node_id, true)
        end
      }
      
      run(graph, start, initializer, edge_filter, next_state_generator)
    end
  end
end