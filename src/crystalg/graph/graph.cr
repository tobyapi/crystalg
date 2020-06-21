module Crystalg::Graph
  alias NodeID = Int32

  abstract class Graph(C)
    abstract def size : Int32

  end

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

end
