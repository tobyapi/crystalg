require "./spec_helper"

describe Crystalg do
  it "fenwick_tree_2d" do
    fenwick = FenwickTree2D(Int32).new(5,5)
    (1..5).each { |e| fenwick.add(e, e, e) }

    (1..5).each { |e| 
      true.should eq(fenwick.sum(e,e) === e * (e + 1) / 2)
    }
  end
end
