include <shared-variables.scad>;
include <modules.scad>;

module hallway(len = 50) {

    translate([-len/2, -hallBaseWidth / 2, 0]) {
        
        difference() {
            cube([len,hallBaseWidth ,baseHeight+ trayWallHeight]);
            translate([0,(hallBaseWidth-hallVoidWidth) / 2,baseHeight])
                cube([len + 1,hallVoidWidth,trayWallHeight + 1]);
        }

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

        xOffset = tileWidth / 2 - 3;

        translate([xOffset,0,0]) 
            magHole();

        translate([-xOffset,0,0]) 
            magHole();


        translate([0,0,baseHeight - 1]) 
            versionStamp("1.0.1");

    }


}

// simpleHallway() ;
verticleHallway();

module verticleHallway() {

    offset =  trayWidth / 2;

    difference() {
        

        intersection() {

            linear_extrude(baseHeight + trayWallHeight) regularPolygon(6, trayRadius);
            translate([0,offset,0]) {
                hallway(100);
            }
        

        }

        magHoleArray();

        translate([0,offset,baseHeight - 1]) 
            versionStamp("1.0.1");


    }



}
