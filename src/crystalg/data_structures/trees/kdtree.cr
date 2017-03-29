require "../../geometry/*"

include Crystalg::Geometry

module Crystalg::Trees
  class KDTree
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

    def build(left : Int32, right : Int32, divx : Bool)
      return if left >= right
      middle = (left + right) / 2

      sort(left, right)

      @tx[middle], @ty[middle] = @points[middle].x, @points[middle].y
      @count[middle] = right - left

      @minx[middle], @miny[middle] = Float64::MAX, Float64::MAX
      @maxx[middle], @maxy[middle] = Float64::MIN, Float64::MIN
      (left...right).each do |i|
        @minx[middle] = Math.min(@minx[middle], @points[i].x)
        @miny[middle] = Math.min(@miny[middle], @points[i].y)
        @maxx[middle] = Math.max(@maxx[middle], @points[i].x)
        @maxy[middle] = Math.max(@maxy[middle], @points[i].y)
      end

      build(left, middle, !divx)
      build(middle + 1, right, !divx)
    end

    private def sort(left : Int32, right : Int32, divx : Bool = true)
      middle = (left + right) / 2
      loop do
        k = partition(left, right, middle ,divx)
        return if k == middle
        right = k if middle < k
        left = k + 1 if middle > k
      end
    end

    private def partition(left : Int32, right : Int32, pivotIndex : Int32, divx : Bool): Int32
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
        swap(i,j)
        i += 1
        j -= 1
      end
      swap(j, left)
      j
    end

    private def swap(i : Int32, j : Int32)
      @points[i], @points[j] = @points[j], @points[i]
    end

    def count(bottom_left : Point, top_right : Point)
      count(0, @tx.size, bottom_left, top_right)
    end

    private def count(left : Int32, right : Int32, bottom_left : Point, top_right : Point)
      return 0 if left >= right
      middle = (left + right) / 2
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
  end
end
