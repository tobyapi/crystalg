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

    abstract def add(edge : Edge)

    def get_adjecent(node_id : NodeID) : Array(Edge)
      @graph[node_id].map do |e|
        Edge.new(node_id, e[0], e[1])
      end
    end

    def all_edge : Array(Edge)
      (0...@size).each do |node_id|
        get_adjecent node_id
      end
    end
  end
end
