require "./*"
require "../graph"
require "../../data_structures/*"

include Crystalg::DataStructures

module Crystalg::Graph
  class BFS < Search(Queue(State))    
    def run(graph : Graph, start : NodeID): Array(State)
      edge_filter = ->(adjecent  : Array(Edge), current : State, result : Array(State)){
        adjecent.select do |edge| !result[edge.@to].visited? end
      }
      
      next_state_generator = ->(edges : Array(Edge), current : State){
        edges.map do |edge|  
          State.new(edge.@to, current.@cost + 1, current.@node_id, true)
        end
      }
      
      run(graph, start, edge_filter, next_state_generator)
    end
  end
end
