require "../spec_helper"

include Crystalg::Graph

describe Crystalg do
  it "kruskal" do
    graph = UndirectedGraph(Int32).new(4)
    graph.add(Edge.new(0, 1, 1))
    graph.add(Edge.new(0, 2, 4))
    graph.add(Edge.new(1, 2, 2))
    graph.add(Edge.new(2, 3, 1))
    graph.add(Edge.new(1, 3, 5))
    graph.add(Edge.new(0, 3, 6))

    result = graph.kruskal

    ans = [
      Edge.new(0, 1, 1),
      Edge.new(2, 3, 1),
      Edge.new(1, 2, 2),
    ]

    true.should eq(result === ans)
  end
end
