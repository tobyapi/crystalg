require "../spec_helper"

include Crystalg
include Crystalg::Geometry

describe Crystalg do
  it "intersection" do
    c1 = Circle(Float32).new(Point(Float32).new(1_f32, 1_f32), 1_f32)
    c2 = Circle(Float32).new(Point(Float32).new(6_f32, 2_f32), 2_f32)
    true.should eq(c1.intersection(c2) === 4)

    c1 = Circle(Float32).new(Point(Float32).new(1_f32, 2_f32), 1_f32)
    c2 = Circle(Float32).new(Point(Float32).new(4_f32, 2_f32), 2_f32)
    true.should eq(c1.intersection(c2) === 3)

    c1 = Circle(Float32).new(Point(Float32).new(1_f32, 2_f32), 1_f32)
    c2 = Circle(Float32).new(Point(Float32).new(3_f32, 2_f32), 2_f32)
    true.should eq(c1.intersection(c2) === 2)

    c1 = Circle(Float32).new(Point(Float32).new(0_f32, 0_f32), 1_f32)
    c2 = Circle(Float32).new(Point(Float32).new(1_f32, 0_f32), 2_f32)
    true.should eq(c1.intersection(c2) === 1)

    c1 = Circle(Float32).new(Point(Float32).new(0_f32, 0_f32), 1_f32)
    c2 = Circle(Float32).new(Point(Float32).new(0_f32, 0_f32), 2_f32)
    true.should eq(c1.intersection(c2) === 0)
  end

  it "intersection_points of circle and line" do
    circle = Circle(Float32).new(Point(Float32).new(2_f32, 1_f32), 1_f32)

    line = Line(Float32).new(
      Point(Float32).new(0_f32, 1_f32),
      Point(Float32).new(4_f32, 1_f32)
    )
    answer = [Point(Float32).new(3_f32, 1_f32), Point(Float32).new(1_f32, 1_f32)]
    result = circle.intersection_points(line)
    true.should eq(result === answer)

    line = Line(Float32).new(Point(Float32).new(3_f32, 0_f32), Point(Float32).new(3_f32, 3_f32))
    answer = [Point(Float32).new(3_f32, 1_f32), Point(Float32).new(3_f32, 1_f32)]
    result = circle.intersection_points(line)
    true.should eq(result === answer)
  end

  it "intersection_points of circles" do
    c1 = Circle(Float64).new(Point(Float64).new(0_f64, 0_f64), 2_f64)
    c2 = Circle(Float64).new(Point(Float64).new(2_f64, 0_f64), 2_f64)
    answer = [Point(Float64).new(1_f64, 1.73205080_f64), Point(Float64).new(1_f64, -1.73205080_f64)]
    result = c1.intersection_points c2
    true.should eq(result === answer)

    c1 = Circle(Float64).new(Point(Float64).new(0_f64, 0_f64), 2_f64)
    c2 = Circle(Float64).new(Point(Float64).new(0_f64, 3_f64), 1_f64)
    answer = [Point(Float64).new(0_f64, 2_f64), Point(Float64).new(0_f64, 2_f64)]
    result = c1.intersection_points c2
    true.should eq(result === answer)
  end

  it "intersection_area" do
    c1 = Circle(Float32).new(Point(Float32).new(20_f32, 30_f32), 15_f32)
    c2 = Circle(Float32).new(Point(Float32).new(40_f32, 30_f32), 30_f32)
    result = c1.intersection_area(c2)
    true.should eq(result === 608.366_f32)
  end

  it "circumscribed_circle of a triangle" do
    result = Circle(Float32).circumscribed_circle(
      Point(Float32).new(0_f32, 0_f32),
      Point(Float32).new(2_f32, 0_f32),
      Point(Float32).new(2_f32, 2_f32)
    )

    answer = Circle(Float32).new(Point(Float32).new(1_f32, 1_f32), 1.41421356_f32)
    true.should eq(result === answer)
  end
end
