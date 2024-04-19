include <honeycomb.scad>

$fn = 124;

nozzel = 0.4;

inchToMmRatio = 25.4;

wall = nozzel * 6;
hexWall = nozzel * 3;
margin = 1;

screwDiaInch = 0.34;
shaftDiaInch = 0.142;
screwRecessInch = 0.11;

headDia = screwDiaInch * inchToMmRatio;
shaftDia = shaftDiaInch * inchToMmRatio;
screwRecess = screwRecessInch * inchToMmRatio;

screwHoleDia = headDia + 0.25;
shaftHoleDia = shaftDia + 0.25;

tabWidth = screwHoleDia + wall * 2; 

width = 110; 
length = 75;  
height = 22;



inset = wall * 2;

bodyWidth = width + margin + wall * 2;
bodyHeight = height + margin + wall * 2;
bodyLength = length / 2 + wall;

holeWidth = bodyWidth - inset * 2;
holeLength = wall + 2;
holeHeight = bodyHeight - inset * 2;


honeycombWidth = holeWidth;
honeycombLength = bodyLength - inset * 2;
honeycombRadius = 5;

longWall();
translate([0,0,bodyHeight- wall]) {
    longWall();
}

shortWall();
translate([bodyWidth-wall,0,0]) {
    shortWall();
}

theFloor();


tab();
translate([bodyWidth - tabWidth,0,0]) {
    tab();
}

module tab() {

    smallDia = tabWidth / 2 * cos(30);

    translate([tabWidth/2, bodyLength + smallDia,0]) {
    
        difference()  {
            union() {

                linear_extrude(wall) {
                    hexagon(tabWidth);
                }

                translate([0,-smallDia/2    , wall/2]) {
                    cube([tabWidth, smallDia, wall],true);
                }
            } 
            cylinder(wall+2, d = shaftHoleDia);
            cylinder(screwRecess, 1, screwHoleDia / 2);
        }
    }

}


module theFloor() {

    holeWidth = bodyHeight - inset * 2;
    holeLength = 20;    
    
    translate([0,wall,0])  {
        rotate([90,0,0])  {
            difference() {
                honeycombWall(bodyWidth, bodyHeight);
                translate([bodyWidth - inset - holeLength,inset,-0.5]) {
                    cube([holeLength,holeWidth, wall + 2]);
                }
            }
            translate([bodyWidth - 2 * inset - holeLength, 0,0]) {
                cube([inset,bodyHeight, wall]);
            }
        }
    }


    


}

module longWall() {
    honeycombWall(bodyWidth, bodyLength);
}

module shortWall() {
    translate([wall,0,0])  {
        rotate([0,-90,0])  {
        honeycombWall(bodyHeight, bodyLength);
        }
    }
}

module honeycombWall(w = 10, l = 10, thickness = wall) {
 
    holeWidth = w - inset * 2;
    holeLength = l - inset * 2;

    difference() {
        cube([w,l, thickness]);
        translate([
            (w-holeWidth)/2,
            (l-holeLength)/2,
            -1
            ]) {
            cube([holeWidth, holeLength, thickness + 2]);
        }
    }

    linear_extrude(thickness) {
        #honeycomb(w,l,honeycombRadius,hexWall);
    }

}



module honeycombArray() {
 
    translate([
            (bodyWidth-honeycombWidth)/2,
            (bodyLength - honeycombLength)/2,
            0
        ]) {
        linear_extrude(wall + 2) {
            #honeycomb(honeycombWidth,honeycombLength,honeycombRadius,hexWall);
        }

    }

}


module honeycombHole() {
  translate([
            (bodyWidth-honeycombWidth)/2,
            (bodyLength - honeycombLength)/2,
            -margin
        ]) {
             cube([honeycombWidth,honeycombLength,wall + inset]);
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

module bottomHole() {



    translate([
        (bodyWidth-holeWidth)/2,
        -margin,
        (bodyHeight-holeHeight)/2
        ])  {
        cube ([
            holeWidth,
            holeLength,
            holeHeight
        ]); 
    }

}
