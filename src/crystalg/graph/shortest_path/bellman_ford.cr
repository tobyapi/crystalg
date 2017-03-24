require "../*"

module Crystalg::Graph::BellmanFord
  extend self
  INF = 2147483647

  def shortest_path(start : Int32, graph : Graph): Array(Int32)
    dist = Array(Int32).new(graph.@size, INF)
    dist[start] = 0
    loop do
      update = false
      graph.all_edge.each do |edge|
        if dist[edge.from] != INF && dist[edge.to] > dist[edge.from] + e.cost
          dist[e.to] = dist[e.from] + e.cost
          update = true
        end
      end
      break if !update
    end
    dist
  end

  def has_negative_loop?(graph : Graph)
    dist = Array(Int32).new(graph.@size, 0)
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
