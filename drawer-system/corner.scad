module corner() {
    cornerArm();  
    rotate([0, 0, 90]) cornerArm(); 
}


module cornerArm(armLength = shortCornerArm) {
    
    otherShift = (armLength  - materialWidth - shellWidth * 2 - margin) / 2;
    armPinOffset = slotDepth / 2 + (shellWidth * 2 + materialWidth + margin) / 2;

    difference() {
        
        union() {
            translate([wallShift,otherShift,0])
                rotate([0,0,90])
                    wall(armLength);

            translate([-wallShift,otherShift,0])
                rotate([0,0,90])
                    wall(armLength);

            translate([0, otherShift, 0]) 
                rotate([0,0,90])
                    bottom(lenght=armLength);
        }

        translate([0, armPinOffset, 0]) 
            rotate([0,0,90])
                pinHole();


    }

}


module outsideCorner() {

    // offset used for this pin
    offset = (longCornerArm - totalWidth)/ 2 ;

    difference(){
        union() {
            translate([0,0,shellWidth + materialWidth]) {   
                cornerArm(longCornerArm);  
                rotate([0, 0, 90])  cornerArm(longCornerArm);
            }

            linear_extrude(shellWidth  * 2 + materialWidth) 
            translate([totalWidth/2, totalWidth/-2, 0]) 
                polygon([
                    [0,0],
                    [0,longCornerArm],
                    [-totalWidth,longCornerArm],
                    [-totalWidth, totalWidth],
                    [-longCornerArm, totalWidth],
                    [-longCornerArm, 0]
            ]);
            cornerBottom();
        }
        
        translate([-offset,offset,0]) 
            cylinder(d=pinHoleDia, h=pinLenth, center=true);

    }

}


module cornerBottom() {
    linear_extrude(shellWidth) 
    translate([totalWidth/2, totalWidth/-2, 0]) 
        polygon([
            [0,0],
            [0,longCornerArm],
            [-totalWidth,longCornerArm],
            [-longCornerArm, totalWidth],
            [-longCornerArm, 0],
    ]);
}