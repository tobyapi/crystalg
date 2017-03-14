struct Int
  def is_prime?: Bool
    n = self
    i = 2
    while i * i <= n
      return false if n % i == 0
      i = i.succ
    end
    n != 1
  end

  def mod(m : Int64)
    (a = self % m) >= 0 ? a : a + m
  end

  def inverse(m : Int64)
    raise "precondition: self > 0" if m <= 0
    raise "precondition: gcd(self, m) == 1" if gcd(self, m) != 1
    extgcd(a, m).x.mod m
  end
end
