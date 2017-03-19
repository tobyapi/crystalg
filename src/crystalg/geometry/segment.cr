require "./*"

module Crystalg::Geometry
  class Segment
    getter position, direction

    def initialize(@position : Point, @direction : Point) end

    def on?(c : Point)
      counter_clockwise(position, direction, c) == CCW::ON_SEGMENT
    end

    def is_parallel?(other : Segment)
      (direction - position).cross(other.direction - other.position) == 0
    end

    def is_overlap?(other : Segment)
      is_parallel(other) && (on other.position || on other.direction || other.on position || other.on direction)
    end

    def distance(point : Point)
      a, b, c = position, direction, point
      return c.distance a if (b - a).dot(c - a) < 0
      return c.distance b if (a - b).dot(c - b) < 0
      (b - a).cross(c - a).abs / b.distance a
    end
    
    def distance(other : Segment)
      return 0.0 if is_intersection? other
      Math.min(
        Math.min(distance(other.position), distance other.direction),
        Math.min(other.distance(position), other.distance direction)
      )
    end

    def is_intersection?(other : Segment)
      a, b, c, d = position, direction, other.position, other.direction
      counter_clockwise(a,b,c).value * counter_clockwise(a,b,d).value <= 0 &&
      counter_clockwise(c,d,a).value * counter_clockwise(c,d,b).value <= 0
    end

    def intersection_point(other : Segment)
      q = other.direction - other.position
      d1 = q.cross(position - other.position).abs
      d2 = q.cross(direction - other.position).abs
      position + (direction - position) * (d1 / (d1 + d2))
    end
  end
end
