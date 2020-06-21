require "../spec_helper"

include Crystalg::Graph

describe Crystalg do

  it "has_negative_loop" do
    graph = DirectedGraph(Int32).new(4)
    graph.add(Edge.new(0,1,-1))
    graph.add(Edge.new(1,2,2))
    graph.add(Edge.new(2,0,-4))
    graph.add(Edge.new(2,3,-1))
    graph.add(Edge.new(1,3,5))

    true.should eq graph.has_negative_cycle?

    graph2 = DirectedGraph(Int32).new(4)
    graph2.add(Edge.new(0,1,-1))
    graph2.add(Edge.new(0,2,-4))
    graph2.add(Edge.new(1,2,2))
    graph2.add(Edge.new(2,3,1))
    graph2.add(Edge.new(1,3,5))

    false.should eq graph2.has_negative_cycle?
  end
end
