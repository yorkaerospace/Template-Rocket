module centreRing(out_dia, in_dia, thickness)
{
    linear_extrude(thickness)
    difference()
    {
        circle(out_dia/2);
        circle(in_dia/2);
    }
}

module tube(length, out_dia, in_dia, out_col="red", in_col="yellow")
{
    difference() {
    color(out_col)
    cylinder(length, r=out_dia/2);
    translate([0, 0, -1])
        color(in_col)
        cylinder(length+2, r=in_dia/2);
    }
}

tube(100, 50, 45);

translate([70, 0, 0])
centreRing(13.4, 11, 0.2);