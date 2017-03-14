require "./*"
require "../graph"
require "../../data_structures/*"

include Crystalg::DataStructures

module Crystalg::Graph
  class Kruskal < Search(PriorityQueue(State))
    def run(graph : Graph, start : NodeID): Array(State)
      initializer = ->(graph : Graph, start : NodeID, state_container : PriorityQueue(State)){
        (0...graph.@size).each do |i|  
          graph.get_adjecent(i).each do |edge| 
            state_container.push(State.new(edge.@to, edge.@cost, edge.@from))            
          end
        end
        result_container = Array(State).new(graph.@size) { |i| State.new(i, 0, -1) }
        { state_container, result_container }
      }
      
      union_find = UnionFind.new(graph.@size)
      
      edge_filter = ->(adjecent  : Array(Edge), current : State, result : Array(State)){
        result = Array(Edge).new
        if !union_find.same?(current.@from, current.@node_id)
          result << Edge.new(current.@from, current.@node_id, current.@cost)
          union_find.unite(current.@from, current.@node_id)
        end
        result
      }
      
      next_state_generator = ->(edges : Array(Edge), current : State){
        edges.map do |edge|
          State.new(edge.@to, edge.@cost, edge.@from, true)
        end
      }
      
      run(graph, start, initializer, edge_filter, next_state_generator).select{ |e| e.visited? }
    end
  end
end