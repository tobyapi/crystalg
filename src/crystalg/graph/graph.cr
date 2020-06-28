module Crystalg::Graph
  alias NodeID = Int32

  abstract class Graph(C)
    abstract def size : Int32
  end
end
