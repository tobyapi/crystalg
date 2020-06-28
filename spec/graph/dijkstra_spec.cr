require "../spec_helper"

include Crystalg::Graph

describe Crystalg do
  it "dijkstra" do
    graph = DirectedGraph(Int32).new(4)
    graph.add(Edge.new(0, 1, 1))
    graph.add(Edge.new(0, 2, 4))
    graph.add(Edge.new(1, 2, 2))
    graph.add(Edge.new(2, 3, 1))
    graph.add(Edge.new(1, 3, 5))

    result = graph.dijkstra(0)
    ans = [{0, nil}, {1, 0}, {3, 1}, {4, 2}]

    true.should eq(result === ans)

    result = graph.get_dijkstra_path(3, result)
    ans = [0, 1, 2, 3]

    true.should eq(result === ans)
  end

  it "dijkstra2" do
    graph = DirectedGraph(Int32).new(4)
    graph.add(Edge.new(0, 1, 1))
    graph.add(Edge.new(0, 2, 4))
    graph.add(Edge.new(2, 0, 1))
    graph.add(Edge.new(1, 2, 2))
    graph.add(Edge.new(3, 1, 1))
    graph.add(Edge.new(3, 2, 5))

    result = graph.dijkstra(1)
    ans = [{3, 2}, {0, nil}, {2, 1}, nil]

    true.should eq(result === ans)
  end
end
