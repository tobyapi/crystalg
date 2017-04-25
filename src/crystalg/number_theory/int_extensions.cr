struct Int
  def is_prime?
    n = self
    i = 2
    while i**2 <= n
      return false if n % i == 0
      i = i.succ
    end
    n != 1
  end

  def mod(m)
    (a = self % m) >= 0 ? a : a + m
  end

  def inverse(m)
    raise "precondition: self > 0" if m <= 0
    raise "precondition: gcd(self, m) == 1" if gcd(self, m) != 1
    extgcd(a, m).x.mod m
  end

  def pow(exp, mod)
    y = self
    result = 1
    while exp > 0
      result = result * y % mod if (exp & 1) != 0
      y = y**2 % mod
      exp /= 2
    end
    result
  end
end
