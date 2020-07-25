version = "0.5.0";

function toUnits(inches=0, sixteenths=0) = (inches * 16) + sixteenths;


voidLength = toUnits(3,4);
voidWidth = toUnits(1,2);
voidDepth = toUnits(1,12);

shellLength = voidLength + 2;
shellWidth = voidWidth + 2;
shellDepth = voidDepth+ 1;


difference() {
    cube([shellWidth,shellLength, shellDepth],true);
    translate ([0,0,1]) cube([voidWidth,voidLength, voidDepth],true);
    translate ([0,0,voidDepth/2]) cube([shellWidth + 2,voidLength, voidDepth],true);
        translate ([0, 0, - (shellDepth/2) + 0.5 ])
    rotate ([0,180,270])
        linear_extrude (1) {
            scale (.5, .5, .5)
            text(version, halign = "center", valign = "center");
        } ;
    
}
translate ([0,0, - (voidDepth/6) + 1]) cube([1,shellLength, 2 * voidDepth/3], true);
    


