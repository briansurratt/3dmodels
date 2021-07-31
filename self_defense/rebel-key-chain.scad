// import("StarWarsRebel.stl", convexity=10);

resize([60, 60.62, 5])
difference() {
    translate([-60,0, 0]) import("StarWarsRebel.stl", convexity=10);
    translate([0,25,-5]) cylinder(20, d=11, true);
}
