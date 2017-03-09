module Crystalg::Trees

  abstract class BynarySearchTree(T)
    class Node
      def initialize(
        @value : T,
        @left : Node = @@none,
        @right : Node = @@none,
        @size : Int32 = 1,
        @rev : Bool = false)
      end
    end
    
    class None < Node
    end
    
    @root = @@none = None

    abstract def merge(l : Node, r : Node);
    abstract def split(k : Int32, t : Node = root);
    abstract def insert(k : Int32, value : Int32, t : Node = root);
    abstract def erase(k : Int32, t : Node = root);

    def find(k : Int32, t : Node = root)
      if(k < @left.@size)
        find @left, k
      elsif (@left.@size == k)
        self
      else
        find @right, k - @left.@size - 1
      end
    end

    def three_way_split(left_id : Int32, right_id : Int32)
      s2 = split root, right_id
      s1 = split s2[0], left_id
      { s1[0], s1[1], s2[1] }
    end

    def split(*ids : Int32)
      result = [] of Node
      prev = root
      ids.reverse!.each { |e|
        prev = split prev, e
        result << prev[1]
      }
      result << prev[0]
      result.reverse!
    end

    def update(id : Int32, value : T)
      erase id
      insert id, value
    end

    def reverse(left_id : Int32, right_id : Int32)
      s2 = split root, right_id
      s1 = split s2[0], left_id
      a, b, c = s1[0], s1[1], s2[1]
      b.rev ^= true
      root = merge merge a, b, c
    end

    def revolve_right(left_id : Int32, right_id : Int32, t : Int32)
      c = split root, right_id
      b = split c[0], right_id - (t % (right_id - left_id))
      a = split b[0], left_id
      root = merge a[0], b[1]
      root = merge root, a[1]
      root = merge root, c[1]
    end

    abstract def revolve_left(left_id : Int32, right_id : Int32, t : Int32);

  end

  abstract class Seq(T) < BynarySearchTree(T)

    def add(id : Int32, value : T)
      tmp = find id
      erase id
      insert id, tmp + value
    end

    def add(left_id : Int32, right_id : Int32, value : T)
      a, b, c = three_way_split left_id, right_id
      b.lazy += value
      root = merge merge a, b, c
    end

    def min(left_id : Int32, right_id : Int32)
      a, b, c = three_way_split left_id, right_id
      result = b.minimum
      root = merge merge a, b, c
      result
    end

    def sum(left_id : Int32, right_id : Int32)
      a, b, c = three_way_split left_id, right_id
      result = b.sum
      root = merge merge a, b, c
      result 
    end
  end

end