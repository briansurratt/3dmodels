plexiThickness = 2.5;
shellThickness = 1.5;
length = 10;

linear_extrude(shellThickness)
polygon(
[
[0,0],
[0, 10],
[length,10],
[length,0]
]
);


translate([0,0,plexiThickness + shellThickness])
linear_extrude(shellThickness)
polygon(
[
[0,0],
[0, 10],
[length,10],
[length,0]
]
);


#linear_extrude(shellThickness * 2+ plexiThickness)
polygon (
[
[0,0],
[0, shellThickness],
[length,shellThickness],
[length,0]
]
);

translate([shellThickness, 0,0])
rotate([0,0,90])
#linear_extrude(shellThickness * 2+ plexiThickness)
polygon (
[
[0,0],
[0, shellThickness],
[length,shellThickness],
[length,0]
]
);