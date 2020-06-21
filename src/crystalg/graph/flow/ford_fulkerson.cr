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

    def dfs(v : NodeID, target : NodeID, flow : C): C
      return flow if v == target
      @used[v] = true
      @graph.adjacent(v).each_with_index do |e, i|
        if !@used[e.target] && e.capacity > C.zero
          d = dfs(e.target, target, Math.min(flow, e.capacity))
          return @graph.flow(v,i,d) if d > C.zero
        end
      end
      C.zero
    end
  end
end
