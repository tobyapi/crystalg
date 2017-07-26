require "./*"

module Crystalg::Geometry
  class Line(T)
    getter position : Point(T)
    getter direction : Point(T)

    def initialize(@position, @direction) end

    def project(point)
      base = direction - position
      position + base * ((point - position).dot (base / base.dot base))
    end

    def reflect(q)
      q + (project(q) - q) * 2
    end

    def is_parallel?(other)
      (direction - position).cross(other.direction - other.position) == 0
    end

    def is_orthogonal?(other)
      (direction - position).dot(other.direction - other.position) == 0
    end

    def is_intersection?(other)
      !is_parallel? other
    end

    def distance(point)
      v = direction - position
      v.cross(point - position).abs / v.norm
    end

    def intersection_point(other)
      vector = direction - position
      other_vector = other.direction - other.position
      position + vector * (other_vector.cross(other.position - position) / other_vector.cross vector)
    end
  end
end
