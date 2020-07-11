module Crystalg::DataStructures
  class RandomizedMeldableHeap(T)
    private class Node(T)
      property value : T
      property left : Node(T)?
      property right : Node(T)?

      def initialize(@value : T)
      end
    end

    # :nodoc:
    property root : Node(T)?

    @rng : Crystalg::Random::Xor128
    @size : Int32

    def initialize(seed : UInt64 = 123456789)
      @rng = Crystalg::Random::Xor128.new(seed)
      @root = nil
      @size = 0
    end

    # :nodoc:
    def meld(q1 : Node(T)?, q2 : Node(T)?)
      return q2 if q1.nil?
      return q1 if q2.nil?
      q1, q2 = q2, q1 if q2.value < q1.value

      if @rng.get % 2 == 0
        q1.left = meld(q1.left, q2)
      else
        q1.right = meld(q1.right, q2)
      end
      q1
    end

    def push(value : T)
      @root = meld(Node(T).new(value), @root)
      return if @root.nil?
      @size += 1

      self
    end

    def pop
      return if @root.nil?
      @root = meld(@root.as(Node(T)).left, @root.as(Node(T)).right)
      @size -= 1

      self
    end

    def top
      @root.as(Node(T)).value if !@root.nil?
    end

    private def remove_rec(node : Node(T)?, value): Node(T)?
      return node if node.nil? || value < node.value
      while !node.nil? && node.value == value
        node = meld(node.left, node.right)
      end
      return nil if node.nil?
      node.left = remove_rec(node.left, value)
      node.right = remove_rec(node.right, value)
      node
    end

    def remove(value)
      @root = remove_rec(@root, value)
      self
    end

    def absorb(other : RandomizedMeldableHeap(T))
      @root = meld(@root, other.root)
      other.root = nil
      self
    end
  end
end