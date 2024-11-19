$fn = 124;

include <honeycomb.scad>;

nozzelDiameter = 0.4;

inchToMmRatio = 25.4;

// width = 101; 
// length = 94;  
width = 94; 
length = 101;  
height = 29;

wall = nozzelMultiple(3);
margin = 1;
spineWidth = nozzelMultiple(20);
edgeWidth = nozzelMultiple(10);
armWidth = nozzelMultiple(25);
armLip = wall + nozzelMultiple(5);

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



module nutVoid() {
    linear_extrude(nutThickness + fudgeFactor) {
        hexagon(nutDiameter);
    }
}





// back();


front();


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

        union() {
            difference() {
                cube([bodyWidth, bodyLength, wall], true);
                cube([bodyWidth-inset, bodyLength-inset, wall + 2], true);
            }
            cube([spineWidth, bodyLength, wall], true);
        }

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
    mirror([1,0,0]) {
        arm();
        arm(0,1);
    }
}

module arm(mx = 0, my = 0) {

    hw = wall/2;


    mirror([mx,my,0]) {

        translate([-bodyWidth/2 + hw,bodyLength /2  - armWidth /2,armHeight / 2 - hw]) { 
            cube([wall, armWidth, armHeight], true);
            translate([armLip/2-hw,armWidth/2-hw,0])  cube([armLip, wall, armHeight], true);
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

