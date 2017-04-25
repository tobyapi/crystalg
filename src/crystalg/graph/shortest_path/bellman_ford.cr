require "../*"

module Crystalg::Graph::BellmanFord
  extend self

  def shortest_path(start, graph)
    dist = Array.new(graph.@size, Int32::MAX)
    dist[start] = 0
    loop do
      update = false
      graph.all_edge.each do |edge|
        if dist[edge.from] != Int32::MAX && dist[edge.to] > dist[edge.from] + e.cost
          dist[e.to] = dist[e.from] + e.cost
          update = true
        end
      end
      break if !update
    end
    dist
  end

  def has_negative_loop?(graph)
    dist = Array.new(graph.@size, 0)
    (0...graph.@size).each do |i|
      graph.all_edge.each do |edge|
        if dist[edge.to] > dist[edge.from] + edge.cost
          dist[edge.to] = dist[edge.from] + edge.cost
          return true if i == graph.@size - 1
        end
      end
    end
    false
  end
end
