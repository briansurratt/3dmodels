

function toUnits(inches, thrsecs) = (inches * 32) + thrsecs;

hexCrossVertex = toUnits(3,14);
tileRadius = (hexCrossVertex / 2);

wallThickness = 3;

frameRadius = tileRadius  + wallThickness * 2; // 3/32" on either side
frameheight = 10; // 5/16

floorThickess = 2; // 1/16
floorHeight = 3;

voidRadius = tileRadius + 2;
voidheight = frameheight - floorHeight - floorThickess + 2; // 1/8" + some extra

bottomvoidRadius = frameRadius - 4; // 1/16 on each side
bottomVoidThickness = floorHeight + 1;

// reference tile
%translate ([0,0,floorHeight + floorThickess + 1])
linear_extrude (2) {
    circle(tileRadius, $fn=6);
}

// frame

difference() {
    linear_extrude (frameheight) {
        circle(frameRadius, $fn=6);
    }


    translate ([0,0,4])
    linear_extrude (voidheight) {
        circle(voidRadius, $fn=6);
    }
    
    translate ([0,0,floorHeight - bottomVoidThickness])
    linear_extrude (bottomVoidThickness) {
        circle(bottomvoidRadius, $fn=6);
    }
    #holes();
    
}

module shim() {
    polyhedron(
  points=[ 
  [0,0,0],   // 0
  [5,0,0],  // 1
  [1, 2, 0], // 2
  [4,2,0],  // 3
  [1,2,2], // 4
  [4,2,2], // 5
  [0,0,4], // 6
  [5,0,4] // 7
  ],                                  
  faces=[ 
    [0,1,2], [1,2,3], // bottom
    [2,3,4], [3,4,5],  // face
    [4,6,7], [4,5,7], // pitch
    [0,1,7], [0,6,7],  // back
    [0,2,4], [0,4,6], // left
    [1,3,5], [1,5,7] // right
    ]         ,
convexity = 10    
 );
    translate([1,2,0]) cube ([3,3,2]);
    translate([0,-1,0]) cube([5,1,4]);
 }
 
 
//scale ([10,10,10]) shim();
 
module holes() {
    pathRadius=frameRadius - 3;

    sides=6;
    apothem = pathRadius / (2 * tan (180 / sides));

    for (i=[1:sides])  {
        translate(
            [
                apothem*sin(i*(360/sides)),
                apothem*cos(i*(360/sides)),
                0
            ]
        ) 
        rotate ([0,0,-((i) * 60) ]) 
        translate ([-2,-1,-1])    
        shim();
    }

}

    

 