require "./spec_helper"

include Crystalg::NumberTheory

describe Crystalg do
  it "mobius" do
    true.should eq(mobius(1) === 1)
    true.should eq(mobius(2) === -1)
    true.should eq(mobius(3) === -1)
    true.should eq(mobius(4) === 0)
    true.should eq(mobius(5) === -1)
    true.should eq(mobius(6) === 1)
    true.should eq(mobius(7) === -1)
    true.should eq(mobius(8) === 0)
    true.should eq(mobius(9) === 0)
    true.should eq(mobius(10) === 1)        
  end
end
