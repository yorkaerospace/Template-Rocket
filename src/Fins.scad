module surface_trap(root_chord, tip_chord, height, sweep, thickness)
{
    translate([0, 0, root_chord])
    rotate([-90, 0, 0])
    rotate([0, -90, 0])
    linear_extrude(thickness)
    polygon([[0, 0], [0, root_chord], [height, tip_chord+sweep], [height, sweep]]);
}

module deep_trap(root_chord, tip_chord, height, sweep, depth, thickness)
{
    translate([0, 0, root_chord])
    rotate([-90, 0, 0])
    rotate([0, -90, 0])
    linear_extrude(thickness)
    polygon([[0, 0], [-depth, 0], [-depth, root_chord],  [0, root_chord], [height, tip_chord+sweep], [height, sweep]]);
}

color("green")
translate([10, 0, 0])
surface_trap(15, 12, 11, 9.5, 0.3);



surface_trap(20, 10, 30, 11.5, 3);

color("orange")
translate([-10, 0, 0])
deep_trap(20, 20, 30, 15, 10, 3);
