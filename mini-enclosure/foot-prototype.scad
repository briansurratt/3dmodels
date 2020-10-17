$fn = 100;

footerShell = 2;
verticalShell = 1.5;

plexiThickness = 2.5;

// legSide = 49.25;
legSide = 50.5;

totalFootHeight = 26;

lowerFootHeight = totalFootHeight / 2 - 1;

screwShaftRadius = 2;   // e
screwWellDepth = 5;     // b
screwHeadRadius = 4;    // f
screwHeadDepth = 2;    // f
topRadius = legSide / 4; // D
bottomRadius = legSide / 3;   // A

difference() {
linear_extrude(5) square(legSide + verticalShell, false);
translate ([0,0,verticalShell]) linear_extrude(5) square(legSide, false);
}

// genericFootBottom();
// genericFootTop();

module topShaft() {
rotate_extrude(angle = 360, convexity = 10)
    polygon (
    [
        [screwHeadRadius, lowerFootHeight-1],
        [screwHeadRadius,lowerFootHeight + screwHeadDepth],
        [screwShaftRadius, lowerFootHeight + screwHeadDepth], 
        [screwShaftRadius, totalFootHeight + 1],
        [0, totalFootHeight + 1],
        [0, lowerFootHeight- 1]
    ]
    );
}


module genericFootTop() {
    
    difference() {
        linear_extrude(totalFootHeight) 
            square(legSide, true);
        translate([0,0,-1]) 
        negativeFootRing();
        topShaft();
    }

}


module genericFootBottom() {
    
    difference() {
        linear_extrude(footerShell) 
            square(legSide, true);
        cylinder(2 * footerShell, r = screwShaftRadius);
    }

    footRing();

}

module negativeFootRing() {
     rotate_extrude(angle = 360, convexity = 10)
    polygon (
    [
        [0, 0],
        [0,lowerFootHeight],
        [topRadius, lowerFootHeight],
        [bottomRadius, 1],
        [bottomRadius, 0]
    ]
    );
   
}

module footRing() {
    rotate_extrude(angle = 360, convexity = 10)
    polygon (
    [
        [screwShaftRadius, 0],
        [screwShaftRadius, screwWellDepth],
        [screwHeadRadius, screwWellDepth],
        [screwHeadRadius, lowerFootHeight],
        [topRadius, lowerFootHeight],
        [bottomRadius, 0]
    ]
    );
    
}