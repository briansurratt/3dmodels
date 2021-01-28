include <shared-variables.scad>;
include <modules.scad>;

module hallway(len = 50) {

translate([0,0,(baseHeight+ trayWallHeight)/2])
    difference() {
        cube([len,hallBaseWidth ,baseHeight+ trayWallHeight], center = true);
        translate([0,0,baseHeight])
            cube([len + 1,hallVoidWidth,trayWallHeight + 1], center = true);
    }

}

module magHoleTest() {
    
    difference() {
        
        hallway(5);
        translate ([-1,0,0])
            magHole();

    }

}

module simpleHallway() {

    difference () {
        
        hallway(tileWidth);

        xOffset = tileWidth / 2 - 2;

        translate([xOffset,0,0]) 
            magHole();

        translate([-xOffset,0,0]) 
            magHole();

    }

}

simpleHallway();