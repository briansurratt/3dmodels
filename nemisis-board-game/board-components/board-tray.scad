
// change log
// 
// 1.3.0 - added a stand off on one vertext, for use
//       a starting point for counting door numbers

include <modules.scad>;
include <shared-variables.scad>;
include <honeycomb.scad>;


module referenceTile() {
 translate([0,0,baseHeight]) 
    linear_extrude( tileThickness)  
        regularPolygon(6, tileDiameter / 2);
}

// tile tray

module trayWithWalls() {
    
    difference() {
        // base of the tray and walls
        linear_extrude(totalHeight) 
        roomHex();

        // take out space for tile
        translate ([0,0,baseHeight])  
            linear_extrude( trayWallHeight + 1) // extra for clean negative 
                regularPolygon(6, trayVoidRadius);
    }
}



%referenceTile();

difference() {
    trayWithWalls();
    doorwayArray();
    versionStamp("3.0.1");
   hallwayVoids();
    roomNumberRelief();
    floorTextureArray();
}

roomNumber(2);    

module hallwayVoids() {
    
    circularArray(pathRadius = hallSlotRadius) {
        hallwaySlot();
    }

    circularArray(pathRadius = hallSlotRadius) {
        hallwayReceiver();
    }

}

module hallwaySlot() {

    translate([-hallSlotLength/2, -hallSlotWidth/2, 0]) {
        cube([hallSlotLength, hallSlotWidth, hallSlotDepth]);
    }
        
}


// the vertical allowance to accomidate the doorway reach
module hallwayReceiver() {
    translate([-hallReceiverLength/2,0, standardDepth]) {
        cube([hallReceiverLength, hallReceiverWidth, hallReceiverDepth]);
    }
}


module roomNumberRelief() {
    translate([0,0, baseHeight - 0.5])
    linear_extrude(1)
    regularPolygon(6, r=roomNumberSize + 1);
}

module roomNumber(n = 1) {
    translate([-roomNumberSize/2,-roomNumberSize/2, baseHeight - 1])
    linear_extrude(1)
    text(str(n), font = "Arial Black:style=Bold", size=roomNumberSize);
}

module floorTextureArray() {
    circularArray(roomNumberSize + 2) 
        floorTexture();
}

module floorTexture() {

    w1 = 7;
    w2 = 25;
    l = 25;

    translate([0,0, baseHeight - 0.5])

    linear_extrude(1)
    // square(size=[7, 7], center=true);
    
    polygon(
        [
            [w1/2, 0],
            [-w1/2, 0],
            [-w2/2, l],
            [w2/2, l]
        ]
    );

}
