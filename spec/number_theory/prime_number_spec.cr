require "../spec_helper"

include Crystalg::NumberTheory

describe Crystalg do
  it "is_prime" do
    false.should eq(prime?(1))
    true.should eq(prime?(2))
    true.should eq(prime?(3))
    false.should eq(prime?(4))
    true.should eq(prime?(5))
    false.should eq(prime?(6))
    true.should eq(prime?(7))
    false.should eq(prime?(8))
    false.should eq(prime?(9))
    false.should eq(prime?(10))
    true.should eq(prime?(11))
    true.should eq(prime?(100000007))
    true.should eq(prime?(1000000007))
  end

  it "get_divisor" do
    result = divisor(15).sort
    answer = [1, 3, 5, 15]
    true.should eq(result === answer)
  end

  it "prime_factorize" do
    result = prime_factorize(33)
    answer = {3 => 1, 11 => 1}
    true.should eq(answer === result)
  end
end
