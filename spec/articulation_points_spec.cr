require "./spec_helper"

include Crystalg::Graph

describe Crystalg do
  it "articulation_points_1" do
    graph = UndirectedGraph.new(4)
    graph.add Edge.new(0,1,1)
    graph.add Edge.new(0,2,1)
    graph.add Edge.new(1,2,1)
    graph.add Edge.new(2,3,1)

    answer = [2]
    result = graph.articulation_points
    puts answer
    puts result
    true.should eq(result === answer)
  end

  it "articulation_points_2" do
    graph = UndirectedGraph.new(5)
    graph.add Edge.new(0,1,1)
    graph.add Edge.new(1,2,1)
    graph.add Edge.new(2,3,1)
    graph.add Edge.new(3,4,1)

    answer = [1,2,3]
    result = graph.articulation_points.sort
    true.should eq(result === answer)
  end
end
