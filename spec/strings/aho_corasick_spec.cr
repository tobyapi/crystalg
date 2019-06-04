require "../spec_helper"

include Crystalg::Strings

describe Crystalg do
  it "aho_corasick match_suffix?" do
    aho_corasick = AhoCorasick.new(11)
    aho_corasick.add "abcde"
    aho_corasick.add "ab"
    aho_corasick.add "bc"
    aho_corasick.add "bab"
    aho_corasick.add "d"

    true.should eq aho_corasick.match_suffix? "abcde"
    true.should eq aho_corasick.match_suffix? "ab"
    true.should eq aho_corasick.match_suffix? "bc"
    true.should eq aho_corasick.match_suffix? "bab"
    true.should eq aho_corasick.match_suffix? "d"

    true.should eq aho_corasick.match_suffix? "abab"
    true.should eq aho_corasick.match_suffix? "ddddd"

    false.should eq aho_corasick.match_suffix? "a"
    false.should eq aho_corasick.match_suffix? "da"
    false.should eq aho_corasick.match_suffix? "zzzzz"
  end

  it "aho_corasick contain?" do
    aho_corasick = AhoCorasick.new(11)
    aho_corasick.add "abcde"
    aho_corasick.add "ab"
    aho_corasick.add "bc"
    aho_corasick.add "bab"
    aho_corasick.add "d"

    true.should eq aho_corasick.contain? "abcde"
    true.should eq aho_corasick.contain? "ab"
    true.should eq aho_corasick.contain? "bc"
    true.should eq aho_corasick.contain? "bab"
    true.should eq aho_corasick.contain? "d"

    false.should eq aho_corasick.contain? "abab"
    false.should eq aho_corasick.contain? "ddddd"

    false.should eq aho_corasick.contain? "a"
    false.should eq aho_corasick.contain? "da"
    false.should eq aho_corasick.contain? "zzzzz"
  end

  it "aho_corasick match_prefixes" do
    aho_corasick = AhoCorasick.new(11)
    aho_corasick.add "abcde"
    aho_corasick.add "ab"
    aho_corasick.add "bc"
    aho_corasick.add "bab"
    aho_corasick.add "d"

    true.should eq aho_corasick.match_prefixes("ab") == ["ab", "abcde"]
    true.should eq aho_corasick.match_prefixes("c") == [] of String
  end
end
