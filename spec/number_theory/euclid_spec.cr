require "../spec_helper"

include Crystalg::NumberTheory

describe Crystalg do

  it "gcd" do
    true.should eq(gcd(2, 3) === 1)
    true.should eq(gcd(8, 12) === 4)
    true.should eq(gcd(16, 16) === 16)
    true.should eq(gcd(50000000, 30000000) === 10000000)
    true.should eq(gcd(10000000, 1000000007) === 1)
  end

  it "lcm" do
    true.should eq(lcm(8, 6) === 24)
    true.should eq(lcm(50000000, 30000000) === 150000000)
  end

  it "extgcd" do
    true.should eq(extgcd(4, 12) === {4, 1, 0})
    true.should eq(extgcd(3, 8) === {1, 3, -1})
  end

end
