require "../spec_helper"

include Crystalg::Trees

describe Crystalg do
  it "fenwick_tree" do
    fenwick = FenwickTree(Int64).new(5_u32)
    (1..5).each { |e| fenwick.add(e, e.to_i64) }
    (1..5).each { |e|
      true.should eq(fenwick.sum(e) === e * (e + 1) / 2)
    }
  end
end
