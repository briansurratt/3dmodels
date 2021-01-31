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
        
        hallway(trayWidth * 2);

        xOffset = trayWidth - 3;

        translate([xOffset,0,0]) 
            rotate([180,0,0]) magHole();

        translate([-xOffset,0,0]) 
            rotate([180,0,0]) magHole();


        // translate([0,0,baseHeight - 1]) 
            versionStamp("1.2.1");

    }


}


 simpleHallway() ;
// verticleHallway();

module verticleHallway() {

    // this works by laying down the base hex and 
    // interecting it with a peice of hallway
    // this gets us a hallway with the proper 60
    // degree ends


    offset =  trayWidth / 2;

    difference() {

        intersection() {
            linear_extrude(baseHeight + trayWallHeight) regularPolygon(6, trayRadius);
            translate([0,offset,0]) {
                hallway(100);
            }
        

        }

        magHoleArray(skip=[1,3,4,5]);
        translate([0, offset, 0])
        versionStamp("1.2.2");

    }



}
