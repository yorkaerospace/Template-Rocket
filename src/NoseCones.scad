use <BodyTubes.scad>

// units: mm

$fn = 50;

module conical(con_l, con_d1, con_d2, shol_l=0, shol_d1=0, shol_d2=0, out_col="orage", in_col="red")
{
    // a conical nose cone, no speciallity
    translate([0, 0, shol_l])
    union()
    {
        difference()
        {
            color(out_col)
            cylinder(con_l, d1=con_d1, d2=0);

            translate([0, 0, (con_d2-con_d1)/2])
            color(in_col)
            cylinder(con_l, d1=con_d2, d2=0);
        }
       translate([0, 0, -shol_l])
       tube(shol_l+(shol_d1-shol_d2), shol_d1, shol_d2, out_col, in_col);
    }
}
//
//
module elliptical(con_l, con_d1, con_d2, shol_l=0, shol_d1=0, shol_d2=0, out_col="orange", in_col="red", step=0.1)
{
    // elliptical nose cone, advantageous at subsonic speeds
    R1 = con_d1/2;
    R2 = con_d2/2;

    ellip1 = [for (x=[0:step:con_l]) [x, R1*pow(1-(pow(x, 2)/pow(con_l, 2)), 0.5)]];
    ellip2 = [for (x=[0:step:con_l]) [x, R2*pow(1-(pow(x, 2)/pow(con_l, 2)), 0.5)]];

    outer = concat(ellip1, [[0, 0]]);
    inner = concat(ellip2, [[0, 0]]);

    translate([0, 0, shol_l])
    union()
    {
        difference() {
            color(out_col)
            rotate_extrude()
            rotate([0, 0, 90])
            polygon(outer);

            color(in_col)
            translate([0, 0, R2-R1])
            rotate_extrude()
            rotate([0, 0, 90])
            polygon(inner);
        }

        translate([0, 0, -shol_l])
        tube(shol_l+(shol_d1 - shol_d2), shol_d1, shol_d2, out_col, in_col);
    }
}
//
//
module tangental(con_l, con_d1, con_d2, shol_l=0, shol_d1=0, shol_d2=0, out_col="orange", in_col="red", step=0.1)
{
    // tanget nose cones, defined by a segment of a cirlce where the cirlce radius is related to the length and diameter of the nose cone

    rho1 = (pow(con_d1/2, 2) + pow(con_l, 2)) / con_d1;
    rho2 = (pow(con_d2/2, 2) + pow(con_l, 2)) / con_d2;

    tang1 = [for (x =[0:step:con_l]) [x, (pow(pow(rho1, 2) - pow((x- con_l), 2), 0.5)) + con_d1/2 - rho1]];
    tang2 = [for (x =[0:step:con_l]) [x, (pow(pow(rho2, 2) - pow((x- con_l), 2), 0.5)) + con_d2/2 - rho2]];

    outer = concat(tang1, [[con_l, 0]]);
    inner = concat(tang2, [[con_l, 0]]);

    translate([0, 0, shol_l])
    union()
    {
        translate([0, 0, con_l])
        difference()
        {
            color(out_col)
            rotate_extrude()
            rotate([0, 0, -90])
            polygon(outer);

            translate([0, 0, (con_d2-con_d1)/2])
            color(in_col)
            rotate_extrude()
            rotate([0, 0, -90])
            polygon(inner);
        }
        translate([0, 0, -shol_l])
        tube(shol_l+(shol_d1-shol_d2), shol_d1, shol_d2, out_col, in_col);
    }
}
//
//
module parabolic(con_l, con_d1, con_d2, k=1, shol_l=0, shol_d1=0, shol_d2=0, out_col="orange", in_col="red", step=0.1)
{
    // parabolic nose cone, can either be a cone at k=0 or full parabola at k=1
    R1 = con_d1/2;
    R2 = con_d2/2;

    para1 = [for (x =[0:step:con_l]) [x, R1*((2*(x/con_l)-k*pow((x/con_l),2))/(2-k))]];
    para2 = [for (x =[0:step:con_l]) [x, R2*((2*(x/con_l)-k*pow((x/con_l),2))/(2-k))]];

    outer = concat(para1, [[con_l, 0]]);
    inner = concat(para2, [[con_l, 0]]);
    translate([0, 0, shol_l])
    union()
    {
        translate([0, 0, con_l])
        difference()
        {
            color(out_col)
            rotate_extrude()
            rotate([0, 0, -90])
            polygon(outer);

            color(in_col)
            translate([0, 0, R2-R1])
            rotate_extrude()
            rotate([0, 0, -90])
            polygon(inner);
        }

