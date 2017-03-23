require "../spec_helper"

include Crystalg
include Crystalg::Geometry

describe Crystalg do
  it "intersection_points of circle and line" do
    circle = Circle.new(Point.new(2.0, 1.0), 1.0)

    line = Line.new(Point.new(0.0, 1.0), Point.new(4.0, 1.0))
    answer = [Point.new(3.0, 1.0), Point.new(1.0, 1.0)]
    result = circle.intersection_points(line)
    true.should eq(result === answer)

    line = Line.new(Point.new(3.0, 0.0), Point.new(3.0, 3.0))
    answer = [Point.new(3.0, 1.0),Point.new(3.0, 1.0)]
    result = circle.intersection_points(line)
    true.should eq(result === answer)
  end

  it "intersection_points of circles" do
    c1 = Circle.new(Point.new(0.0, 0.0), 2.0)
    c2 = Circle.new(Point.new(2.0, 0.0), 2.0)
    answer = [Point.new(1.0, 1.73205080), Point.new(1.0, -1.73205080)]
    result = c1.intersection_points c2
    true.should eq(result === answer)

    c1 = Circle.new(Point.new(0.0, 0.0), 2.0)
    c2 = Circle.new(Point.new(0.0, 3.0), 1.0)
    answer = [Point.new(0.0, 2.0), Point.new(0.0, 2.0)]
    result = c1.intersection_points c2
    true.should eq(result === answer)
  end

  it "intersection_area" do
    c1 = Circle.new(Point.new(20.0, 30.0), 15.0)
    c2 = Circle.new(Point.new(40.0, 30.0), 30.0)
    result = c1.intersection_area(c2)
    true.should eq(result === 608.366)
  end

  it "circumscribed_circle of a triangle" do
    result = Circle.circumscribed_circle(
      Point.new(0.0, 0.0),
      Point.new(2.0, 0.0),
      Point.new(2.0, 2.0)
    )

    answer = Circle.new(Point.new(1.0, 1.0), 1.41421356)
    true.should eq(result === answer)
  end
end
