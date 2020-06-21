module Crystalg::Graph::ConnectedComponents
  private class Context
    property k, used, order, lowlink, parent

    # size is number of nodes
    def initialize(size : Int32)
      @k = 0
      @used = Array(Bool).new(size, false)
      @order = Array(Int32).new(size, 0)
      @lowlink = Array(Int32).new(size, 0)
      @parent = Array(Int32).new(size, -1)
    end
  end
end
