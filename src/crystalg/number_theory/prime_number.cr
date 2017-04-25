
module Crystalg::NumberTheory
  def get_divisor(n)
    result = Array(Int32).new
    i = 1
    while i**2 <= n
      if n % i == 0
        result << i
        result << n / i if i != n / i
      end
      i = i.succ
    end
    result
  end

  def prime_factorize(n)
    result = Hash(Int32, Int32).new
    i = 2
    while i**2 <= n
      count = 0
      while n % i == 0
        count += 1
        n /= i
      end
      result[i] = count if count > 0
      i = i.succ
    end
    result[n] = 1 if n != 1
    result
  end

  def sieve_of_eratosthenes(n)
    result = Array(Bool).new(n + 1, true)
    result[0] = result[1] = false
    i = 2
    while i**2 <= n
      if result[i] == true
        j = i**2
        while j <= n
          result[j] = false
          j += i
        end
      end
      i = i.succ
    end
    result
  end
end
