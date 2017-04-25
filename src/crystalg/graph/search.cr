require "./representation/adjacency_list/*"

include Crystalg::Graph

module Crystalg::Graph
  class State(C)
    include Comparable(State)

    def initialize(@node_id : NodeID, @cost : C, @from : NodeID, @visited : Bool = false)
    end

    def ==(that : self)
      @node_id == that.@node_id && @cost == that.@cost &&
      @from == that.@from && @visited == that.@visited
    end

    def <=>(that : self)
      @cost <=> that.@cost
    end

    def visit
      @visited = true
    end

    def visited?
      @visited
    end
  end

  abstract class Search(T, DataStructure)
    protected def run(graph, start, initializer, edge_filter, state_generator)

      ds, result = initializer.call(graph, start, DataStructure.new)

      while !(current = ds.pop!).nil?
        adjacent = graph.adjacent(current.@node_id)
        edges = edge_filter.call(adjacent, current, result)
        next_states = state_generator.call(edges, current)
        next_states.map do |next_state|
          ds.push(result[next_state.@node_id] = next_state)
        end
      end
      result
    end

    def initialize_containers(graph, start, state_container)
      result_container = Array.new(graph.size) { |i| State.new(i, 0, -1) }
      result_container[start].visit
      state_container.push(result_container[start])
      { state_container, result_container }
    end

  end
end
