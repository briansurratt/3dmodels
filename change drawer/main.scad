$fn=256;

// z = depth
// x = wdith
// y = length

nozzelDiameter = 0.4;
wallThickness = nozzelDiameter * 6;

inchesToMmRatio = 25.4;

wellRadius = 5;

totalLength = (11.5 * inchesToMmRatio) / 2;

// totalLength = (11.5 / 4) * inchesToMmRatio;

totalWidth = 2.5 * inchesToMmRatio;
totalHeight = 1.5 * inchesToMmRatio;

slopeDepth = 0.5 * inchesToMmRatio;
slopeHeight = totalHeight;

numberOfCells = 2;
numberOfWalls = numberOfCells + 1;
numberOfSeperatorWalls = numberOfWalls - 2;

cellWidth = totalWidth - 2 * wallThickness;
cellLength = (totalLength - (numberOfWalls * wallThickness)) / numberOfCells;

module prusamain() {
    difference() {
        union(){
            trayFloor();
            perimeter();
            wellFillet(wellRadius);
            dividerWalls();
            wellFillet2();
        }
        pinHoles();
    }
}


module dividerWalls() {
    for (i = [1:numberOfSeperatorWalls]) {
        yOffset = wallThickness + (i * cellLength);
        translate([ 0, yOffset, 0]) {
            widthWall();
        } 
    }
}

pin();

pinDiameter = 5;
pinHeight = 2 * wallThickness;
pinOffset= 2 * pinDiameter;

module pin() {
  cylinder(h = pinHeight, r = (pinDiameter / 2));
}

module pinHoles() {

    translate(v = [pinOffset, wallThickness + 1, pinOffset]) {
        pinHole();
    }


    translate(v = [totalWidth - pinOffset, wallThickness + 1, totalHeight - pinOffset]) {
        pinHole();
    }

}

module pinHole() {
    rotate([90,0,0]) { 
    cylinder(h = wallThickness + 2, r = ((pinDiameter + 1) / 2));
    }
}


module wellFillet(r=10) {
    translate([0,totalLength / 2, 0])  {
        rotate([90,0,0]) {
            filletEdge(totalLength, r, wallThickness);
        } 
    }
}


module wellFillet2() {
    translate([totalWidth, 0,0]) { 
        mirror([1,0,0]) {

            translate([0,totalLength / 2, 0])  {
                rotate([90,0,0]) {
                    filletEdge2(
                        l = totalLength,
                        r = slopeDepth,
                        w = wallThickness,
                        h = totalHeight
                    );
                }
            }
        }
    }
}



module filletEdge(l = 10, r = 2, w = 1) {

    cubeSide = r + w;

    translate([w, w, 0]) {
        
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

// l = length
// r = radius
// w = wall thickess (top and bottom)
// h = height
module filletEdge2(l = 10, r = 2, w = 1, h= 2) {

    postiveBodyWidth = r + w;
    postiveBodyHeight = h ;

    translate([w, w, 0]) {
        
        difference() {
            
            translate([postiveBodyWidth / 2 - w, postiveBodyHeight / 2  - w, 0]) {
                cube(size=[postiveBodyWidth, postiveBodyHeight, l], center=true);
            }

            translate([r, h, 0]) {
                resize([0,h*2,0], false)  {
                    cylinder(l, r, r, true);   
                }
            }

        }

    }
}





module perimeter() {

    lengthWall();

    translate([totalWidth - wallThickness, 0, 0])  {
        lengthWall();
    }

    widthWall();

    translate([0, totalLength- wallThickness, 0])  {
        widthWall();
    }

}


// floor
module trayFloor() {

    linear_extrude(height = wallThickness) {
        polygon(
            points = [[0,0], [0,totalLength], [totalWidth, totalLength], [totalWidth, 0]]
        );
    }
}



// perimeter

module widthWall() {
    linear_extrude(height = totalHeight) {
        polygon(
            points = [[0,0], [totalWidth,0], [totalWidth, wallThickness], [0, wallThickness]]
        );
    }
}

module lengthWall() {
    linear_extrude(height = totalHeight) {
        polygon(
            points = [[0,0], [0,totalLength], [wallThickness, totalLength], [wallThickness, 0]]
        );
    }
}


