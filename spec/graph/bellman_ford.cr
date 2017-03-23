require "../spec_helper"

include Crystalg::Graph

describe Crystalg do
  it "bellman_ford" do
    graph = UndirectedGraph.new(4)
    graph.add(Edge.new(0,1,1))
    graph.add(Edge.new(0,2,4))
    graph.add(Edge.new(1,2,2))
    graph.add(Edge.new(2,3,1))
    graph.add(Edge.new(1,3,5))

    result = BellmanFord.shortest_path(0,graph)

    ans = [0, 1, 3, 4]

    true.should eq(result === ans)
  end

  it "has_negative_loop" do
    graph = DirectedGraph.new(4)
    graph.add(Edge.new(0,1,-1))
    graph.add(Edge.new(0,2,-4))
    graph.add(Edge.new(1,2,2))
    graph.add(Edge.new(2,3,-1))
    graph.add(Edge.new(1,3,5))

    true.should eq BellmanFord.has_negative_loop?(graph)

    graph2 = DirectedGraph.new(4)
    graph2.add(Edge.new(0,1,-1))
    graph2.add(Edge.new(0,2,-4))
    graph2.add(Edge.new(1,2,2))
    graph2.add(Edge.new(2,3,1))
    graph2.add(Edge.new(1,3,5))

    false.should eq BellmanFord.has_negative_loop?(graph2)
  end
end
