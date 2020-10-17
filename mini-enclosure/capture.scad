

module lefthandDoorCorner() {
translate([-(captureThickness - verticalShell), captureThickness / 2, 0]) column();
 baseCapture();
}


module righthandDoorCorner() {
    difference() {
    baseCapture();
    translate([magnetOnCenter,captureThickness + 1,magnetOnCenter])
        rotate([90,0,0])
        cylinder(h = magnetThickness + 2, r1 = magnetDiameter, r2 = magnetDiameter, center = false);
    }
}

module baseCapture() {

captureEnd();
translate([verticalShell,0,0]) rotate([0,-90,0]) captureEnd();

translate([0,verticalShell]) captureSide(verticalShell);
translate([0,captureThickness]) captureSide(verticalShell + 1);


}

module captureEnd() {
    
    linear_extrude(verticalShell) {
        polygon (
            [
                [0,0],
                [captureLength, 0],
                [captureLength,captureThickness],
                [0, captureThickness]
            ]
        );
    }
    
}


module doorStop() {
    linear_extrude(captureThickness)
        capturePolygonExt(captureThickness);
}


module captureSide(thickness) {
    translate([0,0,captureLength])
     rotate([90,90,0]) 
    linear_extrude(thickness) {
        capturePolygon();
    }
}

module capturePolygonExt(ext) {
            polygon (
        [
            [0,-ext],
            [ 0, captureLip],
            [captureLip,captureLength],
        [captureLength,captureLength],
            [captureLength,-ext]
        ]
    );
}

module capturePolygon() {
    capturePolygonExt(0);
}


module column() {
    difference() {
        swingColumn();
        columnCutout();
    translate([0, 0, captureLength - cutoutHeight])  columnCutout();
    }
}



module columnCutout() {
        
    union() {
    
        cylinder(h = cutoutHeight, r1 = captureThickness / 2, r2 = captureThickness / 2, center = false);
        translate([0, - captureThickness / 2, 0]) 
            cube([captureThickness/2, captureThickness , cutoutHeight]);
    } 
        
}

module swingColumn() {
    
     difference() {
    
        union() {
            translate([0, - captureThickness / 2, 0]) cube([captureThickness, captureThickness , captureLength]);
            cylinder(h = captureLength, r1 = captureThickness / 2, r2 = captureThickness / 2, center = false);
        }
    
        cylinder(h = captureLength, r1 = pinDiameter, r2 = pinDiameter, center = false);
        
    }
    
}