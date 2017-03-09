require "./spec_helper"

include Crystalg::Graph

describe Crystalg do

  it "priority_queue" do
    
    input = [1,2,3,4,5]
    output = [] of Int32

    queue = PriorityQueue(Int32).new
    
    input.each do |e|
      queue.push e
    end
        
    while !queue.empty?
      tmp = queue.pop!
      output << tmp if !tmp.nil?
    end
    true.should eq(input === output)
  end
  
  it "priority_queue2" do
    
    answer = [10,8,2,11]
    output = [] of Int32

    queue = PriorityQueue(Int32).new
    
    queue.push 10
    queue.push 11

    top = queue.pop!
    output << top if !top.nil?
    
    queue.push 8
    
    top = queue.pop!
    output << top if !top.nil?

    queue.push 2

    top = queue.pop!
    output << top if !top.nil?
    top = queue.pop!
    output << top if !top.nil?

    while !queue.empty?
      tmp = queue.pop!
      output << tmp if !tmp.nil?
    end
    true.should eq(answer === output)
  end
end