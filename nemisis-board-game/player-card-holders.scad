version = "0.5.0";

function toUnits(inches=0, sixteenths=0) = (inches * 16) + sixteenths;

channelLength = toUnits(8,4);
channelWidth = toUnits(1,9);
channelDepth = toUnits(1,12);

shellLength = channelLength + 2;
shellWidth = channelWidth + 2;
shellDepth = channelDepth + 1;

difference() {
  cube ([shellWidth, shellLength, shellDepth], true);
  translate ([0,0, 1]) cube ([channelWidth, channelLength, channelDepth], true);
    translate ([0,0, 3 * shellDepth / 4]) cube ([shellWidth+2, channelLength, shellDepth ], true);
        translate ([0, 0, - (shellDepth/2) + 0.5 ])
        rotate ([0,180,270])
            linear_extrude (1) {
                scale (.5, .5, .5)
                text(version, halign = "center", valign = "center");
            } ;
}