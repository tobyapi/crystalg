require "./*"

module Crystalg::Geometry
  class Polygon(T)
    def initialize(*points : Point(T))
      @points = points.to_a
    end

    def initialize(@points : Array(Point(T)))
    end

    def size
      @points.size
    end

    def prv(i)
      cur(i - 1)
    end

    def cur(i)
      @points[i % @points.size]
    end

    def nxt(i)
      cur(i + 1)
    end

    def [](i)
      @points[i]
    end

    def ==(other : self)
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

    def contain(target : Point(T)) : Containment
      is_contain = false
      @points.each_with_index do |e, i|
        a, b = cur(i) - target, nxt(i) - target
        a, b = b, a if a.y > b.y
        is_contain ^= true if a.y <= 0 && 0 < b.y && a.cross(b) < 0
        return Containment::ON if a.cross(b) == 0 && a.dot(b) <= 0
      end
      is_contain ? Containment::IN : Containment::OUT
    end

    def area : T
      result = T.zero
      @points.each_with_index do |e, i|
        result = result + (e.x - nxt(i).x) * (e.y + nxt(i).y)
      end
      result.abs / 2.0
    end

    def convex_cut(line : Line(T))
      pos, dir = line.position, line.direction
      result = Array(Point(T)).new
      @points.each_with_index do |e, i|
        vec = dir - pos
        side = Segment(T).new(e, nxt i)
        result << e if counter_clockwise(pos, dir, e) != CCW::CLOCKWISE
        # TODO : bugfix
        result << side.intersection_point(Segment(T).new(pos, dir)) if side.is_intersection? Segment(T).new(line.position, line.direction)
      end
      Polygon.new(result)
    end

    def convex_hull
      points = @points
      points.sort
      result = Array(Point(T)).new
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

    def diameter
      qs = convex_hull
      n = qs.size

      return 0.0 if n == 2

      i = j = 0
      (0...n).each do |k|
        i = k if qs[k] < qs[i]
        j = k if qs[j] < qs[k]
      end

      result = 0_f64
      si, sj = i, j
      while i != sj && j != si
        result = Math.max(result, qs[i].distance qs[j])
        if (qs.nxt(i) - qs.cur(i)).cross(qs.nxt(j) - qs.cur(j)) < 0
          i = (i + 1) % n
        else
          j = (j + 1) % n
        end
      end
      result
    end
  end
end
