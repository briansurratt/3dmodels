include <shared-variables.scad>;
include <modules.scad>;

module hallwayRough(len = 50) {
    cube([len,hallBaseWidth ,trayDepth]);
}

module centeredHallwayRough(len = 50) { 
    translate([-len/2, -hallBaseWidth / 2, 0]) 
    hallwayRough(len);
}

module hallwayTab(a=0) {

    // the margin added the y dimension is for insection with the hallway
    tabLength = hallTabWidth + hallTabBridge + margin;

    rotate([0, 0, a]) 
  
    translate([-hallBaseWidth/2, -tabLength/2,0])
  
    union() {
            
        // this is the male bit
        cube([hallBaseWidth, hallTabWidth, trayDepth]);

        // this is the part that spans the lip
        
        cube([hallBaseWidth,tabLength , standardDepth]);

    }

}


module simpleHallway() {


    union() {
        difference () {
            
            translate([-trayWidth, -hallBaseWidth/2, 0])
            hallwayRough(trayWidth * 2);

            xOffset = trayWidth - 3;

            translate([0,0,trayDepth - 1]) 
                mirror([1,0,0])
                versionStamp("3.0.1");

        }

        translate([trayWidth + hallTabBridge,0,0]) {
            #hallwayTab(90);
        }


        translate([-(trayWidth + hallTabBridge),0,0]) {
            #hallwayTab(270);
        }
    }


}

// hallwayTab();

%roomBlank();
// hipHallway();
//  mirror([0,1,0])  hipHallway();
verticleHallway();
// simpleHallway() ;

module verticleHallway() {

    // this works by laying down the base hex and 
    // interecting it with a peice of hallway
    // this gets us a hallway with the proper 60
    // degree ends

    // this is the distance the hallway object is shifted off 
    // the center of the tile
    offset =  trayWidth / 2;

    union() {
        difference() {

            intersection() {
            roomBlank();
                translate([0,offset,0]) {
                    centeredHallwayRough(100);
                }
            

            }

                    translate([0,offset,trayDepth - 1]) 
                mirror([1,0,0])
                versionStamp("3.0.1");

        }
        
        rotatedTab();
        mirror([1,0,0]) rotatedTab();
    }

}

module rotatedTab() {
        translate([
        cos(30) * (trayWidth + hallTabBridge),
        sin(30) * (trayWidth + hallTabBridge),
        0])
    #hallwayTab(120);
}


module roomBlank() {
    linear_extrude(totalHeight) regularPolygon(6, trayRadius);
}

module hipHallway() {


    roughoutCubeSide = tileDiameter + 10;
    bump = 1;
    len = trayWidth * 2;
    offset =  trayWidth / 2;

    difference() {
        
        // this is the base and walls of the hallway
        union() {

            translate([0, bump + hallBaseWidth / 2, 0])
            centeredHallwayRough(55);
            
             rotatedTab();
             mirror([1,0,0]) rotatedTab();

            // bottom entrance
            intersection() {
                    
                translate([-roughoutCubeSide/2, bump , 0])
                cube([roughoutCubeSide, roughoutCubeSide, totalHeight] );

                rotate([0,0,30])
                centeredHallwayRough(len);

            }

            // top entrance
            intersection() {

                translate([-roughoutCubeSide/2, bump, 0])
                cube([roughoutCubeSide, roughoutCubeSide, totalHeight] );
                
                rotate([0,0,-30])
                centeredHallwayRough(len);

            }
        }

        translate([0,bump + hallBaseWidth / 2,trayDepth - 1]) 
        mirror([1,0,0])
        versionStamp("3.0.1");

    }

}
