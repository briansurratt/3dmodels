
include <honeycomb.scad>;

$fn = $preview ? 32 : 64;
// lenght = 125; // not used
// width = 90; // x
// depth = 29; // y

// power cable is centered on width side
powerCableDia = 10;





// wallThickness = 3;
// faceLip = wallThickness;
// margin = 0.5;

// totalWidth = width + 2 * wallThickness + margin;
// totalDepth = depth + 2 * wallThickness + margin;

// receiverDepth = 15;

nozzelDiameter = 0.4;



inchToMmRatio = 25.4;

//  8.1 in x 3.5 in x 1.1 in.

// width = 8.1 * inchToMmRatio; 
// length = 3.5 * inchToMmRatio;  
// height = 1.1 * inchToMmRatio;

// echo(str("width = ", width));
// echo(str("length = ", length));
// echo(str("height = ", height));

width = 205; 
length = 90;  
height = 29;

wall = nozzelMultiple(3);
margin = 1;

spineWidth = nozzelMultiple(20);
edgeWidth = nozzelMultiple(10);
armWidth = nozzelMultiple(25);
armLip = wall + nozzelMultiple(15);

screwDiaInch = 0.34;
shaftDiaInch = 0.142;
screwRecessInch = 0.11;

headDia = screwDiaInch * inchToMmRatio;
shaftDia = shaftDiaInch * inchToMmRatio;
screwRecess = screwRecessInch * inchToMmRatio;

screwHoleDia = headDia + 0.25;
shaftHoleDia = shaftDia + 0.25;

tabWidth = screwHoleDia + wall * 2; 

bodyWidth = width + margin + wall * 2;
bodyLength = length + margin + wall * 2;
armHeight = height + margin + wall;

holeWidth = bodyWidth - edgeWidth * 2;
holeLength = wall + 2;
holeHeight = wall * 2;


threadedInsertDiameter = 5;
threadedInsertHeight = 8;


// m4 x 16 (I think)

fudgeFactor = 0.25;
newScrewHeadDiam = 6.9 + fudgeFactor;
newScrewHeadHoleDiam = newScrewHeadDiam + margin;
newScrewHeadDepth = 3.9 + fudgeFactor;

newScrewTotalLength = 15.9 + fudgeFactor;
newScrewShaftLength = newScrewTotalLength - newScrewHeadDepth;
newScrewShaftDia = 3.8 + fudgeFactor * 2;


nutThickness = 2.9 + fudgeFactor;
nutDiameter = 8.08 + fudgeFactor;

holeRadius = 1.75;

module nutVoid() {
    linear_extrude(nutThickness + fudgeFactor) {
        hexagon(nutDiameter);
    }
}


// device();

// for back
// holeRadius = threadedInsertDiameter / 2; 
back();

// for front
// front();
// bump();

insertBodyRadius = (threadedInsertDiameter / 2) + wall;
insertBodyHeight = armHeight;

module insertWedge() {


    wedgeWidth = insertBodyRadius * 2 - wall + 1;
    wedgeHeight = armHeight - threadedInsertHeight;
    baseHeight= wedgeHeight - wedgeWidth;

    translate([-armWidth / 2, wedgeWidth+ wall/2,0]) 
    rotate([90,-90,90]) 
        linear_extrude(armWidth){ 
        polygon(
            [
                [0,0],
                [0,wedgeWidth],
                [baseHeight,wedgeWidth],
                [wedgeHeight,0]
            ]
        );
    }

}

module insert() {
    translate([0,insertBodyRadius - wall / 2 + 1 ,insertBodyHeight - threadedInsertHeight ]) {
        color("DarkGoldenrod") {
            linear_extrude(threadedInsertHeight) {
                circle(d = threadedInsertDiameter);
            }
        }
    }
}

module screwVoid() {
    shiftY = insertBodyRadius - wall / 2 + 1;
    shiftZ = insertBodyHeight - newScrewShaftLength + wall;
    shaftHoleLen = newScrewShaftLength - wall + margin;
    translate([0,shiftY,shiftZ]) {
        cylinder(h=shaftHoleLen, r = (newScrewShaftDia/2));
    }


    translate([0,shiftY,shiftZ - 1 + shaftHoleLen / 2 - nutThickness /2]) {
        nutVoid();
    }

    
}


