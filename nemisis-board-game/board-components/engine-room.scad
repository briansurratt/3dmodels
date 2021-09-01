include <modules.scad>;
include <shared-variables.scad>;


module engineRoomBase() {
    
    linear_extrude(totalHeight)
    roomHex();

    width = trayWidth*2;

    translate([-23,-width/2,0]) 
    cube ([width,width,totalHeight]);

}


module engineRoomVoid() {
    
    width = (trayWidth - mediumWall) * 2;

    translate ([0,0,baseHeight])  
        linear_extrude( trayWallHeight + 1)
    intersection () {
        union() {
            regularPolygon(6, trayRadius);
            translate([width,0,0])
            regularPolygon(6, trayRadius);
        }
        translate([-width/2,-width/2,0]) 
        cube ([width,width,trayWallHeight + 1]);
    }

}

difference() {
    engineRoomBase();
    engineRoomVoid();
    doorwayArray();
    magHoleArray([5,6]);
    versionStamp("1.0.0");
}
doorMarker(180);



module engineRoomVoid() {
    // this is over sized for because of 
    // the intersection used later
    width = trayWidth  * 2;
    voidWidth = trayVoidRadius;

    translate ([0,0,baseHeight])  
        linear_extrude( trayWallHeight + 1)

    union() {
        regularPolygon(6, voidWidth);
    
        intersection() {
            
            union() {
                regularPolygon(6, voidWidth);
                translate([width/2 - 2,0,0])
                regularPolygon(6, voidWidth);
            }

            translate([-25,-width/2,0])
            square(width);

        }

    }

}
