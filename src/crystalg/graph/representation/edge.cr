module Crystalg::Graph::Edge
  alias NodeID = Int32

  class Edge(T)
    include Comparable(Edge(T))

    getter from, to, cost

    def initialize(@from : NodeID, @to : NodeID, @cost : T)
    end

    def <=>(other : Edge(T))
      if from != other.from
        from <=> other.from
      elsif to != other.to
        to <=> other.to
      else
        cost <=> other.cost
      end
    end
  end

  class FlowEdge(U)
    getter from, to, capacity

    def initialize(@from : NodeID, @to : NodeID, @capacity : U)
    end
  end

  class WeightedFlowEdge(T, U)
    getter from, to, cost, capacity

    def initialize(@from : NodeID, @to : NodeID, @cost : T, @capacity : U)
    end
  end
end
