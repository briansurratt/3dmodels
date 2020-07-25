version = "0.5.0";

function toUnits(inches=0, sixteenths=0) = (inches * 16) + sixteenths;

voidWidth = toUnits(3,8);
voidLength = toUnits(2,8);
voidDepth = 7;

shellWidth = voidWidth + 2;
shellLength = voidLength + 2;
shellDepth = voidDepth + 1;

difference() {
    // shell
    cube ([shellWidth, shellLength,shellDepth ], true);
    // void
    translate ([0,0,1]) cube ([voidWidth, voidLength,voidDepth], true);
    // version
    translate ([0, 0, - (shellDepth / 2) + 0.5])
    rotate ([0,180,0])
        linear_extrude (1) {
            scale (.5, .5, .5)
            text(version, halign = "center", valign = "center");
        } ;
        
    translate ([shellWidth / 4 - 1, 0, - (shellDepth / 2) + 0.5])
        rotate ([0,0,90])
        linear_extrude (1.5) {
            scale (.5, .5, .5)
            text("fire", halign = "center", valign = "center");
        } ;
        
    translate ([- (shellWidth / 4) - 1, 0, - (shellDepth / 2) + 0.5])
        rotate ([0,0,90])
        linear_extrude (1.5) {
            scale (.5, .5, .5)
            text("broken", halign = "center", valign = "center");
        } ;
}

cube ([1,shellLength, shellDepth], true);

