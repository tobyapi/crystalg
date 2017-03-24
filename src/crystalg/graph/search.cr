module Crystalg::Graph

  class State
    include Comparable(State)

    def initialize(@node_id : NodeID, @cost : Cost, @from : NodeID, @visited : Bool = false)
    end

    def ==(that : self)
      @node_id == that.@node_id && @cost == that.@cost &&
      @from == that.@from && @visited == that.@visited
    end

    def <=>(that : self)
      @cost <=> that.@cost
    end

    def visit()
      @visited = true
    end

    def visited?()
      @visited
    end
  end

  abstract class Search(DataStructure)

    abstract def run(graph : Graph, start : NodeID): Array(State)

    protected def run(
      graph : Crystalg::Graph::Graph,
      start : NodeID,
      initializer : Graph, NodeID, DataStructure -> Tuple(DataStructure, Array(State)),
      edge_filter : Array(Edge), State, Array(State) -> Array(Edge),
      state_generator : Array(Edge), State -> Array(State)
      ): Array(State)

      ds, result = initializer.call(graph, start, DataStructure.new)

      while !(current = ds.pop!).nil?
        adjecent = graph.get_adjecent(current.@node_id)
        edges = edge_filter.call(adjecent, current, result)
        next_states = state_generator.call(edges, current)
        next_states.map do |next_state|
          ds.push(result[next_state.@node_id] = next_state)
        end
      end
      result
    end

    def initialize_containers(graph : Graph, start : NodeID, state_container : DataStructure)
      result_container = Array(State).new(graph.@size) { |i| State.new(i, 0, -1) }
      result_container[start].visit
      state_container.push(result_container[start])
      { state_container, result_container }
    end

  end
end
