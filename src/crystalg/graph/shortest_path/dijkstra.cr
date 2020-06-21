require "../graph"

module Crystalg::Graph::ShortestPath

  module Dijkstra(C)
    def dijkstra(start : NodeID): Array(State(C))
      que = PriorityQueue(State(C)).new
      result = Array(State(C)).new(@size) { |i| State.new(i, 0, -1) }

      start_state = State(C).new(start, 0, -1, true)
      que.push(start_state)
      result[start] = start_state

      until (current_state = que.pop!).nil?
        adjacent(current_state.@node_id).map do |edge|
          cost = current_state.@cost + edge.cost
          next if result[edge.target].@cost < cost && result[edge.target].visited?
          next_state = State(C).new(edge.target, cost, edge.source, true)
          que.push(next_state)
          result[edge.target] = next_state
        end
      end
      result
    end
  end
end
