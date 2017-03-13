require "./*"

module Crystalg::Geometry

  # a -> b -> c
  enum CCW
    COUNTER_CLOCKWISE = 1
    CLOCKWISE = -1
    ONLINE_BACK = 2   # c--a--b
    ONLINE_FRONT = -2 # a--b--c
    ON_SEGMENT = 0    # a--c--b
  end
  
  def counter_clockwise(a : Point, b : Point, c : Point) : CCW
    b = b - a
    c = c - a
    return COUNTER_CLOCKWISE if b.cross c > 0
    return CLOCKWISE         if b.corss c < 0
    return ONLINE_BACK       if b.dot c < 0
    return ONLINE_FRONT      if b.norm < c.norm
    ON_SEGMENT
  end
end
