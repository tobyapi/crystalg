module Crystalg::NumberTheory
  module Mod
    def self.mod(a, m)
      (a = a % m) >= 0 ? a : a + m
    end

    def self.inverse(a, m)
      raise "precondition: self > 0" if m <= 0
      raise "precondition: gcd(self, m) == 1" if gcd(a, m) != 1
      extgcd(a, m).x.mod m
    end

    def self.pow(y, exp, mod)
      result = 1
      while 0 < exp
        result = result * y % mod if (exp & 1) != 0
        y = y &* y % mod
        exp = exp >> 1
      end
      result
    end
  end
end
