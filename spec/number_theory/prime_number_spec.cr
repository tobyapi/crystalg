require "../spec_helper"

include Crystalg::NumberTheory

describe Crystalg do

  it "is_prime" do
    false.should eq(1.prime?)
    true.should eq(2.prime?)
    true.should eq(3.prime?)
    false.should eq(4.prime?)
    true.should eq(5.prime?)
    false.should eq(6.prime?)
    true.should eq(7.prime?)
    false.should eq(8.prime?)
    false.should eq(9.prime?)
    false.should eq(10.prime?)
    true.should eq(11.prime?)
    true.should eq(100000007.prime?)
    true.should eq(1000000007.prime?)
  end

  it "get_divisor" do
    result = divisor(15).sort
    answer = [1,3,5,15]
    true.should eq(result === answer)
  end

  it "prime_factorize" do
    result = prime_factorize(33)
    answer = {3 => 1, 11 => 1}
    true.should eq(answer === result)
  end
end
