require "../spec_helper"

describe Crystalg do
  it "SkewHeap" do
    heap = SkewHeap(Int32).new
    heap.push 5
    heap.push 3
    heap.push 8

    heap.top.should eq 3

    heap.push 1
    heap.top.should eq 1

    heap.pop
    heap.top.should eq 3

    heap.pop
    heap.top.should eq 5

    heap.pop
    heap.top.should eq 8
  end

  it "SkewHeap absorb" do
    heap1 = SkewHeap(Int32).new
    heap1.push 5
    heap1.push 3
    heap1.push 8

    heap2 = SkewHeap(Int32).new
    heap2.push 2
    heap2.push 3
    heap2.push 9

    heap1.absorb(heap2)

    heap1.top.should eq 2

    heap1.push 1
    heap1.top.should eq 1

    [2, 3, 3, 5, 8, 9].each do |e|
      heap1.pop
      heap1.top.should eq e
    end
  end
end
