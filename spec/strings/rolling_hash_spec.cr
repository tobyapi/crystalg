require "../spec_helper"

include Crystalg::Strings

describe Crystalg do

  it "rolling_hash" do

    input = "mississippi"

    hash = RollingHash.new input

    true.should eq(hash.count("issi") === 2)
  end

  it "get_suffix_array" do

    input = "abracadabra"

    result = RollingHash.new(input).get_suffix_array

    ans = [11,10,7,0,3,5,8,1,4,6,9,2]

    true.should eq(result === ans)
  end
end
