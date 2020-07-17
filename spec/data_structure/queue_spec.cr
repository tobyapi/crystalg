require "../spec_helper"

include Crystalg::Graph

describe Crystalg do
  it "queue" do
    input = [1, 2, 3, 4, 5]

    queue = Queue(Int32).new

    input.each do |e|
      queue.push e
    end

    output = [] of Int32
    while !queue.empty?
      tmp = queue.pop!
      output << tmp if !tmp.nil?
    end
    input.should eq(output)
  end
end
