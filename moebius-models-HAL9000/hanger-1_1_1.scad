$fn=50;

version = "1.1.1";

width = 112; // the horizontal dimension of the face (X)
height = 10; // the vertical dimension of the face (Z)
depth = 21;  // the lenght of the wings (Y)
inset = 22;
shellThickness = 2;


keyRadius = 2;
keyHeight = 4;

difference() {   
union() {
// top
translate([0,0, height - shellThickness]) 
    cube ([width, 5, shellThickness]);

//lhs top corner
translate([0,0,height - shellThickness])
topCorner();

//rhs top corner
translate([width,0,height - shellThickness])
mirror([1,0,0])
topCorner();

// side
//translate([0,0, height-depth]) 
cube ([ shellThickness, depth, height]);

// side
translate([width-shellThickness,0, 0]) 
cube ([ shellThickness, depth, height]);

//face
rotate([90, 0,0])
translate([0, 0, -shellThickness]) 
cube ([width, height, shellThickness]);
}


translate([22, -1, keyHeight-1]) keyhole();
translate([width-22, -1, keyHeight-1]) keyhole();
versionNumber();
}


module topCorner() {
    linear_extrude(shellThickness)
    polygon (
            [
                [0,0],
                [0,depth],
                [shellThickness,depth],
                [depth, 5],
                [depth, 0]
            ]
        );
}

module versionNumber() {
    translate([width/2, 0.5,height/2])
    rotate([90,0,0])
    linear_extrude (1) {
    text(version, , 6, halign = "center", valign = "center");
    }
}

module keyhole() {

    rotate([-90, 0,0]) 
    linear_extrude(shellThickness + 2)
    union() {
    circle (r=keyRadius);
    translate([keyRadius, 0,0])
        polygon (
            [
                [0,0],
                [-(keyRadius + 1),0],
                [-keyRadius,keyHeight],
                [keyRadius,keyHeight]
            ]
        );

    translate([-keyRadius, 0,0])
        polygon ([
            [0,0],
            [(keyRadius + 1),0]    ,
            [(keyRadius + 1),keyHeight],
            [-keyRadius,keyHeight]
        ]
        );
    }

} // end keyhole module