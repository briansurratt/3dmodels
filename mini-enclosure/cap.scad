module rearCap() {

difference() {
union() {
    #linear_extrude(totalFootHeight) 
        square(legSide, true);

difference() {
legShellExtention();


    translate ([-(legSide/2) - legShell - 2,0,totalFootHeight + (legShellHeight / 2)  ]) 
        rotate([0,90,0]) legScrewHole();
    

      translate ([
        0,
        (legSide/2) +legShell + 2,
        totalFootHeight + (legShellHeight / 2)  ]) 
            rotate([0,90,-90]) legScrewHole();
}

        translate([legSide/2-verticalShell, (legSide/2) - captureThickness,0])
            fixedCapture();

        translate([-legSide/2, (-legSide/2)+verticalShell ,0])
rotate([0,0,-90])
 fixedCapture();



   translate ([-legSide/2 + captureThickness - verticalShell,-legSide / 2 + verticalShell, 0])
topMount();


   translate ([legSide/2  - verticalShell,legSide / 2  - captureThickness + verticalShell, 0]) #topMount();

}

   translate ([0,legSide/2 + legShell + verticalShell + 0.5,lowerFootHeight / 2]) 
    rotate([90,-90,0])
    mirror([1,1,0])
    
    versionNumber("1.0.0");
}


}
module topMount() {
    // this is the componet that will screw into the underside of the table top
    difference() {
    
    linear_extrude(legShell) 
   rotate([0,0,-90])
polygon([
[0,0],
[captureLength, 0],
[captureLength, captureLip],
[captureLip, captureLength, ],
[0, captureLength]
]);
        
    translate ([captureLength/2,-captureLength / 2, -1])
    legScrewHole();
    }
}