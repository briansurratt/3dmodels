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

module rearFoot() {
    footTopWithLip();
}


module rightFrontFoot() {
    footTopWithLip();
    translate([
        legSide/2 - captureThickness, 
        -(legSide/2)   ,
        totalFootHeight]
    )
        rotate([90,90,-90])
        doorStop();
}


module leftFrontFoot() {
    difference() {
        footTopWithLip();
        translate([(legSide/2) - captureThickness/ 2, - (legSide/2) + captureThickness/ 2 , totalFootHeight/2]) 
            union() {
                // pin hole
                cylinder(h = totalFootHeight, r1 = pinDiameter, r2 = pinDiameter, center = true);
                // hinge cut out
                cube([captureThickness, captureThickness , (totalFootHeight  * (3/5)) + 1], true);
            }
    }  
}

module footTopWithLip() {
    union() {
        genericFootTop();
         translate ([-(legSide/2), -(legSide /2), 0]) {
        //translate ([0, 0, 0]) {
         linear_extrude(totalFootHeight + 5) 
        polygon (
        [
        [0,0],
        [0,legSide],
        [legSide,legSide],
        [legSide,legSide - verticalShell],
        [verticalShell, legSide - verticalShell],
        [verticalShell, 0]
        ]
        );
        }
    }
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