require "../../geometry/*"

include Crystalg::Geometry

module Crystalg::Trees
  class KDTree
    getter size, points
    private property tx, ty, minx, miny, maxx, maxy, count
    
    @size : Int32
    def initialize(@points : Array(Point))
      @size = points.size
      @tx = Array(Float64).new(@size, 0.0)
      @ty = Array(Float64).new(@size, 0.0)
      @minx = Array(Float64).new(@size, 0.0)
      @miny = Array(Float64).new(@size, 0.0)
      @maxx = Array(Float64).new(@size, 0.0)
      @maxy = Array(Float64).new(@size, 0.0)
      @count = Array(Int32).new(@size, 0)
      build 0, @size, true
    end

    private def build(left, right, divx)
      return if left >= right
      middle = (left + right) / 2

      sort(left, right, divx)

      tx[middle], ty[middle] = points[middle].x, points[middle].y
      count[middle] = right - left

      minx[middle], miny[middle] = Float64::MAX, Float64::MAX
      maxx[middle], maxy[middle] = Float64::MIN, Float64::MIN
      (left...right).each do |i|
        minx[middle] = Math.min(minx[middle], points[i].x)
        miny[middle] = Math.min(miny[middle], points[i].y)
        maxx[middle] = Math.max(maxx[middle], points[i].x)
        maxy[middle] = Math.max(maxy[middle], points[i].y)
      end

      build(left, middle, !divx)
      build(middle + 1, right, !divx)
    end

    private def sort(left, right, divx = true)
      middle = (left + right) / 2
      loop do
        k = partition(left, right, middle ,divx)
        return if k == middle
        right = k if middle < k
        left = k + 1 if middle > k
      end
    end

    private def partition(left, right, pivotIndex, divx)
      i, j = left, right - 1
      return j if i >= j
      pivot = divx ? points[pivotIndex].x : points[pivotIndex].y
      swap(i, pivotIndex)
      i += 1
      while i <= j
        while i <= j && (divx ? points[i].x : points[i].y) < pivot
          i += 1
        end
        while i <= j && (divx ? points[j].x : points[j].y) > pivot
          j -= 1
        end
        break if i >= j
        swap i, j
        i += 1
        j -= 1
      end
      swap j, left
      j
    end

    private def swap(i, j)
      points[i], points[j] = points[j], points[i]
    end

    def count(bottom_left, top_right)
      count(0, tx.size, bottom_left, top_right)
    end

    private def count(left, right, bottom_left, top_right)
      return 0 if left >= right
      middle = (left + right) / 2
      mminx, mminy, mmaxx, mmaxy = minx[middle], miny[middle], maxx[middle], maxy[middle]

      if top_right.x < mminx || mmaxx < bottom_left.x || top_right.y < mminy || mmaxy < bottom_left.y
        return 0
      end

      if bottom_left.x <= mminx && mmaxx <= top_right.x && bottom_left.y <= mminy && mmaxy <= top_right.y
        return count[middle]
      end

      res = 0
      res += count(left, middle, bottom_left, top_right)
      res += count(middle + 1, right, bottom_left, top_right)
      res += 1 if mminx <= tx[middle] && tx[middle] <= mmaxx && mminy <= ty[middle] && ty[middle] <= mmaxy
      res
    end

    def nearest_neighbour(target)
      result = nearest_neighbour 0, points.size, target, true, { Float64::MAX, -1 }
      points[result[1]]
    end

    private def nearest_neighbour(left, right, target, divx, best)
      return best if left >= right

      middle = (left + right) / 2
      dx, dy = target.x - points[middle].x, target.y - points[middle].y
      dist = dx**2 + dy**2
      delta = divx ? dx : dy

      best = { dist, middle } if best[0] > dist

      if delta <= 0.0
        result = nearest_neighbour left, middle, target, !divx, best
        result = Math.min(result, nearest_neighbour middle + 1, right, target, !divx, best) if delta**2 < best[0]
        result
      else
        result = nearest_neighbour middle + 1, right, target, !divx, best
        result = Math.min(result, nearest_neighbour left, middle, target, !divx, best) if delta**2 < best[0]
        result
      end
    end
  end
end
