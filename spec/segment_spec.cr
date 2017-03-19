require "./spec_helper"

include Crystalg::Geometry

describe Crystalg do
  it "is_intersection?" do
    seg1 = Segment.new(Point.new(0.0,0.0),Point.new(3.0,0.0))
    seg2 = Segment.new(Point.new(1.0,1.0),Point.new(2.0,-1.0))
    true.should eq(seg1.is_intersection? seg2)
    
    seg2 = Segment.new(Point.new(3.0,1.0),Point.new(3.0,-1.0))
    true.should eq(seg1.is_intersection? seg2)
    
    seg2 = Segment.new(Point.new(3.0,-2.0),Point.new(5.0,0.0))
    false.should eq(seg1.is_intersection? seg2)
  end
  
  it "intersection_point" do
    seg1 = Segment.new(Point.new(0.0,0.0),Point.new(2.0,0.0))
    seg2 = Segment.new(Point.new(1.0,1.0),Point.new(1.0,-1.0))
    true.should eq(seg1.intersection_point(seg2) === Point.new(1.0,0.0))
    
    seg1 = Segment.new(Point.new(0.0,0.0),Point.new(1.0,1.0))
    seg2 = Segment.new(Point.new(0.0,1.0),Point.new(1.0,0.0))
    true.should eq(seg1.intersection_point(seg2) === Point.new(0.5,0.5))
    
    seg2 = Segment.new(Point.new(1.0,0.0),Point.new(0.0,1.0))
    true.should eq(seg1.intersection_point(seg2) === Point.new(0.5,0.5))
  end
  
  it "distance" do
    seg1 = Segment.new(Point.new(0.0, 0.0), Point.new(1.0, 0.0))
    seg2 = Segment.new(Point.new(0.0, 1.0), Point.new(1.0, 1.0))
    true.should eq(seg1.distance(seg2) === 1.0)
    
    seg2 = Segment.new(Point.new(2.0, 1.0), Point.new(1.0, 2.0))
    true.should eq(seg1.distance(seg2) === 1.4142135624)
    
    seg1 = Segment.new(Point.new(-1.0, 0.0), Point.new(1.0, 0.0))
    seg2 = Segment.new(Point.new(0.0, 1.0), Point.new(0.0, -1.0))
    true.should eq(seg1.distance(seg2) == 0.0)
  end
end