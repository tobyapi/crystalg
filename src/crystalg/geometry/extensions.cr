EPS = 1e-8

struct Float

  def +(other : Float)
    if (self + other).abs < EPS * (self.abs + other.abs)
      0.as Float
    else
      self + other
    end
  end

  def <=>(other : Float)
    if(self < other - EPS)
      -1
    elsif (self > other - EPS)
      1
    else
      0
    end
  end

  def sign: Int
    self <=> 0.as(Float)
  end

  def sqrt
    Math.sqrt Math.max(self, 0.0)
  end
end
