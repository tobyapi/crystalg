require "../graph"

module Crystalg::Graph::ShortestPath

  module Dijkstra(C)
    private class State(C)
      include Comparable(State)

      def initialize(@node_id : NodeID, @cost : C, @from : NodeID)
      end

      def ==(that : self)
        @node_id == that.@node_id && @cost == that.@cost && @from == that.@from
      end

      def <=>(other : State)
        @cost <=> other.@cost
      end
    end

    def dijkstra(start : NodeID): Array(Tuple(C, NodeID?)?)
      que = PriorityQueue(State(C)).new
      result = Array(Tuple(C, NodeID?)?).new(@size, nil)

      start_state = State(C).new(start, 0, -1)
      que.push(start_state)
      result[start] = {0, nil}

      until (current_state = que.pop!).nil?
        adjacent(current_state.@node_id).map do |edge|
          cost = current_state.@cost + edge.cost
          next if !result[edge.target].nil? && result[edge.target].as(Tuple(C, NodeID?))[0] < cost
          next_state = State(C).new(edge.target, cost, edge.source)
          que.push(next_state)
          result[edge.target] = {cost, edge.source}
        end
      end
      result
    end

    def get_dijkstra_path(node_id : NodeID, dijkstra_result : Array(Tuple(C, NodeID?)?)): Array(NodeID)
      path = [] of NodeID
      return path if dijkstra_result[node_id].nil?

      until node_id.nil?
        path << node_id
        _cost, prev_node_id = dijkstra_result[node_id].as(Tuple(C, NodeID?))
        node_id = prev_node_id
      end
      path.reverse!
    end
  end
end
