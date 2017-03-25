require "../spec_helper"

include Crystalg::Graph

describe Crystalg do

  it "bfs" do
    graph = UndirectedGraph(Int32).new(4)
    graph.add(Edge.new(0,1,1))
    graph.add(Edge.new(0,3,1))
    graph.add(Edge.new(1,3,1))
    graph.add(Edge.new(3,2,1))

    result = BFS(Int32).new.run(graph, 0)

    ans = [
      State.new(0,0,-1,true),
      State.new(1,1,0,true),
      State.new(2,2,3,true),
      State.new(3,1,0,true)
    ]

    true.should eq(result === ans)
  end
end
