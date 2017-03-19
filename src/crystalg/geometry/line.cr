require "./*"

module Crystalg::Geometry
  class Line
    getter position, direction
    
    def initialize(@position : Point, @direction : Point) end
      
    def project(point : Point)
      base = direction - position
      position + base * ((point - position).dot (base / base.dot base))
    end
    
    def reflect(q : Point)
      q + (project(q) - q) * 2
    end
    
    def is_parallel?(other : Line)
      (direction - position).cross(other.direction - other.position) == 0
    end
    
    def is_orthogonal?(other : Line)
      (direction - position).dot(other.direction - other.position) == 0
    end
    
    def is_intersection?(other : Line)
      !is_parallel? other
    end
    
    def intersection_point(other : Line): Point
      vector = direction - position
      other_vector = other.direction - other.position
      position + vector * (other_vector.cross(other.position - position) / other_vector.cross vector)
    end
  end
end