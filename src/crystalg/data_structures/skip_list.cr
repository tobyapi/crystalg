require "../random/xor128"

module Crystalg::DataStructures
  class SkipList
    private class Node
      getter value : Int32
      getter level : Int32
      property right : Node?
      property down : Node?

      def initialize(@value, @level, @right = nil, @down = nil)
      end

      def insert_to_right(new_node : Node)
        old = @right
        @right = new_node
        new_node.right = old
      end
    end

    @rng : Crystalg::Random::Xor128
    @origin : Node

    def initialize(@max_level : Int32, seed : UInt64 = 123456789)
      @rng = Crystalg::Random::Xor128.new(seed)
      level = @max_level
      @origin = Node.new(Int32::MIN, level)
      current = @origin
      while 0 < level
        level = level - 1
        current.down = Node.new(Int32::MIN, level)
        current = current.down.as(Node)
      end
    end

    def includes?(value : Int32)
      value == upper_bound(value, @max_level).@value
    end

    def insert(value : Int32)
      level = generate_level
      current = upper_bound(value, level)
      loop do
        if current.level <= level
          current.insert_to_right Node.new(value, current.level)
        end
        return if current.level == 0
        current.down = Node.new(value, current.level - 1)
        current = current.down.as(Node)
      end
    end

    private def upper_bound(value : Int32, level : Int32) : Node
      current = @origin
      while 0 < current.level
        while level < current.level
          current = current.down.as(Node)
          Helper.assert(!current.nil?)
        end

        unless current.nil?
          right = current.right
          break if right.nil? || right.value < value
          current = right
        end
      end
      current
    end

    private def generate_level
      (@rng.get & ((1 << @max_level) - 1)).to_i32
    end
  end
end
