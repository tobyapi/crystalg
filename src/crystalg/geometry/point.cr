require "./*"

module Clystalg::Geometry
  class Point
    getter x, y

    def initialize(@x : Float, @y : Float) end

    def +(other : Point)
      Point.new(x + other.x, y + other.y)
    end

    def -(other : Point)
      Point.new(x + (-other.x), y + (-other.y))
    end

    def *(other : Float)
      Point.new(x * other, y * other)
    end

    def /(other : Float)
      Point.new(x / other, y / other)
    end
  end
end
