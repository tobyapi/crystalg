
module Crystalg::NumberTheory
  
  def is_prime?(n : Int) : Bool
    i = 2
    while i * i <= n
      return false if n % i == 0
      i = i.succ
    end
    n != 1
  end

end