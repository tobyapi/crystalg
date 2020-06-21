require "./context"

module Crystalg::Graph::ConnectedComponents

  module ArticulationPoints
    private def articulation_points_dfs(u : NodeID, ctx : Context, prev : NodeID = -1)
      ctx.used[u] = true
      ctx.order[u] = ctx.lowlink[u] = ctx.k
      ctx.k += 1

      adjacent(u).each do |edge|
        if !ctx.used[edge.target]
          ctx.parent[edge.target] = u
          articulation_points_dfs(edge.target, ctx, u)
          ctx.lowlink[u] = Math.min(ctx.lowlink[u], ctx.lowlink[edge.target])
        elsif edge.target != prev
          ctx.lowlink[u] = Math.min(ctx.lowlink[u], ctx.order[edge.target])
        end
      end
    end

    def articulation_points: Array(NodeID)
      ctx = Context.new(@size)

      count = 0
      result = Array(NodeID).new
      articulation_points_dfs(0, ctx)
      (0...@size).each do |i|
        count += 1 if ctx.parent[i] == 0 && i != 0
        if ctx.parent[i] > 0 && ctx.lowlink[i] >= ctx.order[ctx.parent[i]]
          result << ctx.parent[i]
        end
      end
      result << 0 if count >= 2
      result.sort!.uniq!
    end
  end
end
