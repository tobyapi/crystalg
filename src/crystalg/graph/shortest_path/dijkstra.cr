require "../*"
require "../../data_structures/*"

include Crystalg::DataStructures

module Crystalg::Graph
  class Dijkstra(T)
    def run(graph : Graph(T), start : NodeID): Array(State(T))
      que = PriorityQueue(State(T)).new
      result = Array(State(T)).new(graph.size) { |i| State.new(i, 0, -1) }

      start_state = State(T).new(start, 0, -1, true)
      que.push(start_state)
      result[start] = start_state

      until (current_state = que.pop!).nil?
        graph.adjacent(current_state.@node_id).map do |edge|
          cost = current_state.@cost + edge.cost
          next if result[edge.target].@cost < cost && result[edge.target].visited?
          next_state = State(T).new(edge.target, cost, edge.source, true)
          que.push(next_state)
          result[edge.target] = next_state
        end
      end
      result
    end
  end
end
