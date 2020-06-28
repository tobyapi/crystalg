require "./*"

module Crystalg::Geometry
  class Circle(T)
    getter center : Point(T)
    getter radius : T

    def initialize(@center, @radius)
    end

    def ==(other : self)
      center == other.center && radius === other.radius
    end

    def contain?(target)
      (target - center).norm.sign radius <= T.zero
    end

    # returns number of the common tangents
    def intersection(other)
      dist = center.distance other.center
      return 4 if dist > radius + other.radius
      return 3 if dist == radius + other.radius
      return 2 if dist > (radius - other.radius).abs
      return 1 if dist == (radius - other.radius).abs
      0
    end

    def intersection_points(line)
      return Array(Point(T)).new if line.distance(center) <=> radius > 0
      q = line.project center
      t = (center - q).norm
      d = (radius * radius - t * t).sqrt
      base = line.direction - line.position
      result = Array(Point(T)).new
      result << q + base * (d / base.norm)
      result << q - base * (d / base.norm)
      result
    end

    def intersection_points(other : self)
      result = Array(Point(T)).new
      return result if (center - other.center).norm > (radius + other.radius) ** 2
      theta = Math.atan2(other.center.y - center.y, other.center.x - center.x)
      dist = center.distance other.center
      alpha = Math.acos((dist ** 2 + radius ** 2 - other.radius ** 2) / (2 * dist * radius))
      result << Point.new(center.x + radius * Math.cos(theta + alpha), center.y + radius * Math.sin(theta + alpha))
      result << Point.new(center.x + radius * Math.cos(theta - alpha), center.y + radius * Math.sin(theta - alpha))
      result
    end

    def intersection_area(other)
      r1, r2 = Math.min(radius, other.radius), Math.max(radius, other.radius)
      dist = (center - other.center).norm
      return Math::PI * r1 ** 2 if (dist <=> r2 - r1) <= 0
      return 0.0 if (dist <=> r2 + r1) >= 0
      rc = dist ** 2 + r1 ** 2 - r2 ** 2 / (2 * dist)
      theta = Math.acos(rc / r1)
      phi = Math.acos((dist - rc) / r2)
      r1 ** 2 * theta + r2 ** 2 * phi - dist * r1 * Math.sin(theta)
    end

    def circumscribed_circle(a, b)
      q = (a + b) / 2
      Circle(T).new(q, (a - q).norm)
    end

    def self.circumscribed_circle(p, q, r)
      a, b = (q - p) * 2, (r - p) * 2
      c = Point(T).new(p.dot(p) - q.dot(q), p.dot(p) - r.dot(r))
      tmp = Point(T).new(a.y * c.y - b.y * c.x, b.x * c.x - a.x * c.y) / a.cross b
      Circle(T).new(tmp, p.distance tmp)
    end
  end
end