        translate([0, 0, -shol_l])
        tube(shol_l+(shol_d1-shol_d2), shol_d1, shol_d2, out_col, in_col);

    }

}
//
//
module power(con_l, con_d1, con_d2, k=1, shol_l=0, shol_d1=0, shol_d2=0, out_col="orange", in_col="red", step=0.1)
{
    // power series nose cone, k=0.5 good for transonic, k=0.75 good for supersonic, k=0.6 good for hypersonic
    pow1 = [for (x =[0:step:con_l]) [x, (con_d1/2)*pow((x/con_l), k)]];
    pow2 = [for (x =[0:step:con_l]) [x, (con_d2/2)*pow((x/con_l), k)]];
    outer = concat(pow1, [[con_l, 0]]);
    inner = concat(pow2, [[con_l, 0]]);

    translate([0, 0, shol_l])
    union()
    {
        translate([0, 0, con_l])
        difference()
        {
            color(out_col)
            rotate_extrude()
            rotate([0, 0, -90])
            polygon(outer);

            translate([0, 0, (con_d2-con_d1)/2])
            color(in_col)
            rotate_extrude()
            rotate([0, 0, -90])
            polygon(inner);
        }
        translate([0, 0, -shol_l])
        color("green")
        tube(shol_l+(shol_d1-shol_d2), shol_d1, shol_d2, out_col, in_col);
    }
}
//
//
module haack(con_l, con_d1, con_d2, k=0.333333, shol_l=0, shol_d1=0, shol_d2=0, out_col="orange", in_col="red", step=0.2)
{
    // sears-haack nose cone, good for transonic (von Karman)
    const1 = (con_d1/2)/ sqrt(PI);
    const2 = (con_d2/2)/ sqrt(PI);

    seri1 = [for (x=[0:step:con_l]) [x,
        const1 * sqrt( acos(1 - (2*x)/con_l)*(PI/180)
        - sin(2 * acos(1 - (2*x)/con_l)) / 2
        + k * pow( sin(acos(1 - (2*x)/con_l)), 3))]];
    seri2 = [for (x=[0:step:con_l]) [x,
        const2 * sqrt( acos(1 - (2*x)/con_l)*(PI/180)
        - sin(2 * acos(1 - (2*x)/con_l)) / 2
        + k * pow( sin(acos(1 - (2*x)/con_l)), 3))]];
    outer = concat(seri1, [[con_l, 0]]);
    inner = concat(seri2, [[con_l, 0]]);

    translate([0, 0, shol_l])
    union()
    {
        translate([0, 0, con_l])
        difference()
        {
            color(out_col)
            rotate_extrude()
            rotate([0, 0, -90])
            polygon(outer);

            translate([0, 0, (con_d2-con_d1)/2])
            color(in_col)
            rotate_extrude()
            rotate([0, 0, -90])
            polygon(inner);
        }
        translate([0, 0, -shol_l])
        tube(shol_l+(shol_d1-shol_d2), shol_d1, shol_d2, out_col, in_col);
    }
}
//

// sears-haack series
translate([60, 0, 0])
difference()
{
    haack(con_l=30, con_d1=14, con_d2=13, k=0.3, shol_l=10, shol_d1=13, shol_d2=11, out_col="green", in_col="lime", step=1);

    translate([0, 0, -30])
    cube(100);
}

// power series
translate([40, 0, 0])
difference()
{
    power(con_l=30, con_d1=14, con_d2=13, k=0.6, shol_l=10, shol_d1=13, shol_d2=11, out_col="blue", in_col="green", step=1);

    translate([0, 0, -30])
    cube(100);
}

// tangental
translate([-40, 0, 0])
difference()
{
    tangental(con_l=30, con_d1=14, con_d2=13, shol_l=10, shol_d1=13, shol_d2=11, out_col="blue", in_col="green");

    translate([0, 0, -30])
    cube(100);
}

// conical
translate([-20, 0, 0])
difference()
{
    conical(con_l=30, con_d1=14, con_d2=13, shol_l=10, shol_d1=13, shol_d2=11, out_col="blue", in_col="yellow");

    translate([0, 0, -30])
    cube(100);
}

// parabola
translate([20, 0, 0])
difference()
{
    parabolic(con_l=30, k=1, con_d1=14, con_d2=13, shol_l=10, shol_d1=13, shol_d2=11, out_col="red", in_col="green");

    translate([0, 0, -30])
    cube(100);
}

// elliptical
difference()
{
    elliptical(con_l=30, con_d1=14, con_d2=13, shol_l=10, shol_d1=13, shol_d2=11, step=1);
    translate([0, 0, -30])
    cube(100);
}
