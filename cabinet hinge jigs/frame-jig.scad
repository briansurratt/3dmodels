$fn=128;
nozzelDia = 0.4;

allowance = 0.5;
inchToMmRatio = 25.4;


threadedInsertDiameter = 5;
threadedInsertRadius = threadedInsertDiameter / 2;
threadedInsertHeight = 8;

// frameJig

frameThickness = 0.75 * inchToMmRatio;
offsetDistance = 2 * inchToMmRatio;  // from frame corner to hing

edgeToHoleCenter = 10;
distanceBetweenHoleCenters = 38;

holeHeight = threadedInsertHeight + allowance;

versionString = "1.1.0";

jigLength = 2 * offsetDistance + 2 * edgeToHoleCenter + distanceBetweenHoleCenters;
jigHeight = threadedInsertHeight;
jigWidth = frameThickness + allowance;

wingHeight = jigHeight * 2;
wingLength = jigLength;
wingWidth = nozzelDia * 11;

difference() {

    union() {
        cube([jigLength, jigWidth, jigHeight], true);
        wing();
        wing(-1);
    }

    translate([distanceBetweenHoleCenters/2, 0,0]) {
        #cylinder(h = holeHeight, r = threadedInsertRadius, center=true);
    }

    translate([-distanceBetweenHoleCenters/2, 0,0]) {
        #cylinder(h = holeHeight, r = threadedInsertRadius, center=true);
    }

    versionText();

}



module wing(multiplier = 1) {
    translate([0,multiplier * (jigWidth/2 + wingWidth /2),wingHeight/2 - jigHeight/2]) {
        cube([wingLength, wingWidth, wingHeight], true);
    }
}


module versionText() {
    translate([0,0,- jigHeight/2 - 0.5]){ 
        linear_extrude(height = 1) {
            mirror([1,0,0])  {
                text(text=versionString, size = 3, halign = "center");
            }
        }
    }
}





