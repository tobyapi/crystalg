require "../spec_helper"

include Crystalg::Graph

describe Crystalg do
  it "SkewHeap" do
    heap = SkewHeap(Int32).new

    heap.push 5
    heap.push 3
    heap.push 8
    true.should eq(heap.top === 3)

    heap.push 1
    true.should eq(heap.top === 1)

    heap.pop
    true.should eq(heap.top === 3)

    heap.pop
    true.should eq(heap.top === 5)

    heap.pop
    true.should eq(heap.top === 8)
  end
end
