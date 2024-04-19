$fn=126;
nozzelDia = 0.4;

interfaceWidth = 50;
interfaceLength = 70;
interfaceDepth = 15;

wallThickness = 5;

plateWidth = 2 * wallThickness + interfaceWidth;
plateDepth =  wallThickness + interfaceDepth;
plateLength = wallThickness + interfaceLength; 

faceDepth = 2 * wallThickness;

rightFaceKnotch = 10;

versionString = "1.1.0";


// back plate
difference() {
    cube([plateWidth, plateLength, wallThickness], true);

    translate([0, 20, wallThickness/2])  {
        hole();
    }

    translate([0, -20, wallThickness/2])  {
        hole();
    }
    versionText();
}




//  foot
translate([0,-plateLength/2 + wallThickness/2,plateDepth/2-wallThickness/2]) {
    cube([plateWidth,wallThickness,plateDepth], true);
}


// walls
translate([-plateWidth/2 + wallThickness/2,0,plateDepth/2-wallThickness/2]) {
    cube([wallThickness,plateLength,plateDepth], true);
}

translate([plateWidth/2 - wallThickness/2,0,plateDepth/2-wallThickness/2]) {
    cube([wallThickness,plateLength,plateDepth], true);
}


// faces
translate([plateWidth/2 - faceDepth/2,-wallThickness,plateDepth-wallThickness]) {
    #cube([faceDepth,plateLength -  rightFaceKnotch,wallThickness], true);
}

translate([-plateWidth/2 + faceDepth/2, 0,plateDepth-wallThickness]) {
    cube([faceDepth,plateLength ,wallThickness], true);
}

module hole() {
    mirror([0,0,1]) 
    screw_countersunk(
        35,
        8,
        3.1,
        4
    );
}

module screw_countersunk(
        l=20,   //length
        dh = 6,   //head dia
        lh = 3,   //head length
        ds = 3.2,  //shaft dia
        )
{
    union() {
        cylinder(h=lh, r1=dh/2, r2=ds/2);
        cylinder(h=l, r=ds/2);
    }
}


module versionText() {
    translate([0,0,- wallThickness/2 - 0.5]){ 
        linear_extrude(height = 1) {
            mirror([1,0,0])  {
                text(text=versionString, size = 3, halign = "center");
            }
        }
    }
}