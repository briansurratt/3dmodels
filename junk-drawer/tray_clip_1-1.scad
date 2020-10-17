width = 5; // x
layerThickness = 2; // y
depth = layerThickness * 3; // 

height = 10;

shortFingerLength = 5;
longFingerLength = shortFingerLength * 2;

overallLength = shortFingerLength + layerThickness + longFingerLength;

difference() {
    union() {
        // spine
        cube ([layerThickness, overallLength, height]); 
        
        // offset
        translate ([0, longFingerLength, 0])
            cube ([depth, layerThickness, height]);
        
        // finger
        translate ([layerThickness * 2, longFingerLength, 0])
            cube ([layerThickness, shortFingerLength + layerThickness, height]);
    }

    versionNumber();
}



version = "1.1";

module versionNumber() {
    translate([0.5, overallLength/2,height/2])
    rotate([90,0,-90])
    linear_extrude (1) {
    text(version, , 5, halign = "center", valign = "center");
    }
}
