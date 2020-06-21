require "../*"

module Crystalg::Graph::ConnectecComponents
  module CycleDetection

    private def dfs(u : Int32, used : Array(Int32), flag : Bool): Bool
      return flag if used[u] == 1 || flag
      used[u] = 2
      adjacent(u).each do |e|
        return true if used[e.target] == 2
        flag ||= dfs(e.target, used, flag) if used[e.target] == 0
      end
      used[u] = 1
      flag
    end

    def has_cycle?
      used = Array(Int32).new(@size, 0)
      flag = false
      (0...@size).each { |node_id| flag ||= dfs(node_id, used, flag) }
      flag
    end

    # bellman ford
    def has_negative_cycle?
      dist = Array(Int32).new(@size, 0)
      (0...@size).each do |i|
        edges.each do |edge|
          if dist[edge.target] > dist[edge.source] + edge.cost
            dist[edge.target] = dist[edge.source] + edge.cost
            return true if i == @size - 1
          end
        end
      end
      false
    end
  end
end
