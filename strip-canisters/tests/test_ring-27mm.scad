$fn = 50;

shell = 2;
innerRadius = 27/2;
outerRadius = innerRadius + shell;
height = 7;

difference() {
    cylinder(height, r=outerRadius);
    cylinder(height + 2, r=innerRadius);
}
