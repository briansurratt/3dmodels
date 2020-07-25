// 1 unit = 1/16"

version = "0.5.0";

function toUnits(inches, sixteenths) = (inches * 16) + sixteenths;

slots = [2,2,1,1,1,1,1,1,8,8,8,5];
cardWidth = toUnits(1, 12);
cardLength = toUnits(2, 10);

channelWidth = cardLength + 1;
channelHeight = cardWidth + 1;
channelLength = 50 ;

trayWidth = channelWidth + 2;
trayHeight = channelHeight + 2;
trayLength = channelLength + 2;

ribHeigh = (trayHeight / 2) - 2;

endcapHeight = cardWidth + 1;
endcapThickness = 2;



module rib() {
    translate ([0, 0, -(ribHeigh) / 2]) cube ([trayWidth,1, ribHeigh], true);
}

module endCap() {
    cube ([trayWidth, endcapThickness, endcapHeight], true);
}

%cube([cardLength, 0.5, cardWidth], true); // sample card

// recursive sum function on an array
// v = vector
// i = current index
// e = end index
// r = return value
function sum(v, i=0, e=0, r=0) = i<=e ? sum(v, i+1, e, r+v[i]) : r;

module layoutRibs() {
    for (i = [0: len(slots) - 1] ) {
        y = sum(slots, 0, i);
        translate ([0, - (channelLength / 2) + 1,-1]) translate ([0,y + i,-1]) rib();
    };
}

difference() {
    cube ([trayWidth, trayLength, trayHeight], true);
    cube ([channelWidth, channelLength, channelHeight], true);
    translate ([0, 0, trayHeight / 2 ]) cube ([trayWidth + 2, trayLength+ 2, trayHeight+2], true);
    translate ([0, -2, - ribHeigh - 1.5])
        rotate ([0,180,0])
            linear_extrude (2) {
                scale (.5, .5, .5)
                text(version, halign = "center", valign = "center");
            } ;
};



translate ([0, trayLength / 2, -1] ) endCap();
translate ([0, -(trayLength / 2), -1] ) endCap();



layoutRibs();
