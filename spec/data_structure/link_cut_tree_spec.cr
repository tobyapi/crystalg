require "../spec_helper"

include Crystalg::Trees

describe Crystalg do
  it "node" do

    lctree = LinkCutTree(Int32).new(10)
    lctree.add(1,1)
  end
end
