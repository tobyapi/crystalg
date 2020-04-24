require "../spec_helper"

include Crystalg::NumberTheory

describe Crystalg do
  it "phi" do
    true.should eq(phi(6) === 2)
    true.should eq(phi(1000000) === 400000)
  end

  it "phi_list" do
    input = Array(Int32).new
    (0..10000).each do |i| input << (phi i).to_i end
    true.should eq(phi_list(10000) === input)
  end
end
