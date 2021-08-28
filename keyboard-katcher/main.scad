
wallThickness = 5;

// (B)
keyboardThickness = 10;

// (D)
frameHeight = 64;
frameThickness = 21;

// this 
insertThickness = 2.75 // 3.25;

// (C)
insertLenth = frameThickness + wallThickness + 10; // this 10 is a place holder until I get the  inserts

receiveDepth = 25 + wallThickness; // this is the horz width to catch the keyboard, printed depth of the peice


//   (C)
// *****************    *
//                 *    *
//                 *    *
//             (D) *    *
//                 *    * (A)
//                 ******
//                   (B)

linear_extrude(height=receiveDepth,  convexity=10, twist=0) {
    
    union() {   

        // part A
        square(size=[frameHeight, wallThickness]);

        // part B
        square(size=[wallThickness, keyboardThickness + 2 * wallThickness]);


        // part D
        translate([0, (keyboardThickness + wallThickness), 0]) {
            square(size=[frameHeight, wallThickness]);
        }

        translate([frameHeight - insertThickness, keyboardThickness + wallThickness, 0]) {
            square(size=[insertThickness, insertLenth]);
        }

    }

}

#cube(size=[frameHeight, keyboardThickness + 2 * wallThickness, wallThickness], center=false);






