// unit = 1/32"

headCore = 8;

headSpread = 4;
headRise = 4;
headHeight = headCore + headRise;
headWidth = headCore + (2 * headSpread);
headDepth = headCore;

gap = 16;
armLength = gap + (headDepth * 2);

module head() {
    intersection() {
        linear_extrude(headHeight) polygon ([[0,0], [headWidth,0],[headWidth-headSpread,headDepth],[headSpread,headDepth]]);
         
        translate([headWidth,headDepth,0]) 
            rotate([90,0,270]) 
                linear_extrude(headWidth) 
                    polygon([[0,0], [headDepth, 0], [headDepth,headHeight], [0,headHeight-headRise]]);
    }
}


union() {
    head();
    translate([0,armLength,0]) mirror([0,1,0]) head();
    translate([headSpread,0,0]) cube([headCore,armLength,headCore]);
}

// this shape can be used to hollow out the arm is needed
// translate([1+headSpread,-1,1])         cube([headCore - 2, armLength + 2, headCore - 2]);
