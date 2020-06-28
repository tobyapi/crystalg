require "../graph"

module Crystalg::Graph::ShortestPath
  module Dijkstra(C)
    def dijkstra(start : NodeID) : Array(Tuple(C, NodeID?)?)
      que = PriorityQueue(Tuple(C, NodeID)).new
      result = Array(Tuple(C, NodeID?)?).new(@size, nil)

      start_state = {0, start}
      que.push(start_state)
      result[start] = {0, nil}

      until (current_state = que.pop!).nil?
        current_cost, node_id = current_state
        adjacent_nodes(node_id).each do |target_id, target_cost|
          is_visited = !result[target_id].nil?
          cost = current_cost + target_cost

          next if is_visited && gte?(cost, result[target_id])

          result[target_id] = {cost, node_id}
          que.push({cost, target_id})
        end
      end
      result
    end

    private def gte?(cost_to_target : C, target_result : Tuple(C, NodeID?)?)
      target_node_result = target_result.as(Tuple(C, NodeID?))
      target_node_result[0] <= cost_to_target
    end

    def get_dijkstra_path(node_id : NodeID, dijkstra_result : Array(Tuple(C, NodeID?)?)) : Array(NodeID)
      path = [] of NodeID
      return path if dijkstra_result[node_id].nil?

      until node_id.nil?
        Helper.assert(!dijkstra_result[node_id].nil?)

        path << node_id
        _cost, prev_node_id = dijkstra_result[node_id].as(Tuple(C, NodeID?))
        node_id = prev_node_id
      end
      path.reverse!
    end
  end
end
