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




module rightFrontFoot() {
    
    union () {
        footTopWithLip();
        translate([
            legSide/2 - captureThickness, 
            -(legSide/2)   ,
            totalFootHeight]
        )
            rotate([90,90,-90])
            doorStop();
        
        translate([-legSide/2, (legSide/2) - captureThickness,0])
         mirror(1, 0,0) 
            fixedCapture();
    }

}




module footTopWithLip() {
    
    difference() {
        union() {
            genericFootTop();
            legShellExtention();
        }
    
    
    translate ([-(legSide/2) - legShell - 2,0,totalFootHeight + (legShellHeight / 2)  ]) 
        rotate([0,90,0]) legScrewHole();
    

      translate ([
        0,
        (legSide/2) +legShell + 2,
        totalFootHeight + (legShellHeight / 2)  ]) 
            rotate([0,90,-90]) legScrewHole();
    
}

  
    
}

module legScrewHole() {
    union() {
        screwHeadDiameter = legScrewHeadDiameter + 1;
        cylinder(legScrewHeadThickness + 1,d1 = screwHeadDiameter, d2 = screwHeadDiameter , true); 
        cylinder(legShell + 3,d1 = legScrewShaftDiamter, d2 = legScrewShaftDiamter, true);
    } 
}


module legShellExtention() {
            translate ([
            -(legSide/2) - verticalShell, 
            -(legSide /2) + verticalShell, 0]) {
         linear_extrude(totalFootHeight + legShellHeight) 
        polygon (
        [
        [0,0],
        [-legShell,0],
        [-legShell,legSide + legShell],
        [legSide,legSide + legShell],
        [legSide,legSide - verticalShell],
        [verticalShell, legSide - verticalShell],
        [verticalShell, 0]
        ]
        );
        }
}

module rearFoot() {
   
    difference() {
       
        
    union() {
        footTopWithLip();
        
        translate([legSide/2 - verticalShell, (legSide/2) - captureThickness,0])
                fixedCapture();
        
        translate([-legSide/2, -(legSide/2) + verticalShell ,0])
             rotate([0,0,-90]) 
                fixedCapture();
    }
    
    
   translate ([0,legSide/2 + legShell + verticalShell + 0.5,lowerFootHeight / 2]) 
    rotate([90,0,0])
    mirror([1,0,0])
    
    versionNumber("1.3.0");
    
}
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



module genericFootTop() {
    
    difference() {
        linear_extrude(totalFootHeight) 
            square(legSide, true);
        translate([0,0,-1]) 
        negativeFootRing();
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