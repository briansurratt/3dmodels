include <shared-variables.scad>;
include <modules.scad>;

module hallwayRough(len = 50) {
    cube([len,hallBaseWidth ,baseHeight+ trayWallHeight]);
}

module centeredHallwayRough(len = 50) { 
    translate([-len/2, -hallBaseWidth / 2, 0]) 
    hallwayRough(len);
}

module hallway(len = 50) {

    translate([-len/2, -hallBaseWidth / 2, 0]) {
        
        difference() {
            hallwayRough();
            translate([0,(hallBaseWidth-hallVoidWidth) / 2,baseHeight])
                cube([len + 1,hallVoidWidth,trayWallHeight + 1]);
        }

    }

}

module hallwayInsert() {

// this is the male bit
    cube([hallBaseWidth, hallTabWidth, trayDepth]);

// this is the part that spans the lip
    cube([hallBaseWidth, hallTabWidth + hallTabReach + margin, standardDepth]);

// this is rest of the hallway
// just a place holder
    translate([0, hallTabWidth + hallTabReach, 0])  {
        cube([hallBaseWidth, trayDepth, trayDepth]);
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

hallwayInsert();

// %roomBlank();
// hipHallway();
// mirror([0,1,0])
// hipHallway();
//  simpleHallway() ;

module verticleHallway() {

    // this works by laying down the base hex and 
    // interecting it with a peice of hallway
    // this gets us a hallway with the proper 60
    // degree ends


    offset =  trayWidth / 2;

    difference() {

        intersection() {
           roomBlank();
            translate([0,offset,0]) {
                hallway(100);
            }
        

        }

        magHoleArray(skip=[1,3,4,5]);
        translate([0, offset, 0])
        versionStamp("1.2.2");

    }



}

module roomBlank() {
    linear_extrude(totalHeight) regularPolygon(6, trayRadius);
}

module hipHallway() {

    bump = 1;
    len = trayWidth * 2;
    offset =  trayWidth / 2;

    difference() {

        // this is the base and walls of the hallway
        union() {

            translate([0, bump + hallBaseWidth / 2, 0])
            centeredHallwayRough(55);

            // bottom entrance
            intersection() {
                    
                translate([-tileDiameter/2, bump , 0])
                cube([tileDiameter, tileDiameter, totalHeight] );

                rotate([0,0,30])
                centeredHallwayRough(len);

            }

            // top entrance
            intersection() {

                translate([-tileDiameter/2, bump, 0])
                cube([tileDiameter, tileDiameter, totalHeight] );
                
                rotate([0,0,-30])
                centeredHallwayRough(len);

            }
        }


        // this is the void for the hallway
        union() {
            
            intersection() {
                translate([-tileDiameter/2, bump + (hallBaseWidth-hallVoidWidth) / 2, 0])
                cube([tileDiameter, tileDiameter, totalHeight + 2] );
                translate([-cos(30) * 2,sin(30) * 2,0])
                rotate([0,0,-30])
                centerHallwayVoid(len);
            }


            intersection() {
                translate([-tileDiameter/2, bump + (hallBaseWidth-hallVoidWidth) / 2, 0])
                cube([tileDiameter, tileDiameter, totalHeight + 2] );
                translate([cos(30) * 2,sin(30) * 2,0])
                rotate([0,0,30])
                centerHallwayVoid(len);
            }

            translate([0, bump + (hallVoidWidth / 2) + (hallBaseWidth-hallVoidWidth) / 2, 0])
            centerHallwayVoid(55);

        }

        translate([0, bump + (hallVoidWidth / 2), 0])
        versionStamp("1.0.0");

    }


}

module centerHallwayVoid(len = 50)  {
    translate([-len/2,-hallVoidWidth / 2,baseHeight])
    cube([len + 1,hallVoidWidth,trayWallHeight + 1]);
}

