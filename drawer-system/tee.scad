
module tee() {
    
    unitLength = slotDepth * 2 + shellWidth * 2 + materialWidth + margin;
    pinOffset = (unitLength - slotDepth) / 2; 

    difference() {

        union() {
            translate([0,wallShift,0]) wall(unitLength);
            translate([0,-wallShift,0]) wall(unitLength);
            bottom(lenght=unitLength);
        }
        translate([pinOffset, 0, 0]) pinHole();
        translate([-pinOffset, 0, 0]) pinHole();

    }

    armLength = slotDepth + shellWidth * 2 + materialWidth + margin;
    otherShift = (armLength  - materialWidth - shellWidth * 2) / 2;
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