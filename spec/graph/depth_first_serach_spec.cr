require "../spec_helper"

include Crystalg::Graph

describe Crystalg do

  it "dfs" do
    graph = UndirectedGraph.new(6)
    graph.add(Edge.new(0,1,1))
    graph.add(Edge.new(0,2,1))
    graph.add(Edge.new(1,2,1))
    graph.add(Edge.new(1,3,1))
    graph.add(Edge.new(2,4,1))
    graph.add(Edge.new(3,5,1))
    graph.add(Edge.new(4,5,1))

    DFS.new.run(graph, 0).map do |node|
      true.should eq(node.@visited)
    end
  end
end
