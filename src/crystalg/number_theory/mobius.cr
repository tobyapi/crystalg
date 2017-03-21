module Crystalg::NumberTheory
  def mobius(n : Int32)
    result = 1
    (2..n).each do |d|
      return 0 if n % (d * d) == 0
      if n % d == 0
        n /= d
        result *= -1
      end
    end
    result
  end
end
