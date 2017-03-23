require "../spec_helper"

include Crystalg::Graph

describe Crystalg do
  it "HopcroftKarp" do
    hopcroft_karp = HopcroftKarp.new(2,2)
    hopcroft_karp.add_edge(0, 0)
    hopcroft_karp.add_edge(0, 1)
    hopcroft_karp.add_edge(1, 1)
    true.should eq(hopcroft_karp.bipartite_matching === 2)
  end
end
