use <BodyTubes.scad>

// units: mm

$fn = 360;

module parabola(con_l, K =1, con_d1, con_d2, shol_l=0, shol_d1=0, shol_d2=0, out_col="orange", in_col="red")
{
    R1 = con_d1/2;
    R2 = con_d2/2;
    
    para1 = [for (x =[0:con_l-1]) [x, R1*((2*(x/con_l)-K*pow((x/con_l),2))/(2-K))]];
    para2 = [for (x =[0:con_l-1]) [x, R2*((2*(x/con_l)-K*pow((x/con_l),2))/(2-K))]];
    
    tmp1 = [[con_l, R1], [con_l, 0]];
    tmp2 = [[con_l, R2], [con_l, 0]];
    
    outer = concat(para1, tmp1);
    inner = concat(para2, tmp2);
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

module elliptical(con_l, con_d1, con_d2, shol_l=0, shol_d1=0, shol_d2=0, out_col="orange", in_col="red")
{
    R1 = con_d1/2;
    R2 = con_d2/2;
    
    ellip1 = [for (x=[0:con_l-1]) [x, R1*pow(1-(pow(x, 2)/pow(con_l, 2)), 0.5)]];
    ellip2 = [for (x=[0:con_l-1]) [x, R2*pow(1-(pow(x, 2)/pow(con_l, 2)), 0.5)]];
    
    tmp = [[con_l, 0], [0, 0]];
    outer = concat(ellip1, tmp);
    inner = concat(ellip2, tmp);
    
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


translate([20, 0, 0])
difference() {   
    parabola(con_l=30, K=1, con_d1=14, con_d2=13, shol_l=10, shol_d1=13, shol_d2=11, out_col="red", in_col="green");
    
    translate([0, 0, -30])
    cube(100);
}

difference() {   
    elliptical(con_l=30, con_d1=14, con_d2=13, shol_l=10, shol_d1=13, shol_d2=11);    
    translate([0, 0, -30])
    cube(100);
}