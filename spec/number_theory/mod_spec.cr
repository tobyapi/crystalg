require "../spec_helper"

include Crystalg::NumberTheory

describe Crystalg do
  it "pow" do
    true.should eq(Mod.pow(2, 3, 100) === 8)
    true.should eq(Mod.pow(5, 8, 1000000007) === 390625)
    true.should eq(Mod.pow(2, 30, 100000007) === 73741754)
  end
end
