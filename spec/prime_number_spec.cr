require "./spec_helper"

include Crystalg::NumberTheory

describe Crystalg do

  it "is_prime" do
    false.should eq(1.is_prime?)
    true.should eq(2.is_prime?)
    true.should eq(3.is_prime?)
    false.should eq(4.is_prime?)
    true.should eq(5.is_prime?)
    false.should eq(6.is_prime?)
    true.should eq(7.is_prime?)
    false.should eq(8.is_prime?)
    false.should eq(9.is_prime?)
    false.should eq(10.is_prime?)
    true.should eq(11.is_prime?)
    true.should eq(100000007.is_prime?)
    true.should eq(1000000007.is_prime?)    
  end
  
  it "get_divisor" do
    result = get_divisor(15).sort
    answer = [1,3,5,15]
    true.should eq(result === answer)
  end
  
  it "prime_factorize" do
    result = prime_factorize(33)
    answer = {3 => 1, 11 => 1}
    true.should eq(answer === result)
  end
end