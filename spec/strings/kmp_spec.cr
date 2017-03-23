require "../spec_helper"

include Crystalg::Strings

describe Crystalg do

  it "kmp" do

    input = "mississippi"

    hash = RollingHash.new input

    result = kmp(input, "issi")

    true.should eq(result === [1,4])
  end
end
