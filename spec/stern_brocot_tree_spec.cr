require "./spec_helper"

include Crystalg::NumberTheory

describe Crystalg do
  it "stern_brocot" do
    ans = [
      Fraction.new(1,4),
      Fraction.new(1,3),
      Fraction.new(1,2),
      Fraction.new(2,3),
      Fraction.new(1,1),
      Fraction.new(3,2),
      Fraction.new(2,1),
      Fraction.new(3,1),
      Fraction.new(4,1)
    ]

    result = SternBrocotTree.new.run(5)

    true.should eq(ans === result)
  end
end
