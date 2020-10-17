$fn = 100;

shell = 1;
innerRadius = 13;
outerRadius = innerRadius + shell;
height = 5;
numSides=6;

difference() {
    cylinder(height, r=outerRadius);
    translate([0,0,shell])
    cylinder(height , r=innerRadius);
    
    // cut outs for brim
    for (i=[1:numSides])  {
        translate([0,0,height])
        translate([outerRadius*cos(i*(360/numSides)),outerRadius*sin(i*(360/numSides)),0])
            rotate([0,0,360/numSides * i])
            cube([3,3,2],true);
    }
}

// base decorative ring
 rotate_extrude(convexity = 10)
 translate([outerRadius - 4, 0, 0])
polygon([[0,0], [0,-1], [1,-2], [2,-2],[3,-1],[3,0]]);

// inner ring
translate([0, 0, 1])
 rotate_extrude(convexity = 10)
translate([3, 0, 0])
polygon([[0,0], [0,-1], [3,-2], [4,-2], [5,-1] ,[5,0]]);

