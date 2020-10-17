width = 5; // x
layerThickness = 3; // y
depth = layerThickness * 3; // 

height = 10;

fingerLength = 5;

overallLength = 2 * fingerLength + layerThickness;

difference() {
    union() {
        // spine
        cube ([layerThickness, overallLength, height]); 
        
        // offset
        translate ([0, fingerLength, 0])
            cube ([depth, layerThickness, height]);
        
        // finger
        translate ([layerThickness * 2, fingerLength, 0])
            cube ([layerThickness, fingerLength + layerThickness, height]);
    }

    versionNumber();
}



version = "1.0";

module versionNumber() {
    translate([0.5, overallLength/2,height/2])
    rotate([90,0,-90])
    linear_extrude (1) {
    text(version, , 5, halign = "center", valign = "center");
    }
}
