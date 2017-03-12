require "./spec_helper"

include Crystalg::Trees

describe Crystalg do
  
  it "split randomized_binary_search_tree" do
    input = [1,2,3,4,5]
    tree = RandomizedBinarySearchTree(Int32).new
    input.each_with_index { |e, i|  
       tree.insert i, e
    }
    
    left, right = tree.split 3

    true.should eq(tree.find(0,left) === 1)
    true.should eq(tree.find(1,left) === 2)
    true.should eq(tree.find(2,left) === 3)
    
    true.should eq(tree.find(0,right) === 4)
    true.should eq(tree.find(1,right) === 5)
  end
  
  it "merge randomized_binary_search_tree" do
    input = [1,2,3,4,5]
    tree = RandomizedBinarySearchTree(Int32).new
    input.each_with_index { |e, i|  
       tree.insert i, e
    }
    
    left, right = tree.split 3
    tree.merge right, left

    true.should eq(tree.find(0) === 4)
    true.should eq(tree.find(1) === 5)
    true.should eq(tree.find(2) === 1)
    true.should eq(tree.find(3) === 2)
    true.should eq(tree.find(4) === 3)
  end

  it "insert randomized_binary_search_tree" do
    input = [1,2,3,4,5]
    tree = RandomizedBinarySearchTree(Int32).new
    input.each_with_index { |e, i|  
       tree.insert i, e
    }
    
    true.should eq(tree.find(0) === 1)
    true.should eq(tree.find(1) === 2)
    true.should eq(tree.find(2) === 3)
    true.should eq(tree.find(3) === 4)
    true.should eq(tree.find(4) === 5)
  end
  
  it "erase randomized_binary_search_tree" do
    input = [1,2,3,4,5]
    tree = RandomizedBinarySearchTree(Int32).new
    input.each_with_index { |e, i|  
       tree.insert i, e
    }
      
    tree.erase(2)

    true.should eq(tree.find(0) === 1)
    true.should eq(tree.find(1) === 2)
    true.should eq(tree.find(2) === 4)
    true.should eq(tree.find(3) === 5)  
  end
  
  
  it "reverse randomized_binary_search_tree" do
    input = [1,2,3,4,5]
    tree = RandomizedBinarySearchTree(Int32).new
    input.each_with_index { |e, i|  
       tree.insert i, e
    }
    
    tree.reverse(0,5)

    true.should eq(tree.find(0) === 5)
    true.should eq(tree.find(1) === 4)
    true.should eq(tree.find(2) === 3)
    true.should eq(tree.find(3) === 2)
    true.should eq(tree.find(4) === 1)  
  end
  
end