 
insideDiameter = 48.4;
insideRadius = insideDiameter / 2;
bottomRadius = 55;


fudge = 0.5;
paddedIr = insideRadius + fudge;

totalHeight = 100;

$fn=100;

//difference() {
//    frame();
//    translate([2,5,0]) frame();
//}

rotate_extrude(angle = 360, convexity = 10) {
difference() {
    frame();
    translate([2,5,0]) frame();
}
}

   % cylinder(r=insideRadius, h=totalHeight-1, center=false);

module frame() {
    
    difference() {
        translate([-(bottomRadius+1)-0.1+2, 0.1,0]) 
        difference() {
            square([bottomRadius + 1, totalHeight]);
            resize([bottomRadius,totalHeight * 2]) {
                #circle(d=20);
            }
        }

        // carves out the channel
        translate([-(paddedIr),0,0])
        square([paddedIr+3, totalHeight+8]);
        
    }
    
}
    
