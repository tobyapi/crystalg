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
end