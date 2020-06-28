require "../spec_helper"

include Crystalg::Trees

describe Crystalg do
  it "fenwick_tree_2d" do
    fenwick = FenwickTree2D(Int32).new(5_u32, 5_u32)
    (1..5).each { |e| fenwick.add(e, e, e) }

    (1..5).each { |e|
      true.should eq(fenwick.sum(e, e) === e * (e + 1) / 2)
    }
  end
end
