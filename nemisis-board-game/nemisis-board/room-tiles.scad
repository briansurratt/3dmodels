version = "0.5.0";

function toUnits(inches, sixteenths) = (inches * 16) + sixteenths;

hexCrossVertex = toUnits(3,7);
channelRadius = (hexCrossVertex / 2) + 1;
stackDepth = toUnits(1,12);
shellWidth = (channelRadius * 2) - 4;
shellHeight = (channelRadius * 2) + 2;
shellDepth = stackDepth + 2;

difference() {
    // shell
    translate ([0 ,0, (shellDepth / 2) - 1]) rotate (30) cube ([shellWidth, shellHeight,  shellDepth], true);
    // channel
    linear_extrude(stackDepth + 2) circle(channelRadius, $fn=6);
    // finger slots
    translate ([0 ,0, (shellDepth / 2) ]) rotate (30) cube ([shellWidth + 2, 12, shellDepth], true);
    // version
        translate ([0, 0, - 0.5])
        rotate ([0,180,0])
            linear_extrude (1) {
                scale (.5, .5, .5)
                text(version, halign = "center", valign = "center");
            } ;
} 
 
 



