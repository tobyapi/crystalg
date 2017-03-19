require "./spec_helper"

include Crystalg::Geometry

describe Crystalg do
  it "area" do
    pol = Polygon.new(
      Point.new(0.0, 0.0), 
      Point.new(2.0, 2.0), 
      Point.new(-1.0, 1.0)
    )
    true.should eq(pol.area === 2.0)
    
    pol = Polygon.new(
      Point.new(0.0, 0.0),
      Point.new(1.0, 1.0),
      Point.new(1.0, 2.0),
      Point.new(0.0, 2.0)
    )
    true.should eq(pol.area === 1.5)
  end
  
  it "is_convex?" do
    pol = Polygon.new(
      Point.new(0.0, 0.0),
      Point.new(3.0, 1.0),
      Point.new(2.0, 3.0),
      Point.new(0.0, 3.0)
    )
    true.should eq(pol.is_convex?)
    
    pol = Polygon.new(
      Point.new(0.0, 0.0),
      Point.new(2.0, 0.0),
      Point.new(1.0, 1.0),
      Point.new(2.0, 2.0),
      Point.new(0.0, 2.0)
    )
    false.should eq(pol.is_convex?)
  end
  
  it "polygon-point containment" do
    pol = Polygon.new(
      Point.new(0.0, 0.0),
      Point.new(3.0, 1.0),
      Point.new(2.0, 3.0),
      Point.new(0.0, 3.0)
    )
    
    true.should eq(pol.contain(Point.new(2.0, 1.0)) === Polygon::Containment::IN)
    true.should eq(pol.contain(Point.new(0.0, 2.0)) === Polygon::Containment::ON)
    true.should eq(pol.contain(Point.new(3.0, 2.0)) === Polygon::Containment::OUT)
  end
  
  it "convex hull" do
    pol = Polygon.new(
      Point.new(2.0, 1.0),
      Point.new(0.0, 0.0),
      Point.new(1.0, 2.0),
      Point.new(2.0, 2.0),
      Point.new(4.0, 2.0),
      Point.new(1.0, 3.0),
      Point.new(3.0, 3.0)
    )
    
    ans = Polygon.new(
      Point.new(0.0, 0.0),
      Point.new(2.0, 1.0),
      Point.new(4.0, 2.0),
      Point.new(3.0, 3.0),
      Point.new(1.0, 3.0)
    )
    
    true.should eq(pol.convex_hull === ans)
  end
  
  it "convex cut" do
    pol = Polygon.new(
      Point.new(1.0, 1.0),
      Point.new(4.0, 1.0),
      Point.new(4.0, 3.0),
      Point.new(1.0, 3.0)
    )
    
    res = pol.convex_cut(Line.new(Point.new(2.0, 0.0), Point.new(2.0, 4.0)))
    true.should eq(res.area === 2.0)
    
    res = pol.convex_cut(Line.new(Point.new(2.0, 4.0), Point.new(2.0, 0.0)))
    true.should eq(res.area === 4.0)
  end
end