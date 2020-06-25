require "../graph"

module Crystalg::Graph::ShortestPath

  module Dijkstra(C)
    def dijkstra(start : NodeID): Array(Tuple(C, NodeID?)?)
      que = PriorityQueue(Tuple(C, NodeID, NodeID)).new
      result = Array(Tuple(C, NodeID?)?).new(@size, nil)

      start_state = {0, start, -1}
      que.push(start_state)
      result[start] = {0, nil}

      until (current_state = que.pop!).nil?
        adjacent(current_state[1]).map do |edge|
          target_result = result[edge.target]
          is_visited = !target_result.nil?
          cost_to_target_node = current_state[0] + edge.cost

          next if is_visited && is_lower?(cost_to_target_node, target_result)

          next_state = {cost_to_target_node, edge.target, edge.source}
          que.push(next_state)
          result[edge.target] = {cost_to_target_node, edge.source}
        end
      end
      result
    end

    private def is_lower?(cost_to_target_node : C, target_result : Tuple(C, NodeID?)?)
      target_node_result = target_result.as(Tuple(C, NodeID?))
      target_node_result[0] < cost_to_target_node
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
