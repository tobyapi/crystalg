module Crystalg::NumberTheory
  def divisor(n)
    result = Array(Int32).new
    (1..Math.sqrt(n).to_i).each do |i|
      if (n % i == 0)
        result << i
        result << (n / i).to_i if i != n / i
      end
    end
    result
  end

  def prime?(n)
    i = 2
    while i * i <= n
      return false if n % i == 0
      i += 1
    end
    n != 1
  end
  
  def prime_factorize(n)
    result = Hash(Int32, Int32).new

    (2..Math.sqrt(n).to_i).each do |i|
      count = 0
      while n % i == 0
        count += 1
        n = (n / i).to_i
      end
      result[i] = count if count > 0
    end
    result[n] = 1 if n != 1
    result
  end

  def sieve_of_eratosthenes(n)
    result = Array(Bool).new(n + 1, true)
    result[0] = result[1] = false
    (2..Math.sqrt(n).to_i).each do |i|
      if (result[i] == true)
        (i*i..n).step(i).each { |i| result[j] = false }
      end
    end
    result
  end
end
