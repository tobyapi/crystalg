require "../../data_structures/queue"
require "../flow_graph"

module Crystalg::Graph
  class Dinic(C)
    def initialize(@graph : FlowGraph(C))
      @iter = Array(NodeID).new(@graph.size, 0)
      @level = Array(Int32).new(@graph.size, -1)
    end

    def max_flow(source : NodeID, target : NodeID)
      flow = C.zero
      loop do
        bfs(source)
        return flow if @level[target] < 0
        @iter.fill(0)
        while (f = dfs(source, target, C::MAX)) > C.zero
          flow += f
        end
      end
    end

    private def bfs(source : NodeID)
      @level.fill(-1)
      queue = Queue(Int32).new
      @level[source] = 0
      queue.push source
      while !(node_id = queue.pop!).nil?
        @graph.adjacent_nodes(node_id).each do |target_id, capacity|
          if capacity > C.zero && @level[target_id] < 0
            @level[target_id] = @level[node_id] + 1
            queue.push(target_id)
          end
        end
      end
    end

    private def dfs(v : NodeID, target : NodeID, flow : C): C
      return flow if v == target
      nodes = @graph.adjacent_nodes(v)
      while @iter[v] < nodes.size
        next_id, capacity, _rev = nodes[@iter[v]]
        if capacity > C.zero && @level[v] < @level[next_id]
          d = dfs(next_id, target, Math.min(flow, capacity))
          return @graph.flow(v, @iter[v], d) if d > C.zero
        end
        @iter[v] += 1
      end
      C.zero
    end
  end
end
