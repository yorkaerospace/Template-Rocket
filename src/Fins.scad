module fin(root_chord, tip_chord, height, sweep, thickness)
{
    translate([0, 0, root_chord])
    rotate([-90, 0, 0])
    rotate([0, -90, 0])
    linear_extrude(thickness)
    polygon([[0, 0], [0, root_chord], [height, tip_chord+sweep], [height, sweep]]);
}

color("green")
fin(15, 12, 11, 9.5, 0.3);


translate([10, 0, 0])
fin(20, 10, 30, 11.5, 3);
