require "./spec_helper"

include Crystalg::Geometry

describe Crystalg do
    it "counter_clockwise" do
      a = Point.new(0.0, 0.0)
      b = Point.new(2.0, 0.0)

      c = Point.new(-1.0, 1.0)
      true.should eq(counter_clockwise(a, b, c) === CCW::COUNTER_CLOCKWISE)

      c = Point.new(-1.0, -1.0)
      true.should eq(counter_clockwise(a, b, c) === CCW::CLOCKWISE)

      c = Point.new(-1.0, 0.0)
      true.should eq(counter_clockwise(a, b, c) === CCW::ONLINE_BACK)

      c = Point.new(3.0, 0.0)
      true.should eq(counter_clockwise(a, b, c) === CCW::ONLINE_FRONT)

      c = Point.new(0.0, 0.0)
      true.should eq(counter_clockwise(a, b, c) === CCW::ON_SEGMENT)
    end
end
