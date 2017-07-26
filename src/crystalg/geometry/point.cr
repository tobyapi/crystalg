require "./*"

module Crystalg::Geometry
  class Point(T)
    include Comparable(Point(T))

    getter x : T, y : T

    def initialize(@x : T, @y : T) end

    def +(other : self)
      Point.new(x + other.x, y + other.y)
    end

    def -(other : self)
      Point.new(x + (-other.x), y + (-other.y))
    end

    def *(other)
      Point.new(x * other, y * other)
    end

    def /(other)
      Point.new(x / other, y / other)
    end

    def <=>(other)
      if x != other.x
        x <=> other.x
      else
        y <=> other.y
      end
    end

    def ==(other)
      x === other.x && y === other.y
    end

    def norm
      (x * x + y * y).sqrt.as(T)
    end

    def distance(other)
      (self - other).norm
    end

    def dot(other) 
      x * other.x + y * other.y
    end

    def cross(other)
      x * other.y - y * other.x
    end

    def rotate(radian, pivot = Point.new(0,0))
      Point.new(
        LibM.cos(r) * (x - pivot.x) - LibM.sin(r) * (y - pivot.y) + pivot.x,
        LibM.sin(r) * (x - pivot.x) + LibM.cos(r) * (y - pivot.y) + pivot.y)
    end

    def arg
      LibM.atan(y/x) if x.sign > 0
      LibM.atan(y/x) + PI if x.sign < 0
      PI / 2.0.as Float  if y.sign > 0
      3.0 * PI / 2.0.as Float if y.sign < 0
      0
    end
  end
end
