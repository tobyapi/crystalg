require "./spec_helper"

include Crystalg::DataStructures

describe Crystalg do

  it "rolling_hash" do
    
    uf = UnionFind.new(5)
    
    uf.unite(0,1)
    uf.unite(3,4)

    true.should eq(uf.same?(0,1) === true)
    true.should eq(uf.same?(0,2) === false)
    true.should eq(uf.same?(0,4) === false)
    
    true.should eq(uf.size(0) === 2)
    true.should eq(uf.size(1) === 2)
    true.should eq(uf.size(2) === 1)
    true.should eq(uf.size(3) === 2)
    true.should eq(uf.size(4) === 2)
    
    uf.unite(0,2)
    uf.unite(2,4)
    
    true.should eq(uf.size(0) === uf.@size)
  end
end