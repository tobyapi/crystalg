require "../spec_helper"

include Crystalg::DataStructures

describe Crystalg do
  it "SkewHeap" do
    sl = SkipList.new(20)
    false.should eq sl.includes?(7)

    sl.insert(88)

    false.should eq sl.includes?(7)
    true.should eq sl.includes?(88)

    sl.insert(7)

    true.should eq sl.includes?(7)
    true.should eq sl.includes?(88)
  end
end
