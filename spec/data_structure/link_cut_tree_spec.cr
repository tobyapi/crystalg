require "../spec_helper"

include Crystalg::DataStructures

describe Crystalg do
  it "rotate" do
    # rotate(1)
    #
    #     0          1
    #    / \        / \
    #   1  2  <=>  3  0
    #  / \           / \
    # 3  4          4  2

    lctree = LinkCutTree(Int32).new(5)
    lctree.link(1, 0)
    lctree.link(2, 0)
    lctree.link(3, 1)
    lctree.link(4, 1)
    lctree.@rev[1] = false
    lctree.@rev[2] = false
    lctree.@rev[3] = false
    lctree.@rev[4] = false

    lctree.@left[0] = 1
    lctree.@left[1] = 3

    lctree.@right[0] = 2
    lctree.@right[1] = 4

    lctree.rotate(1)

    true.should eq(lctree.@parent === [1, nil, 0, 1, 0])
    true.should eq(lctree.@left === [4, 3, nil, nil, nil])
    true.should eq(lctree.@right === [2, 0, nil, nil, nil])
    true.should eq(lctree.@rev === [false, false, false, false, false])

    lctree.rotate(0)

    true.should eq(lctree.@parent === [nil, 0, 0, 1, 1])
    true.should eq(lctree.@left === [1, 3, nil, nil, nil])
    true.should eq(lctree.@right === [2, 4, nil, nil, nil])
    true.should eq(lctree.@rev === [false, false, false, false, false])
  end

  it "lca" do
    #     0
    #    /|＼
    #   1 2  3
    #  /＼
    # 4   5
    #     /＼
    #    6   7

    lctree = LinkCutTree(Int32).new(8)
    lctree.link(1, 0)
    lctree.link(2, 0)
    lctree.link(3, 0)
    lctree.link(4, 1)
    lctree.link(5, 1)
    lctree.link(6, 5)
    lctree.link(7, 5)
    true.should eq(lctree.lca(4, 6) === 1)
    true.should eq(lctree.lca(4, 7) === 1)
    true.should eq(lctree.lca(4, 3) === 0)
    true.should eq(lctree.lca(5, 2) === 0)
    true.should eq(lctree.lca(6, 7) === 5)
  end
end
