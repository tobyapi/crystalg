require "../spec_helper"

include Crystalg::Graph

describe Crystalg do

  it "dijkstra" do
    graph = DirectedGraph(Int32).new(4)
    graph.add(Edge.new(0,1,1))
    graph.add(Edge.new(0,2,4))
    graph.add(Edge.new(1,2,2))
    graph.add(Edge.new(2,3,1))
    graph.add(Edge.new(1,3,5))

    result = Dijkstra(Int32).new.run(graph, 0)

    ans = [
      State.new(0,0,-1,true),
      State.new(1,1,0,true),
      State.new(2,3,1,true),
      State.new(3,4,2,true)
    ]

    true.should eq(result === ans)
  end

  it "dijkstra2" do
    graph = DirectedGraph(Int32).new(4)
    graph.add(Edge.new(0,1,1))
    graph.add(Edge.new(0,2,4))
    graph.add(Edge.new(2,0,1))
    graph.add(Edge.new(1,2,2))
    graph.add(Edge.new(3,1,1))
    graph.add(Edge.new(3,2,5))

    result = Dijkstra(Int32).new.run(graph, 1)

    ans = [
      State.new(0,3,2,true),
      State.new(1,0,-1,true),
      State.new(2,2,1,true),
      State.new(3,0,-1,false)
    ]
    true.should eq(result === ans)
  end
end
