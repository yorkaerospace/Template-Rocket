use <src/BodyTubes.scad>
use <src/NoseCones.scad>
use <src/Fins.scad>
use <src/CentreRings.scad>

//  units = mm
$fn = 360;

out_dia = 40;
in_dia = 37;
thick = (out_dia-in_dia)/2;
explosion = 15;
mot_dia = 29;

//bottom tube
tube(231, out_dia, in_dia, "yellow", "aqua");

//inner tube
translate([out_dia + explosion, 0, 0])
tube(70, mot_dia, 28, "gray", "red");

//1st centre ring
color("orange")
translate([out_dia + explosion, out_dia + explosion, 20])
centreRing(in_dia, mot_dia, 2);

//2nd centre ring
color("orange")
translate([out_dia + explosion, out_dia + explosion, 43])
centreRing(in_dia, mot_dia, 2);

//engine block
color("red")
translate([out_dia + explosion,, 0, 70+explosion])
linear_extrude(2)
circle(in_dia/2);


//nose cone
translate([-(out_dia+explosion), 0, 0])
elliptical(con_l=80, con_d1=out_dia, con_d2=in_dia, shol_l=30, shol_d1=in_dia, shol_d2=in_dia-(2*thick), out_col="orange", in_col="dodgerblue");


//fins
translate([-(2*out_dia+explosion), 0, 0])
color("green")
fin(20, 10, 30, 11.5, 3);

translate([-(2*out_dia+explosion), 0, 20 + explosion/2])
color("green")
fin(20, 10, 30, 11.5, 3);

translate([-(2*out_dia+explosion), 0, 2*(20 + explosion/2)])
rotate([0, 0, 0])
color("green")
fin(20, 10, 30, 11.5, 3);