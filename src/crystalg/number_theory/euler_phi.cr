
module Crystalg::NumberTheory

  # count the totatives of n that is the positive integers
  # less than or equal to n that are relatively prime to n
  def phi(n : Int32)
    res = n
    i = 2
    while i * i <= n
      if(n % i == 0)
        while n % i == 0
          n = n / i
        end
        res -= res / i
      end
      i = i.succ
    end
    res -= res / n if n > 1
    res
  end

  def phi_list(n : Int32): Array(Int32)
    result = Array.new(n + 1, 0)
    (1..n).each do |i| result[i] = i end
    (1..n).each do |i|
      j = i + 1
      while j <= n
        result[j] = result[j] - result[i]
        j = j + i
      end
    end
    result
  end
end
