require "../spec_helper"

include Crystalg::DataStructures

describe Crystalg do
  it "fenwick_tree_2d" do
    fenwick = FenwickTree2D(Int32).new(6, 6)
    (0..5).each { |e| fenwick[e, e] = e }

    (0..6).each do |e|
      expected = (e - 1) * e / 2
      fenwick.sum(e, e).should eq expected
    end
  end

  it "fenwick_tree_2d 2" do
    # fenwick tree:   sum[x, y]:
    #  1  2  3         1   3   6
    #  4  5  6         5  12  21
    #  7  8  9        12  27  45
    # 10 11 12        22  48  78

    fenwick = FenwickTree2D(Int32).new(4, 3)
    (0..3).each do |row|
      (0..2).each do |col|
        fenwick[row, col] = row * 3 + col + 1
      end
    end

    expected = [
      [0, 0, 0, 0],
      [0, 1, 3, 6],
      [0, 5, 12, 21],
      [0, 12, 27, 45],
      [0, 22, 48, 78],
    ]

    (0..4).each do |row|
      (0..3).each do |col|
        fenwick.sum(row, col).should eq expected[row][col]
      end
    end
  end
end
