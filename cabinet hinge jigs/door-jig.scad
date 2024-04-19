$fn=128;
nozzelDia = 0.4;

versionString = "1.0.0";

allowance = 0.5;
inchToMmRatio = 25.4;

threadedInsertDiameter = 5;
threadedInsertRadius = threadedInsertDiameter / 2;
threadedInsertHeight = 8;

holeHeight = threadedInsertHeight + allowance;

mountingPlateLength = 32.4;
mountingPlateWidth = 29.8;

vertDistanceBetweenHoles = 24;
horzDistanceBetweenHoles = 12;

topToHoleCenter = 90;
sideToHolCenter = 10;



// approximating printed form

// h     III          l
// h     III         l
// h     III        l
// h     III       l
// h     III      l
// XXXXXXIIIXXXXXX

// I = jigWidth
// X = wingWidth
// h = jigHeight
// l = jigLength



jigWidth = threadedInsertHeight;
jigLength = topToHoleCenter * 2;
jigHeight = 30;
wingWidth = nozzelDia * 11;
totalWidth= wingWidth * 4 + jigWidth;

union() {
    difference() {
        cube([jigLength,jigHeight, jigWidth], true); 
        versionText();
        holes();
    }

    translate([0,-1*(jigHeight/2 + wingWidth/2),0]) { 
        cube([jigLength, wingWidth, totalWidth], true);
    }
    translate([jigLength/2+ wingWidth/2,-wingWidth/2,0]) { 
        cube([wingWidth, jigHeight + wingWidth, totalWidth], true);
    }
}

module holes() {

    union() {
        translate([0,-horzDistanceBetweenHoles/2,0]) {

            cylinder(h = holeHeight, r = threadedInsertRadius, center=true);

            translate([vertDistanceBetweenHoles /2,horzDistanceBetweenHoles , 0]) { 
                cylinder(h = holeHeight, r = threadedInsertRadius, center=true);
            }

            translate([-vertDistanceBetweenHoles /2, horzDistanceBetweenHoles, 0]) { 
                cylinder(h = holeHeight, r = threadedInsertRadius, center=true);
            }
        }
    }

}


module versionText() {
    translate([topToHoleCenter/2,0,-jigWidth/2 - 0.5]){ 
        linear_extrude(height = 1) {
            mirror([1,0,0])  {
                #text(text=versionString, size = 3, halign = "center");
            }
        }
    }
}
