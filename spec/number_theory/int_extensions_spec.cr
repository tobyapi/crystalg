require "../spec_helper"

include Crystalg::NumberTheory

describe Crystalg do
  it "pow" do
    true.should eq(2.pow(3, 100) === 8)
    true.should eq(5.pow(8, 1000000007) === 390625)
    true.should eq(2.pow(30, 100000007) === 73741754)
  end
end
