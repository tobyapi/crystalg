require "./spec_helper"

include Crystalg::NumberTheory

describe Crystalg do

  it "is_prime" do
    false.should eq(is_prime? 1)
    true.should eq(is_prime? 2)
    true.should eq(is_prime? 3)
    false.should eq(is_prime? 4)
    true.should eq(is_prime? 5)
    false.should eq(is_prime? 6)
    true.should eq(is_prime? 7)
    false.should eq(is_prime? 8)
    false.should eq(is_prime? 9)
    false.should eq(is_prime? 10)
    true.should eq(is_prime? 11)
    true.should eq(is_prime? 100000007)
    true.should eq(is_prime? 1000000007)    
  end
  
  it "get_divisor" do
    result = get_divisor(15).sort
    answer = [1,3,5,15]
    true.should eq(result === answer)
  end
  
  it "prime_factorize" do
    result = prime_factorize 33
    answer = {3 => 1, 11 => 1}
    true.should eq(answer === result)
  end
end