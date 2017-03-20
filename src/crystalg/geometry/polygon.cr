require "./*"

module Crystalg::Geometry
  class Polygon
    def initialize(*points : Point)
      @points = points.to_a
    end
    
    def initialize(@points : Array(Point))
    end
    
    private def prv(i : Int32): Point
      cur(i - 1)
    end
    
    private def cur(i : Int32): Point
      @points[i % @points.size]
    end
    
    private def nxt(i : Int32): Point
      cur(i + 1)
    end
    
    def ==(other : Polygon)
      this, that = self.@points, other.@points
      return false if this.size != that.size
      this.sort == that.sort
    end
    
    def is_convex?
      @points.each_with_index do |e, i|  
        return false if counter_clockwise(prv(i), cur(i), nxt(i)) == CCW::CLOCKWISE 
      end
      true
    end
    
    enum Containment 
       OUT = 0, IN = 1, ON = 2
    end
    
    def contain(target : Point) : Containment
      is_contain? = false
      @points.each_with_index do |e, i|
        a, b = cur(i) - target, nxt(i) - target
        a, b = b, a if a.y > b.y
        is_contain? ^= true if a.y <= 0 && 0 < b.y && a.cross(b) < 0
        return Containment::ON if a.cross(b) == 0 && a.dot(b) <= 0 
      end
      is_contain? ? Containment::IN : Containment::OUT
    end
    
    def area : Float64
      result : Float64 = 0.0
      @points.each_with_index do |e, i|  
        result = result + (e.x - nxt(i).x) * (e.y + nxt(i).y)
      end
      result.abs / 2.0
    end

    def convex_cut(line : Line): Polygon
      pos, dir = line.position, line.direction
      result = Array(Point).new
      @points.each_with_index do |e, i|  
        vec = dir - pos
        side = Segment.new(e, nxt i)
        result << e if counter_clockwise(pos, dir, e) != CCW::CLOCKWISE
        # TODO : bugfix
        result << side.intersection_point(Segment.new(pos, dir)) if side.is_intersection? Segment.new(line.position, line.direction)
      end
      Polygon.new(result)
    end
    
    def convex_hull : Polygon
      points = @points
      points.sort
      result = Array(Point).new
      (0...points.size).each do |i|
        while result.size > 1
          tail1 = result[result.size - 1]
          tail2 = result[result.size - 2]
          (tail1 - tail2).cross(points[i] - tail1)
          break if (tail1 - tail2).cross(points[i] - tail1) < 0
          result.pop
        end
        result << points[i]
      end
      
      t = result.size
      (0..points.size - 2).reverse_each do |i|
        tail1 = result[result.size - 1]
        tail2 = result[result.size - 2]
        while result.size > t 
          tail1 = result[result.size - 1]
          tail2 = result[result.size - 2]
          break if (tail1 - tail2).cross(points[i] - tail1) < 0
          result.pop
        end
        result << points[i]
      end
      result.pop
      Polygon.new(result)
    end
  end
end
