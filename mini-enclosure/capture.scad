

module lefthandDoorCorner() {
translate([-(captureThickness - verticalShell), captureThickness / 2, 0]) column();
 baseCapture();
}


module righthandDoorCorner() {
    difference() {
    baseCaptureWithMagnet();
    translate([magnetOnCenter,captureThickness + 1,magnetOnCenter])
        rotate([90,0,0])
        cylinder(h = magnetThickness + 2, r1 = magnetDiameter, r2 = magnetDiameter, center = false);
    }
}

module baseCaptureWithMagnet() {

    thickness = captureThickness + shell - magnetThickness;

    captureEnd(thickness);
    translate([verticalShell,0,0]) rotate([0,-90,0]) captureEnd(thickness);

    translate([0,verticalShell]) captureSide(verticalShell);
    translate([0,thickness]) captureSide(magnetThickness);

}


module fixedCapture() {
    union() {
        baseCapture();
        translate([- embedExtention + verticalShell, 0,0]) cube([embedExtention, captureThickness, captureLength], false);
    }
}

module baseCapture() {

captureEnd(captureThickness);
translate([verticalShell,0,0]) rotate([0,-90,0]) captureEnd(captureThickness);

translate([0,verticalShell]) captureSide(verticalShell);
translate([0,captureThickness]) captureSide(verticalShell);


}

module captureEnd(thickness) {
    
    linear_extrude(verticalShell) {
        polygon (
            [
                [0,0],
                [captureLength, 0],
                [captureLength,thickness],
                [0, thickness]
            ]
        );
    }
    
}


module doorStop() {
    linear_extrude(captureThickness)
        capturePolygonExt(captureThickness); // this is using captureThickness constant arbitrarily
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