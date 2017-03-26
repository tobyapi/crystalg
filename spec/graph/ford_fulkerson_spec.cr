require "../spec_helper"

include Crystalg::Graph

describe Crystalg do
  it "ford_fulkerson" do
    graph = FlowGraph(Int32).new(4)
    graph.add FlowEdge.new(0,1,2)
    graph.add FlowEdge.new(0,2,1)
    graph.add FlowEdge.new(1,2,1)
    graph.add FlowEdge.new(1,3,1)
    graph.add FlowEdge.new(2,3,2)
    true.should eq(FordFulkerson(Int32).new(graph).max_flow(0,3) === 3)
  end
end