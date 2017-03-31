require "../spec_helper"

include Crystalg::Strings

describe Crystalg do
  it "baker_bird" do
    field = [
      "00010",
      "00101",
      "00010",
      "00100"
    ]
    
    pattern = [
      "10",
      "01",
      "10"
    ]
    
    answer = [{0,3},{1,2}]
    
    true.should eq (answer === BakerBird.new(field).search pattern)
  end
end