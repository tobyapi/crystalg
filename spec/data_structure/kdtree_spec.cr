require "../spec_helper"

include Crystalg::Graph
include Crystalg::Geometry

describe Crystalg do
  it "kdtree" do
    input = [
      Point.new(2.0, 1.0),
      Point.new(2.0, 2.0),
      Point.new(4.0, 2.0),
      Point.new(6.0, 2.0),
      Point.new(3.0, 3.0),
      Point.new(5.0, 4.0)
    ]

    kdtree = KDTree.new(input)

    result1 = kdtree.count(Point.new(2.0,0.0), Point.new(4.0,4.0))
    result2 = kdtree.count(Point.new(4.0,2.0), Point.new(10.0,5.0))
    true.should eq(result1 == 4)
    true.should eq(result2 == 3)
  end

  it "nearest_neighbour kdtree" do
    input = [
      Point.new(2.0, 1.0),
      Point.new(2.0, 2.0),
      Point.new(4.0, 2.0),
      Point.new(6.0, 1.0),
      Point.new(3.0, 3.0),
      Point.new(5.0, 4.0)
    ]

    kdtree = KDTree.new(input)

    result1 = kdtree.nearest_neighbour Point.new(0.0, 0.0)
    
    true.should eq(result1 == Point.new(2.0,1.0))
  end
end
