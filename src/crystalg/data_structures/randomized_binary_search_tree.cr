module Crystalg::DataStructures
  class RandomizedBinarySearchTree(T)

    class Node(T)
      def initialize(
        @value : T,
        @left : Node(T)?  = nil,
        @right : Node(T)? = nil,
        @rev : Bool = false,
        @size : Int32 = 0
      )
      end

      getter left : Node(T)?
      getter right : Node(T)?
      getter value, size, rev

      setter left : Node(T)?
      setter right : Node(T)?
      setter size, rev
    end

    def initialize
      @rnd = ::Random.new
    end

    @root : Node(T)? = nil

    private def propagate(t : Node(T)) : Node(T)
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
      l = propagate l if !l.nil?
      r = propagate r if !r.nil?

      if l.nil? || r.nil?
        return !l.nil? ? l : r
      end

      m, n = l.size, r.size
      if @rnd.next_int % (m + n) < m
        l.right = merge_rec l.right, r
        propagate l
      else
        r.left = merge_rec l, r.left
        propagate r
      end
    end

    def merge(l : Node(T)?, r : Node(T)?) : Node(T)?
      (@root = merge_rec(l, r))
    end

    def split(k : Int32, t : Node(T)? = @root)
      t = propagate t if !t.nil?
      return {nil, nil} if t.nil?
      left_size = t.left.nil? ? 0 : t.left.as(Node(T)).size
      if k <= left_size
        l, r = split k, t.left
        t.left = r
        {l, propagate t}
      else
        l, r = split(k - left_size - 1, t.right)
        t.right = l
        {propagate(t), r}
      end
    end

    private def insert(k : Int32, value : T, t : Node(T)?)
      l, r = split k
      t = merge_rec(l, Node.new value)
      t = merge_rec t, r
      t.nil? ? t : propagate(t)
    end

    private def erase(k, t)
      tmp, c = split k + 1, t
      a, b = split k, tmp
      t = merge_rec a, c
      t = propagate(t) if !t.nil?
      t
    end

    def insert(k, value)
      @root = insert(k, value, @root)
    end

    def erase(k)
      @root = erase(k, @root)
    end

    def find(k, t = @root)
      return nil if t.nil?
      propagate t

      left_size = t.left.nil? ? 0 : t.left.as(Node(T)).size
      if k < left_size
        find k, t.left
      elsif left_size == k
        t.value
      else
        find k - left_size - 1, t.right
      end
    end

    def reverse(left_id, right_id)
      tmp, c = split right_id
      a, b = split left_id, tmp
      b.as(Node(T)).rev ^= true if !b.nil?
      merge_rec(merge_rec(a, b), c)
    end
  end
end
