require "../spec_helper"

include Crystalg::Strings

describe Crystalg do
  it "suffix_array" do
    input = "abracadabra"

    result = SuffixArray.new(input)
    result.construct

    ans = [11,10,7,0,3,5,8,1,4,6,9,2]

    true.should eq(result.@suffix_array === ans)
  end

  it "lcp" do
    input = "banana"
    result = SuffixArray.new(input)
    result.construct

    ans = [0,1,3,0,0,2,0]

    true.should eq(result.@lcp === ans)
  end
end
