require "../spec_helper"

include Crystalg::Graph

describe Crystalg do
  it "HopcroftKarp" do
    hopcroft_karp = HopcroftKarp.new(3, 4)
    hopcroft_karp.add_edge(0, 0)
    hopcroft_karp.add_edge(0, 2)
    hopcroft_karp.add_edge(0, 3)
    hopcroft_karp.add_edge(1, 1)
    hopcroft_karp.add_edge(2, 1)
    hopcroft_karp.add_edge(2, 3)
    true.should eq(hopcroft_karp.bipartite_matching === 3)
  end
end
