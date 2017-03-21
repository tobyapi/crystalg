module Crystalg::NumberTheory
  struct Fraction
    getter numerator, denominator
    def initialize(@numerator : Int32, @denominator : Int32) end
  end

  class SternBrocotTree
    struct Node
      getter left, right, middle
      def initialize(@left : Fraction, @right : Fraction) end

      def middle : Fraction
        Fraction.new(
          left.numerator + right.numerator,
          left.denominator + right.denominator
        )
      end
    end

    private def rec(x : Int32, range : Node, result : Array(Fraction))
      middle = range.middle
      return if middle.numerator + middle.denominator > x
      rec(x, Node.new(range.left, middle), result)
      result << middle
      rec(x, Node.new(middle, range.right), result)
    end

    def run(height : Int32)
      left = Fraction.new(0,1)
      right = Fraction.new(1,0)
      result = Array(Fraction).new
      rec(height, Node.new(left,right), result)
      result
    end
  end
end
