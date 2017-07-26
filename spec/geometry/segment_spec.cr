require "../spec_helper"

include Crystalg::Geometry

describe Crystalg do
  it "is_intersection?" do
    seg1 = Segment(Float32).new(Point(Float32).new(0_f32,0_f32),Point(Float32).new(3_f32,0_f32))
    seg2 = Segment(Float32).new(Point(Float32).new(1_f32,1_f32),Point(Float32).new(2_f32,-1_f32))
    true.should eq(seg1.is_intersection? seg2)

    seg2 = Segment(Float32).new(Point(Float32).new(3_f32,1_f32),Point(Float32).new(3_f32,-1_f32))
    true.should eq(seg1.is_intersection? seg2)

    seg2 = Segment(Float32).new(Point(Float32).new(3_f32,-2_f32),Point(Float32).new(5_f32,0_f32))
    false.should eq(seg1.is_intersection? seg2)
  end

  it "intersection_point" do
    seg1 = Segment(Float32).new(Point(Float32).new(0_f32,0_f32),Point(Float32).new(2_f32,0_f32))
    seg2 = Segment(Float32).new(Point(Float32).new(1_f32,1_f32),Point(Float32).new(1_f32,-1_f32))
    true.should eq(seg1.intersection_point(seg2) === Point(Float32).new(1_f32,0_f32))

    seg1 = Segment(Float32).new(Point(Float32).new(0_f32,0_f32),Point(Float32).new(1_f32,1_f32))
    seg2 = Segment(Float32).new(Point(Float32).new(0_f32,1_f32),Point(Float32).new(1_f32,0_f32))
    true.should eq(seg1.intersection_point(seg2) === Point(Float32).new(0.5_f32,0.5_f32))

    seg2 = Segment(Float32).new(Point(Float32).new(1_f32,0_f32),Point(Float32).new(0_f32,1_f32))
    true.should eq(seg1.intersection_point(seg2) === Point(Float32).new(0.5_f32,0.5_f32))
  end

  it "distance" do
    seg1 = Segment(Float32).new(Point(Float32).new(0_f32, 0_f32), Point(Float32).new(1_f32, 0_f32))
    seg2 = Segment(Float32).new(Point(Float32).new(0_f32, 1_f32), Point(Float32).new(1_f32, 1_f32))
    true.should eq(seg1.distance(seg2) === 1_f32)

    seg2 = Segment(Float32).new(Point(Float32).new(2_f32, 1_f32), Point(Float32).new(1_f32, 2_f32))
    true.should eq(seg1.distance(seg2) === 1.4142135624_f32)

    seg1 = Segment(Float32).new(Point(Float32).new(-1_f32, 0_f32), Point(Float32).new(1_f32, 0_f32))
    seg2 = Segment(Float32).new(Point(Float32).new(0_f32, 1_f32), Point(Float32).new(0_f32, -1_f32))
    true.should eq(seg1.distance(seg2) == 0_f32)
  end
end
