require "./spec_helper"

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
  
end