// this makes the shape of the bump outside the arm
module insertBody () {
    linear_extrude(armHeight) {

        hull() {
            square([armWidth, wall],true);
            translate([0,insertBodyRadius-wall/2 + 1,0]) 
            circle(r = insertBodyRadius);
        }

    }
}


module back() {
    backPlate();
    arms();
}

module front()  {

    inset = 2*edgeWidth;

    linear_extrude(height = wall) {

        projection(cut = true) {
            translate([0,0,-armHeight + wall ]) { // lower intersting part down to 0 on z axis
                arms(); // need to tweak 
            }
        }
  
        difference() {
            square([bodyWidth, bodyLength], true);
            square([bodyWidth-inset, bodyLength-inset], true);
        }

    }

}




module screwHole() {
    union() {
    translate([0,0,-(screwRecess+wall)]) cylinder(wall*2, d = shaftHoleDia);
    translate([0,0,screwRecess/2]) cylinder(1, r = screwHoleDia / 2,true);
    cylinder(screwRecess, 1, screwHoleDia / 2, true);
    }
}



// produces a quantity which is a multiple of the nozzle diameter
// at least equal to the value passed
function nozzelMultiple (v) = (floor(v / nozzelDiameter) + 1) * nozzelDiameter;


module backPlate() {

    inset = 2*edgeWidth;

    screwOffSet= 56.8/2;

    difference() {


       cube([bodyWidth, bodyLength, wall], true);

        // union() {
        //     difference() {
        //         cube([bodyWidth, bodyLength, wall], true);
        //         cube([bodyWidth-inset, bodyLength-inset, wall + 2], true);
        //     }
        //     cube([spineWidth, bodyLength, wall], true);
        // }

        translate([0,screwOffSet,0]) screwHole();
        translate([0,-screwOffSet,0]) screwHole();
    }
    
    

}

module device() {
    nudge = wall /2 + margin /2;
    translate([0,0, nudge + height/2]) {
        #cube([width, length, height], true);
    }
}


module arms() {
    arm();
    arm(0,1);

}

module arm(mx = 0, my = 0) {

    hw = wall/2;

    mirror([mx,my,0]) {

        translate([-bodyWidth/2 + hw,bodyLength /2  - armWidth /2,armHeight / 2 - hw]) { 
            cube([wall, armWidth, armHeight], true);
            translate([armLip/2-hw,armWidth/2-hw,0])  
            #cube([armLip, wall, armHeight], true);
            bump();
        }

    }

}



module bump() {
    translate([0,0,-armHeight / 2]) 
    rotate([0,0,90]) 
    union() {    
        // insert();
        difference() {
            insertBody();
            screwVoid();
            insertWedge();
        }
    }
}

module body() {

    difference() {
        cube([bodyWidth, bodyLength, bodyHeight ]);
        translate([wall,wall,wall])  {
            cube([width + margin, length, height+ margin]);
        }
    }

}










































// frame();





// module frame() {

//     difference() {

//         // outer shell
//         cube([totalWidth, totalDepth, receiverDepth]);

//         // main void
//         translate([wallThickness+margin /2 - 10, wallThickness+margin /2, wallThickness])
//         cube([width + 10 + margin, depth + margin, receiverDepth]);

//         // power and vent boid
//         translate([wallThickness + faceLip, wallThickness + faceLip, -0.2])
//         cube([width - 2 * faceLip, depth - 2 * faceLip, wallThickness + 1]);

//         translate([25,wallThickness+margin, receiverDepth /2])
//         rotate([90,0,0])
//         screwHole();

//         // screw driver hole
//         translate([25,totalDepth, receiverDepth /2])
//         rotate([90,0,0])
//         cylinder(d=8, h=10, center=true);


//     }

// }

// module screwHole() {

//     screwHeadTopDia = 8;
//     screwHeadDepth = 3;
//     screwOD = 4.25;
//     shaftLength = 10;

//     translate([0, 0, shaftLength/2]) {
//         cylinder(d=screwOD, h=shaftLength, center=true);
//     }

//     translate([0, 0, screwHeadDepth/2]) {
//         cylinder(d1 = screwHeadTopDia, d2 = screwOD, h=screwHeadDepth, center=true);
//     }
    
// }
