module Crystalg::Graph
  class Edge(T)
    include Comparable(Edge(T))

    getter source, target, cost

    def initialize(@source : NodeID, @target : NodeID, @cost : T)
    end

    def <=>(other : Edge(T))
      if cost != other.cost
        cost <=> other.cost
      elsif source != other.source
        source <=> other.source
      else
        target <=> other.target
      end
    end

    def ==(other : Edge(T))
      (source == other.source || source == other.target) &&
        (target == other.source || target == other.target) &&
        cost == other.cost
    end

    def ===(other : Edge(T))
      source == other.source && target == other.target && cost == other.cost
    end
  end

  class FlowEdge(U)
    getter source, target, capacity

    def initialize(@source : NodeID, @target : NodeID, @capacity : U)
    end
  end

  class WeightedFlowEdge(T, U)
    getter source, target, cost, capacity

    def initialize(@source : NodeID, @target : NodeID, @cost : T, @capacity : U)
    end
  end
end
