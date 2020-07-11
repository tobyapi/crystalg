require "../spec_helper"

include Crystalg::DataStructures

describe Crystalg do
  it "fenwick_tree" do
    fenwick = FenwickTree(Int32).new(6)

    (0..5).each { |e| fenwick[e] = e }
    (0..6).each do |e|
      expected = ((e - 1) * e / 2).to_i
      fenwick.sum(e).should eq expected
    end
  end
end
