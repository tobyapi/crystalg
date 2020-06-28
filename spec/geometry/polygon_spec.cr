require "../spec_helper"

include Crystalg::Geometry

describe Crystalg do
  it "area" do
    pol = Polygon(Float32).new(
      Point(Float32).new(0_f32, 0_f32),
      Point(Float32).new(2_f32, 2_f32),
      Point(Float32).new(-1_f32, 1_f32)
    )
    true.should eq(pol.area === 2_f32)

    pol = Polygon(Float32).new(
      Point(Float32).new(0_f32, 0_f32),
      Point(Float32).new(1_f32, 1_f32),
      Point(Float32).new(1_f32, 2_f32),
      Point(Float32).new(0_f32, 2_f32)
    )
    true.should eq(pol.area === 1.5_f32)
  end

  it "is_convex?" do
    pol = Polygon(Float32).new(
      Point(Float32).new(0_f32, 0_f32),
      Point(Float32).new(3_f32, 1_f32),
      Point(Float32).new(2_f32, 3_f32),
      Point(Float32).new(0_f32, 3_f32)
    )
    true.should eq(pol.is_convex?)

    pol = Polygon(Float32).new(
      Point(Float32).new(0_f32, 0_f32),
      Point(Float32).new(2_f32, 0_f32),
      Point(Float32).new(1_f32, 1_f32),
      Point(Float32).new(2_f32, 2_f32),
      Point(Float32).new(0_f32, 2_f32)
    )
    false.should eq(pol.is_convex?)
  end

  it "polygon-point containment" do
    pol = Polygon(Float32).new(
      Point(Float32).new(0_f32, 0_f32),
      Point(Float32).new(3_f32, 1_f32),
      Point(Float32).new(2_f32, 3_f32),
      Point(Float32).new(0_f32, 3_f32)
    )

    true.should eq(pol.contain(Point(Float32).new(2_f32, 1_f32)) === Polygon::Containment::IN)
    true.should eq(pol.contain(Point(Float32).new(0_f32, 2_f32)) === Polygon::Containment::ON)
    true.should eq(pol.contain(Point(Float32).new(3_f32, 2_f32)) === Polygon::Containment::OUT)
  end

  it "convex hull" do
    pol = Polygon(Float32).new(
      Point(Float32).new(2_f32, 1_f32),
      Point(Float32).new(0_f32, 0_f32),
      Point(Float32).new(1_f32, 2_f32),
      Point(Float32).new(2_f32, 2_f32),
      Point(Float32).new(4_f32, 2_f32),
      Point(Float32).new(1_f32, 3_f32),
      Point(Float32).new(3_f32, 3_f32)
    )

    ans = Polygon(Float32).new(
      Point(Float32).new(0_f32, 0_f32),
      Point(Float32).new(2_f32, 1_f32),
      Point(Float32).new(4_f32, 2_f32),
      Point(Float32).new(3_f32, 3_f32),
      Point(Float32).new(1_f32, 3_f32)
    )

    true.should eq(pol.convex_hull === ans)
  end

  it "convex cut" do
    pol = Polygon(Float32).new(
      Point(Float32).new(1_f32, 1_f32),
      Point(Float32).new(4_f32, 1_f32),
      Point(Float32).new(4_f32, 3_f32),
      Point(Float32).new(1_f32, 3_f32)
    )

    res = pol.convex_cut(
      Line(Float32).new(
        Point(Float32).new(2_f32, 0_f32),
        Point(Float32).new(2_f32, 4_f32)
      )
    )
    true.should eq(res.area === 2_f32)

    res = pol.convex_cut(
      Line(Float32).new(
        Point(Float32).new(2_f32, 4_f32),
        Point(Float32).new(2_f32, 0_f32)
      )
    )
    true.should eq(res.area === 4_f32)
  end

  it "convex diameter 1" do
    pol = Polygon(Float32).new(
      Point(Float32).new(0_f32, 0_f32),
      Point(Float32).new(4_f32, 0_f32),
      Point(Float32).new(2_f32, 2_f32)
    )

    true.should eq(pol.diameter === 4_f32)
  end

  it "convex diameter 2" do
    pol = Polygon(Float32).new(
      Point(Float32).new(0_f32, 0_f32),
      Point(Float32).new(1_f32, 0_f32),
      Point(Float32).new(1_f32, 1_f32),
      Point(Float32).new(0_f32, 1_f32)
    )

    true.should eq(pol.diameter === 1.414213562373_f32)
  end
end
