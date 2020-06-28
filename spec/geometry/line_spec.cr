require "../spec_helper"

include Crystalg::Geometry

describe Crystalg do
  it "projection" do
    line = Line(Float32).new(Point(Float32).new(0_f32, 0_f32), Point(Float32).new(3_f32, 4_f32))
    point = Point(Float32).new(2_f32, 5_f32)
    true.should eq(line.project(point) === Point(Float32).new(3.12_f32, 4.16_f32))

    line = Line(Float32).new(Point(Float32).new(0_f32, 0_f32), Point(Float32).new(2_f32, 0_f32))
    point = Point(Float32).new(-1_f32, 1_f32)
    true.should eq(line.project(point) === Point(Float32).new(-1_f32, 0_f32))
    point = Point(Float32).new(0_f32, 1_f32)
    true.should eq(line.project(point) === Point(Float32).new(0_f32, 0_f32))
    point = Point(Float32).new(1_f32, 1_f32)
    true.should eq(line.project(point) === Point(Float32).new(1_f32, 0_f32))
  end

  it "reflection" do
    line = Line(Float64).new(Point(Float64).new(0_f64, 0_f64), Point(Float64).new(3_f64, 4_f64))
    point = Point(Float64).new(2_f64, 5_f64)
    true.should eq(line.reflect(point) === Point(Float64).new(4.24_f64, 3.32_f64))
    point = Point(Float64).new(1_f64, 4_f64)
    true.should eq(line.reflect(point) === Point(Float64).new(3.56_f64, 2.08_f64))
    point = Point(Float64).new(0_f64, 3_f64)
    true.should eq(line.reflect(point) === Point(Float64).new(2.88_f64, 0.84_f64))

    line = Line(Float32).new(Point(Float32).new(0_f32, 0_f32), Point(Float32).new(2_f32, 0_f32))
    point = Point(Float32).new(-1_f32, 1_f32)
    true.should eq(line.reflect(point) === Point(Float32).new(-1_f32, -1_f32))
    point = Point(Float32).new(0_f32, 1_f32)
    true.should eq(line.reflect(point) === Point(Float32).new(0_f32, -1_f32))
    point = Point(Float32).new(1_f32, 1_f32)
    true.should eq(line.reflect(point) === Point(Float32).new(1_f32, -1_f32))
  end

  it "is_parallel?" do
    line1 = Line(Float32).new(Point(Float32).new(0_f32, 0_f32), Point(Float32).new(3_f32, 0_f32))
    line2 = Line(Float32).new(Point(Float32).new(0_f32, 2_f32), Point(Float32).new(3_f32, 2_f32))
    true.should eq(line1.is_parallel?(line2) === true)

    line1 = Line(Float32).new(Point(Float32).new(0_f32, 0_f32), Point(Float32).new(3_f32, 0_f32))
    line2 = Line(Float32).new(Point(Float32).new(1_f32, 1_f32), Point(Float32).new(2_f32, 2_f32))
    true.should eq(line1.is_parallel?(line2) === false)
  end

  it "is_orthogonal?" do
    line1 = Line(Float32).new(Point(Float32).new(0_f32, 0_f32), Point(Float32).new(3_f32, 0_f32))
    line2 = Line(Float32).new(Point(Float32).new(1_f32, 1_f32), Point(Float32).new(1_f32, 4_f32))
    true.should eq(line1.is_orthogonal?(line2) === true)

    line1 = Line(Float32).new(Point(Float32).new(0_f32, 0_f32), Point(Float32).new(3_f32, 0_f32))
    line2 = Line(Float32).new(Point(Float32).new(1_f32, 1_f32), Point(Float32).new(2_f32, 2_f32))
    true.should eq(line1.is_parallel?(line2) === false)
  end

  it "is_intersection?" do
    line1 = Line(Float32).new(Point(Float32).new(0_f32, 0_f32), Point(Float32).new(3_f32, 0_f32))
    line2 = Line(Float32).new(Point(Float32).new(1_f32, 1_f32), Point(Float32).new(2_f32, -1_f32))
    true.should eq(line1.is_intersection? line2)

    line2 = Line(Float32).new(Point(Float32).new(3_f32, 1_f32), Point(Float32).new(3_f32, -1_f32))
    true.should eq(line1.is_intersection? line2)

    line2 = Line(Float32).new(Point(Float32).new(3_f32, -2_f32), Point(Float32).new(5_f32, 0_f32))
    true.should eq(line1.is_intersection? line2)
  end
end
