require "../spec_helper"

include Crystalg::Trees

describe Crystalg do
  it "segment_tree" do
    segtree = SegmetTree(Int32).new(5)
    (0...5).each { |i| segtree.add(i, i + 1, i) }

    (0...5).each do |e|
      true.should eq(segtree.min(e, e + 1) === e)
    end

    segtree.add(0, 5, 10)
    true.should eq(segtree.min(2,5) === 12)
  end
end
