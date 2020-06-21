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
      while !(v = queue.pop!).nil?
        @graph.adjacent(v).each do |e|
          if e.capacity > C.zero && @level[e.target] < 0
            @level[e.target] = @level[v] + 1
            queue.push e.target
          end
        end
      end
    end

    private def dfs(v : NodeID, target : NodeID, flow : C): C
      return flow if v == target
      edges = @graph.adjacent(v)
      while @iter[v] < edges.size
        e = edges[@iter[v]]
        if e.capacity > C.zero && @level[v] < @level[e.target]
          d = dfs(e.target, target, Math.min(flow, e.capacity))
          return @graph.flow(v, @iter[v], d) if d > C.zero
        end
        @iter[v] += 1
      end
      C.zero
    end
  end
end
