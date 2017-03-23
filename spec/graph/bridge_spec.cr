require "../spec_helper"

include Crystalg::Graph

describe Crystalg do
  it "bridges_1" do
    graph = UndirectedGraph.new(4)
    graph.add Edge.new(0,1,1)
    graph.add Edge.new(0,2,1)
    graph.add Edge.new(1,2,1)
    graph.add Edge.new(2,3,1)

    answer = [Edge.new(2,3,1)]
    result = graph.bridges
    true.should eq(result === answer)
  end

  it "bridges_2" do
    graph = UndirectedGraph.new(5)
    graph.add Edge.new(0,1,1)
    graph.add Edge.new(1,2,1)
    graph.add Edge.new(2,3,1)
    graph.add Edge.new(3,4,1)

    result = graph.bridges.sort
    ans = graph.all_edge.uniq

    true.should eq(result === ans)
  end
end
