module Crystalg::DataStructures
  class RandomizedBinarySearchTree(T)
    class Empty
      @size = 0
      @rev = false

      getter size, rev
      setter rev

      private def initialize
      end

      def self.instance : Empty
        @@instance ||= new
      end
    end

    class TreeNode(T)
      def initialize(
        @value : T,
        @left : (TreeNode(T) | Empty) = Empty.instance,
        @right : (TreeNode(T) | Empty) = Empty.instance,
        @rev : Bool = false,
        @size : Int32 = 0
      )
      end

      getter left : (TreeNode(T) | Empty)
      getter right : (TreeNode(T) | Empty)
      getter value, size, rev

      setter left : (TreeNode(T) | Empty)
      setter right : (TreeNode(T) | Empty)
      setter size, rev
    end

    def initialize
      @rnd = ::Random.new
    end

    @root : (TreeNode(T) | Empty) = Empty.instance

    private def propagate(t : TreeNode(T)) : TreeNode(T)
      t.size = t.left.size + t.right.size + 1

      if (t.rev == true)
        t.left, t.right = t.right, t.left

        t.left.rev ^= true
        t.right.rev ^= true
        t.rev = false
      end
      t
    end

    private def merge_rec(l : (TreeNode(T) | Empty), r : (TreeNode(T) | Empty)) : (TreeNode(T) | Empty)
      l = propagate l if !l.is_a? Empty
      r = propagate r if !r.is_a? Empty

      if (l.is_a? Empty || r.is_a? Empty)
        return !l.is_a?(Empty) ? l : r
      end

      m, n = l.size, r.size
      if (@rnd.next_int % (m + n) < m)
        l.right = merge_rec l.right, r
        propagate l
      else
        r.left = merge_rec l, r.left
        propagate r
      end
    end

    def merge(l : (TreeNode(T) | Empty), r : (TreeNode(T) | Empty)) : (TreeNode(T) | Empty)
      (@root = merge_rec(l, r))
    end

    def split(k : Int32, t : (TreeNode(T) | Empty) = @root)
      t = propagate t if !t.is_a? Empty
      return {Empty.instance, Empty.instance} if t.is_a? Empty
      if (k <= t.left.size)
        l, r = split k, t.left
        t.left = r
        {l, propagate t}
      else
        l, r = split(k - t.left.size - 1, t.right)
        t.right = l
        {propagate(t), r}
      end
    end

    private def insert(k : Int32, value : T, t : (TreeNode(T) | Empty))
      l, r = split k
      t = merge_rec(l, TreeNode.new value)
      t = merge_rec t, r
      t.is_a?(Empty) ? t : propagate(t)
    end

    private def erase(k, t)
      tmp, c = split k + 1, t
      a, b = split k, tmp
      t = merge_rec a, c
      t = propagate(t) if !t.is_a? Empty
      t
    end

    def insert(k, value)
      @root = insert(k, value, @root)
    end

    def erase(k)
      @root = erase(k, @root)
    end

    def find(k, t = @root)
      return nil if t.is_a? Empty
      propagate t

      if (k < t.left.size)
        find k, t.left
      elsif (t.left.size == k)
        t.value
      else
        find k - t.left.size - 1, t.right
      end
    end

    def reverse(left_id, right_id)
      tmp, c = split right_id
      a, b = split left_id, tmp
      b.rev ^= true
      merge_rec(merge_rec(a, b), c)
    end
  end
end
