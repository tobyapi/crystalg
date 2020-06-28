require "../spec_helper"

include Crystalg::Graph

describe Crystalg do
  it "stack" do
    input = [1, 2, 3, 4, 5]
    answer = [5, 4, 3, 2, 1]

    stack = Stack(Int32).new

    input.each do |e|
      stack.push e
    end

    output = [] of Int32
    while !stack.empty?
      tmp = stack.pop!
      output << tmp if !tmp.nil?
    end
    true.should eq(output === answer)
  end
end
