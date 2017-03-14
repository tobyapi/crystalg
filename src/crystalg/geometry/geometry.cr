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
    return CCW::COUNTER_CLOCKWISE if b.cross(c) > 0
    return CCW::CLOCKWISE         if b.cross(c) < 0
    return CCW::ONLINE_BACK       if b.dot(c) < 0
    return CCW::ONLINE_FRONT      if b.norm < c.norm
    CCW::ON_SEGMENT
  end
end
