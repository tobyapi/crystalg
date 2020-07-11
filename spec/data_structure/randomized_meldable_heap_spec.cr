require "../spec_helper"

include Crystalg::DataStructures

describe Crystalg do
  it "randomized_meldable_heap" do
    heap = RandomizedMeldableHeap(Int32).new
    [10, 8, 2, 2, 2, 11, 2].each { |e| heap.push(e) }

    heap.top.should eq 2
    heap.pop
    heap.top.should eq 2
    heap.pop
    heap.top.should eq 2
    heap.pop
    heap.top.should eq 2
    heap.pop
    heap.top.should eq 8
    heap.pop
    heap.top.should eq 10
    heap.pop
    heap.top.should eq 11
    heap.pop
    heap.top.should eq nil
  end

  it "randomized_meldable_heap remove" do
    heap = RandomizedMeldableHeap(Int32).new
    [10, 1, 2, 2, 2, 11, 2].each { |e| heap.push(e) }
    
    heap.remove(2)

    heap.top.should eq 1
    heap.pop
    heap.top.should eq 10
    heap.pop
    heap.top.should eq 11
    heap.pop
    heap.top.should eq nil
  end

  it "randomized_meldable_heap absorb" do
    heap1 = RandomizedMeldableHeap(Int32).new
    heap2 = RandomizedMeldableHeap(Int32).new
    [1, 2, 3].each { |e| heap1.push(e) }
    [4, 5, 6].each { |e| heap2.push(e) }
    
    heap1.absorb(heap2)

    heap2.top.should eq nil

    heap1.top.should eq 1
    heap1.pop
    heap1.top.should eq 2
    heap1.pop
    heap1.top.should eq 3
    heap1.pop
    heap1.top.should eq 4
    heap1.pop
    heap1.top.should eq 5
    heap1.pop
    heap1.top.should eq 6
    heap1.pop
    heap1.top.should eq nil
  end
end