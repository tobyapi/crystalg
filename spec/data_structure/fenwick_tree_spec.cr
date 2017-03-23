require "../spec_helper"

describe Crystalg do
  it "fenwick_tree" do
    fenwick = FenwickTree(Int64).new(5)
    (1..5).each { |e| fenwick.add(e, e.to_i64) }
    (1..5).each { |e|
      true.should eq(fenwick.sum(e) === e * (e + 1) / 2)
    }
  end
end
