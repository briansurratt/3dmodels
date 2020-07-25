version = "0.5.0";

function toUnits(inches=0, sixteenths=0) = (inches * 16) + sixteenths;

playerBoardWidth = toUnits(4,8);
playerBoardLength = toUnits(7,6);

cutoutSide = 6;
cutoutHypotenuse = 8.5;

stackDepth = 8;

intruderBoardWidth = playerBoardWidth;
intruderBoardLength = toUnits(7,4);

voidDepth = stackDepth;
voidWidth = playerBoardWidth + 1;
voidLength = playerBoardLength + 1;

shellDepth = voidDepth + 2 ;
shellWidth = voidWidth + 2;
shellLength = voidLength + 2;

module cornerCutout() {
    linear_extrude (stackDepth) {
    polygon( points = [ [0,0], [0,cutoutSide],  [cutoutSide,0]]);
    }
}

difference() {
    cube ([shellWidth, shellLength, shellDepth], true);
    translate ([0,0,1]) cube ([voidWidth, voidLength, voidDepth+ 2], true);
    
    translate ([shellWidth / 4, 0, - (shellDepth / 2) + 0.5])
    rotate ([0,180,90])
        linear_extrude (1) {
            scale (.5, .5, .5)
            text(version, halign = "center", valign = "center");
        } ;
}



translate ([voidWidth/2 , - voidLength/2 ,-(voidDepth /2) ]) rotate (90) cornerCutout();
translate ([-(voidWidth/2) ,  -voidLength/2 ,-(voidDepth /2) ]) rotate (0) cornerCutout();
translate ([-voidWidth/2 ,  voidLength/2 ,-(voidDepth /2) ]) rotate (270) cornerCutout();
translate ([voidWidth/2 ,  voidLength/2 ,-(voidDepth /2) ]) rotate (180) cornerCutout();

// validate that the intruder board fits as expected 
// translate ([0,0,voidDepth/2]) cube ([intruderBoardWidth, intruderBoardLength, 1], true);
