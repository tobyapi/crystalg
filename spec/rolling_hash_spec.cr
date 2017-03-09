require "./spec_helper"

include Crystalg::Strings

describe Crystalg do

  it "rolling_hash" do
    
    input = "mississippi"

    hash = RollingHash.new input
           
    true.should eq(hash.count("issi") === 2)
  end
end