version = "0.5.0";

function toUnits(inches=0, sixteenths=0) = (inches * 16) + sixteenths;

stackHeight = toUnits(1, 12);
edge = 8;
faceToFace = 13;


voidWidth = 15;
voidLength = stackHeight + 1;

shellLength = voidLength + 2;
shellWidth = voidWidth + 2;
shellDepth = faceToFace + 2;

//linear_extrude (voidLength) {
//    polygon([0,0], [edge,0],[0,edge]);
//}

difference() {
    
    // shell
    cube ([shellWidth, shellLength, shellDepth],true);
    
    // open top
    translate ([0,0,shellDepth / 2]) cube ([shellWidth + 2, voidLength, faceToFace  + 2], true);
    
    // channel
    translate ([0, voidLength / 2, 0]) rotate ([90,0,0]) linear_extrude(voidLength) circle(voidWidth / 2, $fn=6);
    
    // version
    translate ([0, 0, - (shellDepth/2) + 0.5 ])
    rotate ([0,180,270])
        linear_extrude (1) {
            scale (.5, .5, .5)
            text(version, halign = "center", valign = "center");
        } ;
    
}





