require "./spec_helper"

include Crystalg::NumberTheory

describe Crystalg do
  it "charmichael" do
    true.should eq(carmichael(1) === 1)
    true.should eq(carmichael(2) === 1)
    true.should eq(carmichael(3) === 2)
    true.should eq(carmichael(4) === 2)
    true.should eq(carmichael(5) === 4)
    true.should eq(carmichael(6) === 2)
    true.should eq(carmichael(7) === 6)
    true.should eq(carmichael(8) === 2)
    true.should eq(carmichael(9) === 6)
    true.should eq(carmichael(10) === 4)
  end
end
