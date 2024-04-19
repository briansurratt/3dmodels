$fn = $preview ? 32 : 128;

nozzelDiameter = 0.4;

shaftOd = 4.5;
shaftOc = 124;
receiverSift = shaftOc/2;

ShaftHeight = 14.5;
wingsLenhth = 7.7;
wingsWidth = 1.5;
wingsHeight = 9.2;

rockface = 14;
rockdepth = 3.3;

receiverWall = 3 * nozzelDiameter;

recieverId = shaftOd  + 1;
recieverOd = recieverId + 2 * receiverWall; 
recieverHeight = 19.5 - rockdepth;

shaftToEdge = 8.3;

portalOd = shaftOc + 2 * shaftToEdge;
portalId = portalOd - rockface * 2;

pinDiameter = 4;
pinHeight = 4;


disc();
// face();


module disc() {

    discDepth= 2;

    

    difference() {
         
        cylinder(h = discDepth, r = receiverSift + 3);
        for (i = [0:3] ) {
            a = 90 * i;
            translate([cos(a) * receiverSift, sin(a)* receiverSift, 0])  cylinder(h = discDepth + 1, d = recieverOd + 0.75);
        }

        translate([0,0,discDepth-0.25]) 
            resize([portalId, portalId,1]) 
            texture();

    }   

    // for (i = [0:3] ) {
    //     a = 45 + 90 * i;
    //     translate([cos(a) * receiverSift, sin(a)* receiverSift, rockdepth - 0.1])  pin();
    // }


}

module texture () {
    difference() {
    cylinder(h = 1, r = 75);
        //  resize([portalId, portalId,1]) 
        translate([-155,-168,0]) 
            linear_extrude(5) {
                import("portal.svg", convexity=3);
            }
            }
}

module face() {

    translate([receiverSift,0,0]) receiver(1, true);
    translate([-receiverSift,0,0]) receiver(1);
    translate([0,receiverSift,0]) receiver();
    translate([0,-receiverSift,0]) receiver();

    difference() {
        cylinder(rockdepth, d1 = portalOd,d2= portalOd-1);
        translate([0,0,-1]) {
            cylinder(rockdepth + 2, d = portalId);
        }
        holeArray();
    }

    // pinArray();

}

module receiver(r=0, reference=false) {

    translate([0,0,recieverHeight + rockdepth - 0.5]) 
    rotate([0,0,90 * r]) 
    rotate([180,0,0]) 
    difference() {
        // exterior
        cylinder(h = recieverHeight, d=recieverOd);
        translate([0,0,-0.5]) 

        // interior
        cylinder(h = recieverHeight + 1, d=recieverId);

        // wing slot
        translate([-5,-1,0]) 
        if (reference) {
            cube([10,2,recieverHeight]);
        } else {
            cube([10,2,10]);
        }
        
    }

}

module holeArray() {
    sub = pinDiameter / 2;
    for (i = [0:7] ) {
        a = 22.5 + 45 * i;
        translate([cos(a) * receiverSift, sin(a)* receiverSift,0])
        cylinder(h=pinDiameter, r1 = sub, r2 = sub/2);
    }
}

module pinArray() {
    for (i = [0:3] ) {
        a = 45 + 90 * i;
        translate([cos(a) * receiverSift, sin(a)* receiverSift, rockdepth - 0.1])  pin();
    }
}

module pin() {

    
    sub = pinDiameter / 2;

    cylinder(h=pinDiameter, r1 = sub, r2 = sub/2);

}