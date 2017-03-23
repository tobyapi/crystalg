require "../spec_helper"

include Crystalg::Geometry

describe Crystalg do
  it "projection" do
    line = Line.new(Point.new(0.0, 0.0), Point.new(3.0, 4.0))
    point = Point.new(2.0, 5.0)
    true.should eq(line.project(point) === Point.new(3.12,4.16))

    line = Line.new(Point.new(0.0, 0.0), Point.new(2.0, 0.0))
    point = Point.new(-1.0, 1.0)
    true.should eq(line.project(point) === Point.new(-1.0,0.0))
    point = Point.new(0.0, 1.0)
    true.should eq(line.project(point) === Point.new(0.0,0.0))
    point = Point.new(1.0, 1.0)
    true.should eq(line.project(point) === Point.new(1.0,0.0))
  end

  it "reflection" do
    line = Line.new(Point.new(0.0, 0.0), Point.new(3.0, 4.0))
    point = Point.new(2.0, 5.0)
    true.should eq(line.reflect(point) === Point.new(4.24, 3.32))
    point = Point.new(1.0, 4.0)
    true.should eq(line.reflect(point) === Point.new(3.56, 2.08))
    point = Point.new(0.0, 3.0)
    true.should eq(line.reflect(point) === Point.new(2.88, 0.84))

    line = Line.new(Point.new(0.0, 0.0), Point.new(2.0,0.0))
    point = Point.new(-1.0,1.0)
    true.should eq(line.reflect(point) === Point.new(-1.0, -1.0))
    point = Point.new(0.0,1.0)
    true.should eq(line.reflect(point) === Point.new(0.0, -1.0))
    point = Point.new(1.0,1.0)
    true.should eq(line.reflect(point) === Point.new(1.0, -1.0))
  end

  it "is_parallel?" do
    line1 = Line.new(Point.new(0.0,0.0), Point.new(3.0,0.0))
    line2 = Line.new(Point.new(0.0,2.0), Point.new(3.0,2.0))
    true.should eq(line1.is_parallel?(line2) === true)

    line1 = Line.new(Point.new(0.0,0.0), Point.new(3.0,0.0))
    line2 = Line.new(Point.new(1.0,1.0), Point.new(2.0,2.0))
    true.should eq(line1.is_parallel?(line2) === false)
  end

  it "is_orthogonal?" do
    line1 = Line.new(Point.new(0.0,0.0), Point.new(3.0,0.0))
    line2 = Line.new(Point.new(1.0,1.0), Point.new(1.0,4.0))
    true.should eq(line1.is_orthogonal?(line2) === true)

    line1 = Line.new(Point.new(0.0,0.0), Point.new(3.0,0.0))
    line2 = Line.new(Point.new(1.0,1.0), Point.new(2.0,2.0))
    true.should eq(line1.is_parallel?(line2) === false)
  end

  it "is_intersection?" do
    line1 = Line.new(Point.new(0.0,0.0),Point.new(3.0,0.0))
    line2 = Line.new(Point.new(1.0,1.0),Point.new(2.0,-1.0))
    true.should eq(line1.is_intersection? line2)

    line2 = Line.new(Point.new(3.0,1.0),Point.new(3.0,-1.0))
    true.should eq(line1.is_intersection? line2)

    line2 = Line.new(Point.new(3.0,-2.0),Point.new(5.0,0.0))
    true.should eq(line1.is_intersection? line2)
  end
end
