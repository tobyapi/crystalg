module Crystalg::DataStructures
  # A randomized binary serach tree is  a binary tree selected
  # at random from some probability distribution on binary trees.
  #
  # ```
  # tree = RandomizedBinarySearchTree(Int32).new
  #
  # tree.insert(0, 1)
  # tree.insert(1, 2)
  # tree.insert(2, 3)
  # tree.insert(3, 4)
  # tree.insert(4, 5) # => [1, 2, 3, 4, 5]
  #
  # # splits to [0, index) and [index, n)
  # left, right = tree.split(3) # left => [1, 2, 3], right => [4, 5]
  #
  # right.merge(left) # => [4, 5, 1, 2, 3]
  # 
  # # reverses [left_index, right_index)
  # right.reverse(1, 4) # => [4, 2, 1, 5, 3]
  #
  # right.erase(2) # => [4, 2, 5, 3]
  #
  # right.find(0) # => 4
  # right.find(1) # => 2
  # right.find(2) # => 5
  # right.find(3) # => 3
  # ```
  class RandomizedBinarySearchTree(T)
    private class Node(T)
      def initialize(
        @key : Int32,
        @value : T,
        @left : Node(T)?  = nil,
        @right : Node(T)? = nil,
        @rev : Bool = false,
        @size : Int32 = 0
      )
      end

      getter left : Node(T)?
      getter right : Node(T)?
      getter key, value, size, rev

      setter left : Node(T)?
      setter right : Node(T)?
      setter size, rev
    end

    # :nodoc:
    setter root : Node(T)?
    @root : Node(T)? = nil

    # Creates a empty tree.
    def initialize
      @rnd = ::Random.new
    end

    # :nodoc:
    def initialize(@root : Node(T)?)
      @rnd = ::Random.new
    end

    private def push(t : Node(T)) : Node(T)
      left_size = t.left.nil? ? 0 : t.left.as(Node).size
      right_size = t.right.nil? ? 0 : t.right.as(Node).size
      t.size = left_size + right_size + 1

      if t.rev
        t.left, t.right = t.right, t.left
        t.left.as(Node).rev ^= true if !t.left.nil?
        t.right.as(Node).rev ^= true if !t.right.nil?
        t.rev = false
      end
      t
    end

    private def merge_rec(l : Node(T)?, r : Node(T)?) : Node(T)?
      l = push(l) if !l.nil?
      r = push(r) if !r.nil?

      if l.nil? || r.nil?
        return r if l.nil?
        return l
      end

      m, n = l.size, r.size
      if @rnd.next_int % (m + n) < m
        l.right = merge_rec(l.right, r)
        push(l)
      else
        r.left = merge_rec(l, r.left)
        push(r)
      end
    end

    # Merges two trees by O(log n). This method returns self, so several calls can be chained.
    #
    # ```
    # left = RandomizedBinarySearchTree(Int32).new
    # right = RandomizedBinarySearchTree(Int32).new
    #
    # [4, 5].each_with_index { |e, i| left.insert(i, e) }
    # [1, 2, 3].each_with_index { |e, i| right.insert(i, e) }
    #
    # left.merge(right)
    #
    # right.find(0) # => 4
    # right.find(1) # => 5
    # left.find(2) # => 1
    # left.find(3) # => 2
    # left.find(4) # => 3
    # ```
    def merge(other : RandomizedBinarySearchTree(T))
      @root = merge_rec(@root, other.@root)
      other.root = nil

      self
    end

    private def split_rec(k : Int32, t : Node(T)? = @root)
      t = push t if !t.nil?
      return {nil, nil} if t.nil?
      left_size = t.left.nil? ? 0 : t.left.as(Node(T)).size
      if k <= left_size
        l, r = split_rec(k, t.left)
        t.left = r
        {l, push(t)}
      else
        l, r = split_rec(k - left_size - 1, t.right)
        t.right = l
        {push(t), r}
      end
    end

    # Splits a tree to [0, index) and [index, n) by O(log n). 
    # After this method called, a receiver tree is empty.
    #
    # ```
    # tree = RandomizedBinarySearchTree(Int32).new
    #
    # [1, 2, 3, 4, 5].each_with_index { |e, i| tree.insert(i, e) }
    #
    # left, right = tree.split(3)
    #
    # left.find(0) # => 1
    # left.find(1) # => 2
    # left.find(2) # => 3
    # right.find(0) # => 4
    # right.find(1) # => 5
    # ```
    def split(index : Int32)
      left_root, right_root = split_rec(index, @root)
      left = RandomizedBinarySearchTree(T).new(left_root)
      right = RandomizedBinarySearchTree(T).new(right_root)
      @root = nil
      {left, right}
    end

    # Inserts a value by O(log n). This method returns self, so several calls can be chained.
    #
    # ```
    # tree = RandomizedBinarySearchTree(Int32).new
    # tree.insert(0, 1)
    # ```
    def insert(index : Int32, value : T)
      node = find_rec(index, @root)
      return self if !node.nil? && node.key == index
      left, right = split_rec(index)
      t = merge_rec(left, Node.new(index, value))
      t = merge_rec(t, right)
      @root = t.nil? ? t : push(t)

      self
    end

    # Erases a value by O(log n). This method returns self, so several calls can be chained.
    #
    # ```
    # tree = RandomizedBinarySearchTree(Int32).new
    # tree.insert(0, 1)
    #
    # tree.erase(0)
    # ```
    def erase(index : Int32)
      node = find_rec(index, @root)
      return self if node.nil? || node.key != index
      tmp, c = split_rec(index + 1, @root)
      a, b = split_rec(index, tmp)
      @root = merge_rec(a, c)
      @root = push(@root.as(Node(T))) if !@root.nil?

      self
    end

    # Updates a value by O(log n). This method returns self, so several calls can be chained.
    #
    # ```
    # tree = RandomizedBinarySearchTree(Int32).new
    # tree.insert(0, 1)
    #
    # tree.update(0, 2)
    # ```
    def update(index : Int32, value : T)
      node = find_rec(index, @root)
      return self if node.nil? || node.key != index
      tmp, c = split_rec(index + 1, @root)
      a, b = split_rec(index, tmp)
      @root = merge_rec(merge_rec(a, Node(T).new(index, value)), c)
      @root = push(@root.as(Node(T))) if !@root.nil?

      self
    end

    private def find_rec(index : Int32, t : Node(T)?) : Node(T)?
      return nil if t.nil?
      push(t)

      left_size = t.left.nil? ? 0 : t.left.as(Node(T)).size
      if index < left_size
        find_rec(index, t.left)
      elsif left_size == index
        t
      else
        find_rec(index - left_size - 1, t.right)
      end
    end

    # Returns a value by O(log n).
    #
    # ```
    # tree = RandomizedBinarySearchTree(Int32).new
    # tree.insert(0, 1)
    #
    # tree.find(0) # => 1
    # ```
    def find(index : Int32): T?
      result = find_rec(index, @root)
      return nil if result.nil?
      result.value
    end

    # Reverses values in [left_id, right_id) by O(log n). This method returns self, so several calls can be chained.
    #
    # ```
    # tree = RandomizedBinarySearchTree(Int32).new
    #
    # [1, 2, 3, 4, 5].each_with_index { |e, i| tree.insert(i, e) }
    #
    # tree.reverse(1, 4)
    #
    # tree.find(0) # => 1
    # tree.find(1) # => 4
    # tree.find(2) # => 3
    # tree.find(3) # => 2
    # tree.find(4) # => 5
    # ```
    def reverse(left_id : Int32, right_id : Int32)
      tmp, c = split_rec(right_id)
      a, b = split_rec(left_id, tmp)
      b.as(Node(T)).rev ^= true if !b.nil?
      merge_rec(merge_rec(a, b), c)

      self
    end
  end
end
