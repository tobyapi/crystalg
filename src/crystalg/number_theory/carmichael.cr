module Crystalg::NumberTheory
  def carmichael(n)
    result = 1
    n /= 2 if n % 8 == 0
    (2..n).each do |d|
      if n % d == 0
        y = d - 1
        n /= d
        while n % d == 0
          n /= d
          y *= d
        end
        result = lcm(result, y)
      end
    end
    result
  end
end
