version = "0.5.0";

$fn = 50;

function toUnits(inches=0, sixteenths=0) = (inches * 16) + sixteenths;

stackHeight = 10;
length = 15;
width=13;

channelLength =  stackHeight + 1;
channelWidth = length + 1;

module oval(w,h, height, center = false) {
 scale([1, h/w, 1]) cylinder(h=height, r=w, center=center);
}


shellLength = channelLength + 2;
shellWidth = channelWidth + 2;
shellDepth = width + 2;

difference () {
    // shell
    cube ([shellWidth, shellLength, shellDepth], true);
    // open top
    translate ([0,0,shellDepth / 2]) cube ([shellWidth + 2, channelLength, shellDepth], true);
    // channel
    rotate([90,0,0]) oval(channelWidth/2, width/2, channelLength, true);
        translate ([0, 0, - (shellDepth/2) + 0.5 ])
    
    rotate ([0,180,0])
        linear_extrude (1) {
            scale (.5, .5, .5)
            text(version, halign = "center", valign = "center");
        } ;
    
}