$fn = $preview ? 32 : 128;

bottleDiameter = 25; // rounded up
bottleLength = 78; // rounded up

wall = 2;
floor = 2;

pinDepth=4;
pinHeight=2;
pinThickness = 2;

rowLength = bottleLength + (2 * wall);


module bottleProxy() {
    translate([0, 0, bottleDiameter/2]) {
        rotate([90,0,0])
        cylinder(d=bottleDiameter, h=bottleLength, center=false);
    }
}

// pins();
//  tray(3);
// tray(4);
//  tray(6,false,false);
 tray(13,3,false,false);

module tray(n = 0, m=1, withPins = false, withMale = true) {

     trayWidth = bottleDiameter * n + 2 * wall;
     trayLength = bottleLength * m + 2 * wall + ((m-1) * wall);

    // female on 0, male on positive

    difference() {
        translate([0,-rowLength,0])
        cube([trayWidth,trayLength, bottleDiameter/3 + floor]) ;   

        bottleArray(n,m);

        if(withPins) {
            lengthPins(true);
            widthPins(trayWidth,true);
        }
    }

    if (withPins && withMale) {
        translate([trayWidth,0,0])
        lengthPins(false);

        translate([0,-rowLength,0])
        widthPins(trayWidth,true);
    }

}

module bottleArray(n = 0, m=1) {

    for (b =[0:m-1]) {

        yShift = -wall + b * bottleLength + b * wall;

        for (a =[0:n-1]) {

            xShift = wall + bottleDiameter/2 + (a * bottleDiameter);

            translate([xShift,yShift,floor]) {
                bottleProxy();
            }
                
        }

    }
    
}

module lengthPins(isFemale=false) {

    yShift = -rowLength/3;

    translate([0,yShift,0]) pin(isFemale);
    translate([0,2 * yShift,0]) pin(isFemale);

}

module widthPins(width = 0, isFemale=false) {

    xShift = width/3;

    translate([xShift,0,0])  rotate([0,0,-90]) pin(isFemale);
    translate([2*xShift,0,0])  rotate([0,0,-90])  pin(isFemale);

}

module pin(isFemale=false) {

    padding = isFemale ? 0.2 : 0 ;

    thickness = pinThickness + padding;

    translate([-0.1,thickness/2,0])
    rotate([90,0,0])


    linear_extrude(thickness)
    polygon(points=[
        [0,0],
        [0,pinHeight+padding],
        [pinDepth+padding,0]
        ]);
    
}