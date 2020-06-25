require "../flow_graph"

module Crystalg::Graph

  # C: type of capacity
  class FordFulkerson(C)
    def initialize(@graph : FlowGraph(C))
      @used = Array(Bool).new(@graph.size, false)
    end

    def max_flow(source : NodeID, target : NodeID)
      flow = C.zero
      loop do
        @used.fill(false)
        f = dfs(source, target, C::MAX)
        return flow if f == C.zero
        flow += f
      end
    end

    def dfs(node_id : NodeID, target : NodeID, flow : C): C
      return flow if node_id == target
      @used[node_id] = true
      @graph.adjacent_nodes(node_id).each_with_index do |node, i|
        next_id, capacity = node
        if !@used[next_id] && capacity > C.zero
          d = dfs(next_id, target, Math.min(flow, capacity))
          return @graph.flow(node_id, i, d) if d > C.zero
        end
      end
      C.zero
    end
  end
end
