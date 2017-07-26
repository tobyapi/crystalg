module Crystalg::NumberTheory
  struct Fraction
    getter numerator : Int32
    getter denominator : Int32
    
    def initialize(@numerator, @denominator) end
  end

  class SternBrocotTree
    private struct Node
      getter left : Fraction
      getter right : Fraction
      getter middle
      
      def initialize(@left, @right) end

      def middle
        Fraction.new(
          left.numerator + right.numerator,
          left.denominator + right.denominator
        )
      end
    end

    private def rec(x, range, result)
      middle = range.middle
      return if middle.numerator + middle.denominator > x
      rec(x, Node.new(range.left, middle), result)
      result << middle
      rec(x, Node.new(middle, range.right), result)
    end

    def run(height)
      left, right = Fraction.new(0, 1), Fraction.new(1, 0)
      result = Array(Fraction).new
      rec(height, Node.new(left,right), result)
      result
    end
  end
end
