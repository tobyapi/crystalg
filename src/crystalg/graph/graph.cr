module Crystalg::Graph
  alias IntCost = (Int16 | Int32 | Int64 | Int8 )
  alias UIntCost = ( UInt16 | UInt32 | UInt64 | UInt8 )
  alias FloatCost = (Float32 | Float64)
  alias Cost = (IntCost | UIntCost | FloatCost)
  
  alias NodeID = Int32

  class Edge
    def initialize(@from : NodeID, @to : NodeID, @cost : Cost)
    end
  end

  abstract class Graph
    def initialize(@size : Int32)
      @graph = Array(Array(Tuple(NodeID, Cost))).new(@size) {
        Array(Tuple(NodeID, Cost)).new 
      }
    end
  
    abstract def add(edge : (Edge | FlowEdge))

    def get_adjecent(node_id : NodeID)
      @graph[node_id].map do |e|
        Edge.new(node_id, e[0], e[1])
      end
    end
  end
  
  class UndirectedGraph < Graph
    def add(edge : Edge)
      @graph[edge.@from]  << {edge.@to, edge.@cost}
      @graph[edge.@to] << {edge.@from, edge.@cost}
    end
  end

  class DirectedGraph < Graph
    def add(edge : Edge)
      @graph[edge.@from] << {edge.@to, edge.@cost}
    end
  end
end