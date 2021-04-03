use <src/BodyTubes.scad>
use <src/NoseCones.scad>
use <src/Fins.scad>
use <src/CentreRings.scad>

//  units = mm
$fn = 360;

out_dia = 40;
in_dia = 37;
thick = (out_dia - in_dia)/2;
explosion = 15;

// tube
tube_l=400;
tube(tube_l, out_dia, in_dia, "yellow", "aqua");


//motor tube
mot_h = 70;
mot_out = 29;
mot_inn = 28;
translate([0, 0, -59.7- explosion])
tube(mot_h, mot_out, mot_inn, "gray", "red");

//1st centre ring
color("orange")
translate([0, 0, -13-explosion])
centreRing(in_dia, mot_dia, thick);

//2nd centre ring
color("orange")
translate([0, 0, -43-explosion])
centreRing(in_dia, mot_dia, thick);

//engine block
block_thick = 2;
color("red")
translate([0, 0, -explosion/4])
linear_extrude(block_thick)
circle(in_dia/2);


//nose cone
con_l = 80;
shol_l = 30;
translate([0, 0, 400 + explosion])
elliptical(con_l=con_l, con_d1=out_dia, con_d2=in_dia, shol_l=shol_l, shol_d1=in_dia, shol_d2=in_dia-(2*thick), out_col="orange", in_col="dodgerblue");


//fins
f_root_chord=20;
f_tip_chord=10;
f_height=30;
f_sweep=11.5;
f_thick=3;
offer=(out_dia/2);

color("green")
translate([-offer*sin(120) - explosion/3, (offer*cos(120) - explosion/3), 0])
rotate([0, 0, 120])
fin(f_root_chord, f_tip_chord, f_height, f_sweep, f_thick);

color("green")
translate([-offer*sin(240) + explosion/3, (offer*cos(240) - explosion/3), 0])
rotate([0, 0, -120])
fin(f_root_chord, f_tip_chord, f_height, f_sweep, f_thick);

translate([(f_thick/2), out_dia/2  + explosion/3, 0])
rotate([0, 0, 0])
color("green")
fin(f_root_chord, f_tip_chord, f_height, f_sweep, f_thick);