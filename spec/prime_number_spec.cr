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
end