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

    def <=>(other : State)
      @cost <=> other.@cost
    end

    def visit()
      @visited = true
    end

    def visited?()
      @visited
    end
  end

  abstract class Search(T,DataStructure)

    abstract def run(graph : Graph(T), start : NodeID): Array(State)

    protected def run(
      graph : Graph(T),
      start : NodeID,
      initializer : Graph, NodeID, DataStructure -> Tuple(DataStructure, Array(State(T))),
      edge_filter : Array(Edge(T)), State, Array(State(T)) -> Array(Edge(T)),
      state_generator : Array(Edge(T)), State -> Array(State(T))
      ): Array(State(T))

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

    def initialize_containers(graph : Graph, start : NodeID, state_container : DataStructure)
      result_container = Array(State(T)).new(graph.size) { |i|
        State.new(i, 0, -1)
      }
      result_container[start].visit
      state_container.push(result_container[start])
      { state_container, result_container }
    end

  end
end
