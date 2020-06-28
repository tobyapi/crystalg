module Crystalg::NumberTheory
  def gcd(a, b)
    while b != 0
      a, b = b, (a % b).to_i
    end
    a.abs
  end

  def lcm(a, b)
    (a / gcd(a, b) * b).abs
  end

  # returns {gcd(a,b), x, y} such that gcd(a,b) == a*x + b*y
  def extgcd(a, b)
    x, y, u, v = 0, 1, 1, 0
    while a != 0
      q = (b / a).to_i
      x, u = u, x - q * u
      y, v = v, y - q * v
      a, b = b - q * a, a
    end
    {b, x, y}
  end
end
