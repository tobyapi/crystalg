require "../spec_helper"

include Crystalg::Graph

describe Crystalg do

  it "prim" do
    graph = UndirectedGraph.new(4)
    graph.add(Edge.new(0,1,1))
    graph.add(Edge.new(0,2,4))
    graph.add(Edge.new(1,2,2))
    graph.add(Edge.new(2,3,1))
    graph.add(Edge.new(1,3,5))
    graph.add(Edge.new(0,3,6))

    result = Prim.new.run(graph, 0)

    ans = [
      State.new(1,1,0,true),
      State.new(2,2,1,true),
      State.new(3,1,2,true)
    ]

    true.should eq(result === ans)
  end
end
