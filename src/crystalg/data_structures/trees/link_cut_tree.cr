
module Crystalg::Trees
  class LinkCutTree(T)
    INF = Int32::MAX

    def initialize(size)
      @left   = Array(T).new(size, -1)
      @right  = Array(T).new(size, -1)
      @parent = Array(T).new(size, -1)
      @val    = Array(T).new(size, 0)
      @mini   = Array(T).new(size, INF)
      @minId  = Array(T).new(size, -1)
      @lazy   = Array(T).new(size, 0)
      @rev    = Array(Bool).new(size, false)
    end

    def push(id : Int32)
      l = @left[id]
      r = @right[id]

      @val[id] += @lazy[id]
      @mini[id] += @lazy[id]

      @lazy[l] += @lazy[id] if 0 <= l
      @lazy[r] += @lazy[id] if 0 <= r
      @lazy[id] = 0

      if @rev[id]
        @rev[id] = false
        @rev[l] ^= true if 0 <= l
        @rev[r] ^= true if 0 <= r
        @left[id], @right[id] = @right[id], @left[id]
      end
    end

    def update_min(id : Int32, ch : Int32)
      if @mini[ch] < @mini[id]
        @mini[id] = @mini[ch]
        @minId[id] = @minId[ch]
      end
    end

    def update(id : Int32)
      l = @left[id]
      r = @right[id]
      @mini[id] = @val[id]
      @minId[id] = id
      push(id)

      if 0 <= l
        push(l)
        update_min(id,l)
      end

      if 0 <= r
        push(r)
        update_min(id, r)
      end
    end

    def root?(id : Int32)
      l_is_not_parent = (@left[@parent[id]] != id)
      r_is_not_parent = (@right[@parent[id]] != id)
      @parent[id] < 0 || (l_is_not_parent && r_is_not_parent)
    end

    def connect(ch : Int32, par : Int32, is_left : Bool)
      if is_left
        @left[par] = ch
      else
        @right[par] = ch
      end
      @parent[ch] = par if 0 <= ch
    end

    def rotate(id : Int32)
      par = @parent[id]
      q = @parent[par]
      push(par)
      push(id)
      is_left = (id == @left[par])
      is_root = root?(par)
      if is_left
        connect(@right[id], par, is_left)
      else
        connect(@left[id], par, is_left)
      end
      connect(par, id, !is_left)
      if !is_root
        connect(id,q, par == @left[q])
      else
        @parent[id] = q
      end
      update(par)
    end

    def splay(id : Int32)
      until root?(id)
        par = @parent[id]
        unless root?(par)
          is_left = (id == @left[par])
          parent_is_left = (par == @left[@parent[par]])
          if is_left ^ parent_is_left
            rotate(par)
          else
            rotate(id)
          end
        end
        rotate(id)
      end
      update(id)
    end

    def expose(id : Int32): Int32
      last = -1
      y = id
      while 0 <= y
        splay(y)
        @right[y] = last
        last = y
        y = @parent[y]
      end
      splay(id)
      last
    end

    def find_root(id : Int32): Int32
      expose(id)
      while @right[id] != -1
        id = @right[id]
      end
      id
    end

    def connected?(x : Int32, y : Int32)
      expose(x)
      expose(y)
      @parent[x] != -1
    end

    def evert(par : Int32): Nil
      expose(par)
      @rev[par] ^= true
    end

    def link(ch : Int32, par : Int32): Nil
      evert(ch)
      @parent[ch] = par
    end

    def cut(id : Int32): Nil
      expose(id)
      @parent[@right[id]] = -1
      @right[id] = -1
    end

    def lca(ch : Int32, par : Int32): Int32
      expose(ch)
      expose(par)
    end

    def min_id(id : Int32): Int32
      expose(id)
      @minId[id]
    end
    def min(from : Int32, to : Int32): Int32
      evert(from)
      expose(to)
      @mini[to]
    end

    def add(id : Int32, val : Int32)
      expose(id)
      @lazy[id] = val
    end

    def add(from : Int32, to : Int32, v : Int32)
      evert(from)
      expose(to)
      @lazy[to] += v
    end
  end
end
