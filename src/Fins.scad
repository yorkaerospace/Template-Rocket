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
surface_trap(root_chord=15, tip_chord=12, height=11, sweep=9.5, thickness=0.3);



surface_trap(root_chord=20, tip_chord=10, height=30, sweep=11.5, thickness=3);

color("orange")
translate([-10, 0, 0])
deep_trap(root_chord=20, tip_chord=20, height=30, sweep=15, depth=10, thickness=3);
