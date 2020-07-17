require "../spec_helper"

include Crystalg::DataStructures

describe Crystalg do
  it "split randomized_binary_search_tree" do
    input = [1, 2, 3, 4, 5]
    tree = RandomizedBinarySearchTree(Int32).new
    input.each_with_index { |e, i|
      tree.insert i, e
    }

    left, right = tree.split 3

    left.find(0).should eq 1
    left.find(1).should eq 2
    left.find(2).should eq 3

    right.find(0).should eq 4
    right.find(1).should eq 5
  end

  it "merge randomized_binary_search_tree" do
    input = [1, 2, 3, 4, 5]
    tree = RandomizedBinarySearchTree(Int32).new
    input.each_with_index { |e, i|
      tree.insert i, e
    }

    left, right = tree.split 3
    right.merge left

    right.find(0).should eq 4
    right.find(1).should eq 5
    right.find(2).should eq 1
    right.find(3).should eq 2
    right.find(4).should eq 3
  end

  it "insert randomized_binary_search_tree" do
    input = [1, 2, 3, 4, 5]
    tree = RandomizedBinarySearchTree(Int32).new
    input.each_with_index { |e, i|
      tree.insert i, e
    }

    tree.find(0).should eq 1
    tree.find(1).should eq 2
    tree.find(2).should eq 3
    tree.find(3).should eq 4
    tree.find(4).should eq 5
  end

  it "erase randomized_binary_search_tree" do
    input = [1, 2, 3, 4, 5]
    tree = RandomizedBinarySearchTree(Int32).new
    input.each_with_index { |e, i|
      tree.insert i, e
    }

    tree.erase(2)

    tree.find(0).should eq 1
    tree.find(1).should eq 2
    tree.find(2).should eq 4
    tree.find(3).should eq 5
  end

  it "reverse randomized_binary_search_tree" do
    input = [1, 2, 3, 4, 5]
    tree = RandomizedBinarySearchTree(Int32).new
    input.each_with_index { |e, i|
      tree.insert i, e
    }

    tree.reverse(0, 5)

    tree.find(0).should eq 5
    tree.find(1).should eq 4
    tree.find(2).should eq 3
    tree.find(3).should eq 2
    tree.find(4).should eq 1
  end

  it "test" do
    tree = RandomizedBinarySearchTree(Int32).new
    tree.insert(0, 1)
    tree.insert(1, 2)
    tree.insert(2, 3)

    tree.erase(1)
    tree.erase(1)

    tree.insert(1, 100)
    tree.update(1, 1000)

    tree.find(0).should eq 1
    tree.find(1).should eq 1000
    tree.find(2).should eq 3
    tree.find(3).should eq nil
  end
end
