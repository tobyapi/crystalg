require "./context"

module Crystalg::Graph::ConnectedComponents
  module Bridges(T)
    private def bridge_dfs(u : NodeID, bridges : Array(Edge(T)), ctx : Context, prev : NodeID = -1)
      ctx.used[u] = true
      ctx.order[u] = ctx.lowlink[u] = ctx.k
      ctx.k += 1

      adjacent_nodes(u).each do |target_node_id, target_cost|
        if !ctx.used[target_node_id]
          bridge_dfs(target_node_id, bridges, ctx, u)
          ctx.lowlink[u] = Math.min(ctx.lowlink[u], ctx.lowlink[target_node_id])
          if ctx.order[u] < ctx.lowlink[target_node_id]
            left = Math.min(u, target_node_id)
            right = Math.max(u, target_node_id)
            bridges << Edge.new(left, right, target_cost)
          end
        elsif target_node_id != prev
          ctx.lowlink[u] = Math.min(ctx.lowlink[u], ctx.order[target_node_id])
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
