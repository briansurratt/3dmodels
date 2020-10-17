$fn = 100;

shell = 1;
topInnerRadius = 13;
topOuterRadius = topInnerRadius + shell;
topHeight = 4;

numSides=6;

baseHeight = 9;
baseInnerRadius = 16;
baseOuterRadius = baseInnerRadius + shell;


difference() {
    
    union() {
        cylinder(baseHeight, r=baseOuterRadius);
        
         // cylinder(2, r=baseOuterRadius + 1);
        
        // translate([0,0, 4]) {
        //    cylinder(2, r=baseOuterRadius + 1);
        // }
        
        translate([0,0,baseHeight - 1]) {
            cylinder(topHeight, r=topOuterRadius);
        }
    }

    // hollow out the center
    union() {
        translate([0,0,- 1])
        cylinder(baseHeight, r=baseInnerRadius);

        translate([0,0,baseHeight - 2])
            cylinder(topHeight + 2, r=topInnerRadius);
    }
    
    
    // cutouts for vertical strips
    for (i=[1:numSides])  {
        translate([0,0,topHeight + baseHeight - 1])
        translate([topOuterRadius*cos(i*(360/numSides)),topOuterRadius*sin(i*(360/numSides)),0])
        rotate([0,0,360/numSides * i])
        cube([3,3,2],true);
    }
    

}

// base decorative ring
rotate_extrude(convexity = 10)
 translate([baseOuterRadius - 1, 0, 0])
polygon([[0,0], [2,0], [2,2],[1,3],[0,3]]);


// upper decorative
translate([0, 0, 6])
rotate_extrude(convexity = 10)
 translate([baseOuterRadius - 1, 0, 0])
polygon([[0,0], [1,0], [2,1],[2,2],[1,3],[0,3]]);

