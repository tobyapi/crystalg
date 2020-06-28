require "../spec_helper"

include Crystalg::Graph

describe Crystalg do
  it "topological_sort" do
    graph = DirectedGraph(Int32).new(6)
    graph.add(Edge.new(0, 1, -1))
    graph.add(Edge.new(1, 2, -4))
    graph.add(Edge.new(3, 1, 2))
    graph.add(Edge.new(3, 4, -1))
    graph.add(Edge.new(4, 5, 5))
    graph.add(Edge.new(5, 2, 5))

    answer = [0, 3, 1, 4, 5, 2]
    result = graph.topological_sort

    (0..5).each do |i|
      (0..5).each do |j|
        true.should eq(i < j) if result[i] == 0 && result[j] == 1
        true.should eq(i < j) if result[i] == 0 && result[j] == 2
        true.should eq(i < j) if result[i] == 1 && result[j] == 2
        true.should eq(i < j) if result[i] == 3 && result[j] == 1
        true.should eq(i < j) if result[i] == 3 && result[j] == 2
        true.should eq(i < j) if result[i] == 3 && result[j] == 4
        true.should eq(i < j) if result[i] == 3 && result[j] == 5
        true.should eq(i < j) if result[i] == 4 && result[j] == 5
        true.should eq(i < j) if result[i] == 4 && result[j] == 2
        true.should eq(i < j) if result[i] == 5 && result[j] == 2
      end
    end
  end
end
