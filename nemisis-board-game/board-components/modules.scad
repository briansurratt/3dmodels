 module regularPolygon(order = 4, r=1){
     angles=[ for (i = [0:order-1]) i*(360/order) ];
     coords=[ for (th=angles) [r*cos(th), r*sin(th)] ];
     polygon(coords);
 }

 module magHole() {
    
    magHoleThickness = magnetThickness + magnetMargin;
    magHoleDiameter = magnetDia+ magnetMargin;

    translate ([-magHoleThickness/2,0,0])
        rotate([0,0,90])
            translate ([0,0,-magHoleDiameter/2 - 1])
                rotate([90,0,0])
    
                    union() {

                        cylinder(magHoleThickness, d = magHoleDiameter);

                        translate([-magHoleDiameter/2,0,0]) {
                            cube([magHoleDiameter, magHoleDiameter + baseHeight, magHoleThickness]);
                        }
                        
                    }

}

module magHolePair() {

    hexSide = trayRadius * sin(30) * 2;
    magHoleSpacing = hexSide / 3;
    magHoleOffset = magHoleSpacing / 2 - magnetDia / 2;


    translate([magHoleOffset, 0,0]) rotate(90) magHole();
    translate([-magHoleOffset, 0,0]) rotate(90) magHole();


}

module magHoleArray(skip=[]) {
    circularArray(trayWidth - 3, skip) { 
        rotate([180,0,90]) magHole();
    }
    
}

// the skipList parameter allows specific elements in the 
// circular array to be omitted.  This will be used when
// creating hallway peices.
module circularArray(pathRadius = 10, skipList=[]) {

    num = 6;

    for (i=[1:num])  {

        if (!search(i, skipList)) {
            
            angle = (i * (360/num)) + 30;
        
            translate(
                [
                    pathRadius*cos(angle),
                    pathRadius*sin(angle) ,
                    0
                ]) 
            rotate((i-1)*60)    
            #children(0);
    
        }

    }

}

module versionStamp(version = "0.0.0") {
    translate(0,0,-0.5)
        linear_extrude (1)
        mirror([1,0,0])
        text(version, halign = "center", valign = "center", size = 5);
} 

module roomHex() {
    regularPolygon(6, trayRadius);
}

module doorMarker(a=60) {
    
    pathRadius = trayRadius;

    // rotate(30)
    translate([
        pathRadius*cos(a),
        pathRadius*sin(a),
        0])
    linear_extrude (totalHeight)
    regularPolygon(6, 2);

}

module doorway() {

    translate([
            hallVoidWidth/2,
            -doorVoidThickness / 2,
            baseHeight
        ]) 
        rotate(90)
            cube([doorVoidThickness, hallVoidWidth , trayWallHeight + 1 ]);
    
}

module doorwayArray() {
    num = 6;
    pathRadius = (tileWidth / 2) + (doorVoidThickness / 2);
    
    for (i=[1:num])  {
        
        angle = (i * (360/num)) + 30;
        
            translate(
                [
                    pathRadius*cos(angle),
                    pathRadius*sin(angle) ,
                    0
                ]) 
            rotate((i-1)*60)    
            doorway();
    
        }
    
}