require "./*"

module Crystalg::Geometry
  class Circle
    getter center, radius

    def initialize(@center : Point, @radius : Float64)
    end

    def contain?(target : Point)
      (target - center).norm.sign radius <= 0
    end

    def intersection_points(line : Line): Array(Point)
      return Array(Point).new if line.dist(center).sign radius > 0
      q = line.project center
      t, d = (center - q).norm, (radius * radius - t * t).sqrt
      base = line.direction - line.position
      result = Array(Point).new
      result << q + base * (d / base.norm)
      result << q - base * (d / base.norm)
      result
    end

    def circumscribed_circle(a : Point, b : Point)
      q = (a + b) / 2
      Circle.new(q, (a - q).norm)
    end

    def circumscribed_circle(p : Point, q : Point, r : Point)
      a, b = (q - p) * 2, (r - p) * 2
      c = Point.new(p.dot(p) - q.dot(q), p.dot(p) - r.dot(r))
      tmp = Point.new(a.y * c.y - b.y * c.x, b.x * c.x - a.x * c.y)
      tmp = tmp / a.cross b
      Circle.new(tmp, p.distance tmp)
    end
  end
end
