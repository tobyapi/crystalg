require "../../geometry/*"

include Crystalg::Geometry

module Crystalg::Trees
  class KDTree(T)
    @size : Int32
    @points : Array(Point(T))

    def initialize(@points)
      @size = points.size
      @tx = Array(T).new(@size, T.zero)
      @ty = Array(T).new(@size, T.zero)
      @minx = Array(T).new(@size, T.zero)
      @miny = Array(T).new(@size, T.zero)
      @maxx = Array(T).new(@size, T.zero)
      @maxy = Array(T).new(@size, T.zero)
      @count = Array(Int32).new(@size, 0)
      build 0, @size, true
    end

    def build(left, right, divx)
      return if left >= right
      middle = ((left + right) / 2).to_i

      sort(left, right)

      @tx[middle], @ty[middle] = @points[middle].x, @points[middle].y
      @count[middle] = right - left

      @minx[middle], @miny[middle] = T::MAX, T::MAX
      @maxx[middle], @maxy[middle] = T::MIN, T::MIN
      (left...right).each do |i|
        @minx[middle] = Math.min(@minx[middle], @points[i].x)
        @miny[middle] = Math.min(@miny[middle], @points[i].y)
        @maxx[middle] = Math.max(@maxx[middle], @points[i].x)
        @maxy[middle] = Math.max(@maxy[middle], @points[i].y)
      end

      build(left, middle, !divx)
      build(middle + 1, right, !divx)
    end

    private def sort(left, right, divx = true)
      middle = ((left + right) / 2).to_i
      loop do
        k = partition(left, right, middle, divx)
        return if k == middle
        right = k if middle < k
        left = k + 1 if middle > k
      end
    end

    private def partition(left, right, pivotIndex, divx)
      i, j = left, right - 1
      return j if i >= j
      pivot = divx ? @points[pivotIndex].x : @points[pivotIndex].y
      swap(i, pivotIndex)
      i += 1
      while i <= j
        while i <= j && (divx ? @points[i].x : @points[i].y) < pivot
          i += 1
        end
        while i <= j && (divx ? @points[i].x : @points[i].y) > pivot
          j -= 1
        end
        break if i >= j
        swap(i, j)
        i += 1
        j -= 1
      end
      swap(j, left)
      j
    end

    private def swap(i, j)
      @points[i], @points[j] = @points[j], @points[i]
    end

    def count(bottom_left, top_right)
      count(0, @tx.size, bottom_left, top_right)
    end

    private def count(left, right, bottom_left, top_right)
      return 0 if left >= right
      middle = ((left + right) / 2).to_i
      minx, miny, maxx, maxy = @minx[middle], @miny[middle], @maxx[middle], @maxy[middle]

      if top_right.x < minx || maxx < bottom_left.x || top_right.y < miny || maxy < bottom_left.y
        return 0
      end

      if bottom_left.x <= minx && maxx <= top_right.x && bottom_left.y <= miny && maxy <= top_right.y
        return @count[middle]
      end

      res = 0
      res += count(left, middle, bottom_left, top_right)
      res += count(middle + 1, right, bottom_left, top_right)
      res += 1 if minx <= @tx[middle] && @tx[middle] <= maxx && miny <= @ty[middle] && @ty[middle] <= maxy
      res
    end

    def nearest_neighbour(target)
      result = nearest_neighbour 0, @points.size, target, true, {T::MAX, -1}
      @points[result[1]]
    end

    private def nearest_neighbour(left, right, target, divx, best)
      return best if left >= right

      middle = ((left + right) / 2).to_i
      dx, dy = target.x - @points[middle].x, target.y - @points[middle].y
      dist = dx ** 2 + dy ** 2
      delta = divx ? dx : dy

      best = {dist, middle} if best[0] > dist

      if delta <= 0.0
        result = nearest_neighbour left, middle, target, !divx, best
        result = Math.min(result, nearest_neighbour middle + 1, right, target, !divx, best) if delta ** 2 < best[0]
        result
      else
        result = nearest_neighbour middle + 1, right, target, !divx, best
        result = Math.min(result, nearest_neighbour left, middle, target, !divx, best) if delta ** 2 < best[0]
        result
      end
    end
  end
end
