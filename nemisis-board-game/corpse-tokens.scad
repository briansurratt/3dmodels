version = "0.5.0";

$fn = 50;

function toUnits(inches=0, sixteenths=0) = (inches * 16) + sixteenths;

// recursive sum function on an array
// v = vector
// i = current index
// e = end index
// r = return value
function sum(v, i=0, e=0, r=0) = i<=e ? sum(v, i+1, e, r+v[i]) : r;


slots = [17,5,8];
diameter = 15;


channelWidth = diameter + 1;
channelLength = 32;

shellLength = channelLength + 2;
shellWidth = channelWidth + 2;
shellDepth = channelWidth + 1;

ribHeigh = (shellDepth / 2) - 2;

echo (channelLength);

module rib() {
    translate ([0, 0, -(ribHeigh) / 2]) cube ([shellWidth,1, ribHeigh], true);
}

module layoutRibs() {
    for (i = [0: len(slots) - 2] ) {
        y = sum(slots, 0, i);
        translate ([0, - (channelLength / 2) + 1,-1]) translate ([0,y + i,-1]) rib();
    };
}


difference() {
    cube ([shellWidth, shellLength, shellDepth], true);
    translate ([0,-channelLength/2, 1]) rotate ([0,90,90]) cylinder(channelLength, d = channelWidth, true);
    translate ([0,0, shellDepth / 2]) cube ([shellWidth+2, channelLength, shellDepth ], true);
    translate ([0, 0, - (shellDepth/2) + 0.5 ])
        rotate ([0,180,270])
            linear_extrude (1) {
                scale (.5, .5, .5)
                text(version, halign = "center", valign = "center");
            } ;
}

layoutRibs();

