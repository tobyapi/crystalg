module Crystalg::DataStructures
  @[Experimental]
  class LinkCutTree(T)
    INF = Int32::MAX

    def initialize(size)
      @left = Array(NodeID?).new(size, nil)
      @right = Array(NodeID?).new(size, nil)
      @parent = Array(NodeID?).new(size, nil)
      @val = Array(T).new(size, 0)
      @mini = Array(T).new(size, INF)
      @minId = Array(NodeID?).new(size, nil)
      @lazy = Array(T).new(size, 0)
      @rev = Array(Bool).new(size, false)
    end

    # :nodoc:
    def push(id : NodeID)
      l = @left[id]
      r = @right[id]

      @val[id] += @lazy[id]
      @mini[id] += @lazy[id]

      @lazy[l] += @lazy[id] if !l.nil?
      @lazy[r] += @lazy[id] if !r.nil?
      @lazy[id] = 0

      if @rev[id]
        @rev[id] = false
        @rev[l] ^= true if !l.nil?
        @rev[r] ^= true if !r.nil?
        @left[id], @right[id] = @right[id], @left[id]
      end
    end

    # :nodoc:
    def update_min(id : NodeID, ch : NodeID)
      if @mini[ch] < @mini[id]
        @mini[id] = @mini[ch]
        @minId[id] = @minId[ch]
      end
    end

    # :nodoc:
    def update(id : NodeID)
      l = @left[id]
      r = @right[id]
      @mini[id] = @val[id]
      @minId[id] = id
      push(id)

      unless l.nil?
        push(l)
        update_min(id, l)
      end

      unless r.nil?
        push(r)
        update_min(id, r)
      end
    end

    def root?(id : NodeID)
      parent_index = @parent[id]
      return true if parent_index.nil?
      is_left = (@left[parent_index] != id)
      is_right = (@right[parent_index] != id)
      is_left && is_right
    end

    # :nodoc:
    def connect(ch : NodeID?, par : NodeID, is_left : Bool)
      if is_left
        @left[par] = ch
      else
        @right[par] = ch
      end
      @parent[ch] = par if !ch.nil?
    end

    # :nodoc:
    def rotate(id : NodeID)
      par = @parent[id].as(NodeID)
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
        q = q.as(NodeID)
        connect(id, q, par == @left[q])
      else
        @parent[id] = q
      end
      update(par)
    end

    # :nodoc:
    def splay(id : NodeID)
      until root?(id)
        par = @parent[id].as(NodeID)
        unless root?(par)
          is_left = (id == @left[par])
          parent_is_left = (par == @left[@parent[par].as(NodeID)])
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

    # :nodoc:
    def expose(id : NodeID) : NodeID?
      last = nil
      y = id
      until y.nil?
        splay(y)
        @right[y] = last
        last = y
        y = @parent[y]
      end
      splay(id)
      last
    end

    def find_root(id : NodeID) : NodeID
      expose(id)
      until @right[id].nil?
        id = @right[id]
      end
      id
    end

    def connected?(x : NodeID, y : NodeID)
      expose(x)
      expose(y)
      !@parent[x].nil?
    end

    def evert(par : NodeID) : Nil
      expose(par)
      @rev[par] ^= true
    end

    def link(ch : NodeID, par : NodeID) : Nil
      evert(ch)
      @parent[ch] = par
    end

    def cut(id : NodeID) : Nil
      expose(id)
      @parent[@right[id].as(Int32)] = nil
      @right[id] = nil
    end

    def lca(ch : NodeID, par : NodeID) : NodeID?
      expose(ch)
      expose(par)
    end

    def min_id(id : NodeID) : Int32
      expose(id)
      @minId[id]
    end

    def min(from : NodeID, to : NodeID) : Int32
      evert(from)
      expose(to)
      @mini[to]
    end

    def add(id : NodeID, val : Int32)
      expose(id)
      @lazy[id] = val
    end

    def add(from : NodeID, to : NodeID, v : Int32)
      evert(from)
      expose(to)
      @lazy[to] += v
    end
  end
end
