// this model is designed to hold the emplacement models inside
// the cathedral model.  Measurements of the interior of the
// cathedral footprint were 116.5 x 67.5

// this produces a final model 113.5 x 66 x 45 (X,Y,Z) 

 $fn=50;

wallThickness = 1;
baseHeight = 2;  // the thickness of the bottof the tray
wallHeight = 45;

margin = 0.25; // a fudge factor

count=8;
unitHeight= 13.75;   // the vertical height of the emplacement models
unitWidth=63.5;      // the width of the widest part of the emplacement model

filletRadius = 3;

// the next two variables define the size of the void to hold the emplacement models
innerLength = 1 + (count * unitHeight) + (2 * margin);
innerWidth = unitWidth + 2 * margin;

// next two variables define the exterior dimension of the tray
totalLength = 2 * wallThickness + innerLength;
totalWidth = 2 * wallThickness + innerWidth;

// the radius of the fillet inside the corners of the tray
minkowskiRadius = filletRadius;

module innerVoid() {
   
    // minkowski() {
    //     cube([innerLength - minkowskiRadius * 2, innerWidth - minkowskiRadius * 2, wallHeight], true);
    //     cylinder(minkowskiRadius /2, center=true);
    // }

    cube([innerLength, innerWidth, wallHeight], true);

}

module lettering() {

    translate([-42.5,  -5, - wallHeight / 2 + 1]) {
    
        linear_extrude(height = 1.5) {
            text("emplacements", font = "Liberation Sans");
        }
   
    }

}


%difference() {
        
    cube(size=[totalLength, totalWidth, wallHeight], center=true);
    translate([0, 0, baseHeight]) {
        innerVoid();
    }
    lettering();

}

translate([0,0,wallHeight/-2 ]) {
    bottomFillets();
}


module filletEdge(l = 10, r = 2, w = 1) {

    cubeSide = r + w;

    #translate([w, w, 0]) {
        
        difference() {
            
            translate([cubeSide / 2 - w, cubeSide / 2  - w, 0]) {
                cube(size=[cubeSide, cubeSide, l], center=true);
            }

            translate([r, r, 0]) {
                cylinder(l, r, r, true);   
            }

        }


    }
}


module bottomFillets() {


    filletWall = 1;

    bottomFilletAdjustment = baseHeight - filletWall;

    // negative x end
    translate([totalLength/2 * -1, 0,bottomFilletAdjustment])
    rotate([90,0,0])
    #filletEdge(totalWidth,  filletRadius, filletWall);


    // // positive x end
    translate([totalLength/2, 0,bottomFilletAdjustment])
    mirror([1,0,0])
    rotate([90,0,0])
    #filletEdge(totalWidth,  filletRadius, filletWall);


    // negative y end
    translate([ 0,-totalWidth/2,bottomFilletAdjustment])
    rotate([90,0,0])
    rotate([0,90,0])
    #filletEdge(totalLength,  filletRadius, filletWall);

    // positive y end
    translate([ 0,totalWidth/2,bottomFilletAdjustment])
    rotate([90,0,0])
    rotate([0,-90,0])
    #filletEdge(totalLength,  filletRadius, filletWall);
    
}
