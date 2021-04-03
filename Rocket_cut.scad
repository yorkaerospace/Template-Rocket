use <src/BodyTubes.scad>
use <src/NoseCones.scad>
use <src/Fins.scad>
use <src/CentreRings.scad>

//  units = mm
$fn = 360;

tube_l=400;
con_l = 80;
height = tube_l + con_l;

difference()
{
    union()
    {
        out_dia = 40;
        in_dia = 37;
        thick = (out_dia - in_dia)/2;
        
        // tube
        tube(tube_l, out_dia, in_dia, "yellow", "aqua");
        
        
        //motor tube
        mot_h = 70;
        mot_out = 29;
        mot_inn = 28;
        tube(mot_h, mot_out, mot_inn, "gray", "red");
        
        //1st centre ring
        color("orange")
        translate([0, 0, 20])
        centreRing(in_dia, mot_out, thick);
        
        //2nd centre ring
        color("orange")
        translate([0, 0, 43])
        centreRing(in_dia, mot_out, thick);
        
        //engine block
        block_thick = 2;
        color("red")
        translate([0, 0, 70])
        linear_extrude(block_thick)
        circle(in_dia/2);
        
        
        //nose cone
        shol_l = 30;
        translate([0, 0, 400-shol_l])
        elliptical(con_l=con_l, con_d1=out_dia, con_d2=in_dia, shol_l=shol_l, shol_d1=in_dia, shol_d2=in_dia-(2*thick), out_col="orange", in_col="dodgerblue");
        
        
        //fins
        f_root_chord=20;
        f_tip_chord=10;
        f_height=30;
        f_sweep=11.5;
        f_thick=3;
        offer=(out_dia/2);
        
        color("green")
        translate([-offer*sin(120), offer*cos(120), 0])
        rotate([0, 0, 120])
        fin(f_root_chord, f_tip_chord, f_height, f_sweep, f_thick);
        
        color("green")
        translate([-offer*sin(240), offer*cos(240), 0])
        rotate([0, 0, -120])
        fin(f_root_chord, f_tip_chord, f_height, f_sweep, f_thick);
        
        translate([(f_thick/2), out_dia/2, 0])
        rotate([0, 0, 0])
        color("green")
        fin(f_root_chord, f_tip_chord, f_height, f_sweep, f_thick);
    }
    translate([0, 0, -5])
    cube(height+10);
}