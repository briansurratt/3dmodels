$fn = 50;

shell = 2;
innerRadius = 25/2;
outerRadius = innerRadius + shell;
height = 5;

difference() {
    cylinder(height, r=outerRadius);
    cylinder(height + 2, r=innerRadius);
}
