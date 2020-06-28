require "../spec_helper"

include Crystalg::Graph

describe Crystalg do
  it "directed graph cycle detection 1" do
    graph = DirectedGraph(Int32).new(3)
    graph.add Edge.new(0, 1, 1)
    graph.add Edge.new(0, 2, 1)
    graph.add Edge.new(1, 2, 1)

    false.should eq graph.has_cycle?
  end

  it "directed graph cycle detection 2" do
    graph = DirectedGraph(Int32).new(3)
    graph.add Edge.new(0, 1, 1)
    graph.add Edge.new(1, 2, 1)
    graph.add Edge.new(2, 0, 1)

    true.should eq graph.has_cycle?
  end
end
