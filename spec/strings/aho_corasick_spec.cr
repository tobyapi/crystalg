require "../spec_helper"

include Crystalg::Strings

describe Crystalg do
  it "aho_corasick match?" do
    aho_corasick = AhoCorasick.new(11)
    aho_corasick.add "abcde"
    aho_corasick.add "ab"
    aho_corasick.add "bc"
    aho_corasick.add "bab"
    aho_corasick.add "d"

    true.should eq aho_corasick.match? "abcde"
    true.should eq aho_corasick.match? "ab"
    true.should eq aho_corasick.match? "bc"
    true.should eq aho_corasick.match? "bab"
    true.should eq aho_corasick.match? "d"
    
    true.should eq aho_corasick.match? "abab"
    true.should eq aho_corasick.match? "ddddd"

    false.should eq aho_corasick.match? "a"
    false.should eq aho_corasick.match? "da"
    false.should eq aho_corasick.match? "zzzzz"
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
end