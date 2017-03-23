
module Crystalg::Graph
  class HopcroftKarp
    @left_size : Int32
    @right_size : Int32
    @edge_size : Int32
    @last : Array(Int32)
    @prev : Array(Int32)
    @head : Array(Int32)
    @match : Array(Int32)
    @dist : Array(Int32)
    @queue : Array(Int32)
    @used : Array(Bool)
    @visited : Array(Bool)

    private getter last, prev, head, match, dist, queue, used, visited
    private setter last, prev, head, match, dist, queue, used, visited

    def initialize(@left_size : Int32, @right_size : Int32)
      @edge_size = 0
      @last = Array.new(@left_size, -1)
      @head = Array.new(@edge_size, 0)
      @prev = Array.new(@edge_size, 0)
      @match = Array(Int32).new(@right_size, -1)
      @dist = Array(Int32).new(@left_size, -1)
      @queue = Array(Int32).new
      @used = Array(Bool).new(@left_size, false)
      @visited = Array(Bool).new(@left_size, false)
    end

    def add_edge(left_id : Int32, right_id : Int32)
      head[@edge_size] = right_id
      prev[@edge_size] = last[left_id]
      last[left_id] = @edge_size
      @edge_size += 1
    end

    def bipartite_matching
      used = Array(Bool).new(@left_size, false)
      match = Array(Int32).new(@right_size, -1)
      flow = 0
      loop do
        bfs
        visited = Array(Bool).new(@left_size, false)
        f = 0
        (0...@left_size).each do |u|
          f += 1 if !used[u] && dfs(u)
        end
        return flow if f == 0
        flow += f
      end
    end

    private def bfs
      dist = Array(Int32).new(@left_size, -1)
      size = 0
      (0...@left_size).each do |u|
        if !used[u]
          queue[size] = u
          size += 1
          dist[u] = 0
        end
      end

      (0...size).each do |i|
        u1 = queue[i]
        e = last[u1]
        while e >= 0
          u2 = match[head[e]]
          if u2 >= 0 && dist[u2] < 0
            dist[u2] = dist[u1] + 1
            queue[size] = u2
            size += 1
          end
          e = prev[e]
        end
      end
    end

    private def dfs(u1 : Int32) : Bool
      visited[u1] = true

      e = last[u1]
      while e >= 0
        v = head[e]
        u2 = match[v]
        if u2 < 0 || (!visited[u2] && dist[u2] == dist[u1]+1 && dfs(u2))
          match[v] = u1
          return (used[u1] = true)
        end
        e = prev[e]
      end
      false
    end

  end
end
