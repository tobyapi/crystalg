require "./context"

module Crystalg::Graph::ConnectedComponents
  module Bridges(T)

    private def bridge_dfs(u : NodeID, bridges : Array(Edge(T)), ctx : Context, prev : NodeID = -1)
      ctx.used[u] = true
      ctx.order[u] = ctx.lowlink[u] = ctx.k
      ctx.k += 1

      adjacent(u).each do |edge|
        if !ctx.used[edge.target]
          bridge_dfs(edge.target, bridges, ctx, u)
          ctx.lowlink[u] = Math.min(ctx.lowlink[u], ctx.lowlink[edge.target])
          if ctx.order[u] < ctx.lowlink[edge.target]
            left = Math.min(u, edge.target)
            right = Math.max(u, edge.target)
            bridges << Edge.new(left, right, edge.cost)
          end
        elsif edge.target != prev
          ctx.lowlink[u] = Math.min(ctx.lowlink[u], ctx.order[edge.target])
        end
      end
    end

    def bridges
      ctx = Context.new(@size)
      bridges = Array(Edge(T)).new
      bridge_dfs(0, bridges, ctx)
      bridges
    end
  end
end
