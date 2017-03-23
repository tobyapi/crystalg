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

    def intersection_points(other : Circle): Array(Point)
      result = Array(Point).new
      return result if (center - other.center) > (radius + other.radius) ** 2
      theta = Math.atan2(other.center.y - center.y, other.center.x - center.x)
      dist = center.distance other.center
      alpha = Math.acos((dist ** 2 + radius ** 2  - other.center ** 2) / (2 * dist * radius))
      result << Point.new(center.x + radius * Math.cos(theta + alpha), center.y + radius * Math.sin(theta + alpha))
      result << Point.new(center.x + radius * Math.cos(theta - alpha), center.y + radius * Math.sin(theta - alpha))
      result
    end

    def intersection_area(other : Circle): Float64
      r1, r2 = Math.min(radius, other.radius), Math.max(radius, other.radius)
      dist = (center - other.center).norm
      return PI * r1 ** 2 if (dist <=> r2 - r1) <= 0
      return 0 if (dist <=> r2 + r1) >= 0
      rc = dist ** 2 + r1 ** 2 - r2 ** 2 / (2 * dist)
      theta = Math.acos(rc / r1)
      phi = acos = acos((dist - rc) / r2)
      r1 ** 2 * theta + r2 ** 2 * phi - dist * r1 * Math.sin(theta)
    end

    def circumscribed_circle(a : Point, b : Point)
      q = (a + b) / 2
      Circle.new(q, (a - q).norm)
    end

    def circumscribed_circle(p : Point, q : Point, r : Point)
      a, b = (q - p) * 2, (r - p) * 2
      c = Point.new(p.dot(p) - q.dot(q), p.dot(p) - r.dot(r))
      tmp = Point.new(a.y * c.y - b.y * c.x, b.x * c.x - a.x * c.y) / a.cross b
      Circle.new(tmp, p.distance tmp)
    end
  end
end
