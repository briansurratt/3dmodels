$fn = 50;

shell = 2;
innerRadius = 13;
outerRadius = innerRadius + shell;
height = 6;

difference() {
    cylinder(height, r=outerRadius);
    cylinder(height + 2, r=innerRadius);
}
