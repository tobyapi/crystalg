require "../spec_helper"

include Crystalg::Graph

describe Crystalg do
  it "bellman_ford" do
    graph = DirectedGraph(Int32).new(4)
    graph.add Edge.new(0,1,1)
    graph.add Edge.new(0,2,4)
    graph.add Edge.new(1,2,2)
    graph.add Edge.new(2,3,1)
    graph.add Edge.new(1,3,5)

    result = graph.bellman_ford(0)

    ans = [0, 1, 3, 4]

    true.should eq(result === ans)
  end

  it "has_negative_loop" do
    graph = DirectedGraph(Int32).new(4)
    graph.add(Edge.new(0,1,-1))
    graph.add(Edge.new(1,2,2))
    graph.add(Edge.new(2,0,-4))
    graph.add(Edge.new(2,3,-1))
    graph.add(Edge.new(1,3,5))

    true.should eq graph.has_negative_loop?

    graph2 = DirectedGraph(Int32).new(4)
    graph2.add(Edge.new(0,1,-1))
    graph2.add(Edge.new(0,2,-4))
    graph2.add(Edge.new(1,2,2))
    graph2.add(Edge.new(2,3,1))
    graph2.add(Edge.new(1,3,5))

    false.should eq graph2.has_negative_loop?
  end
end
