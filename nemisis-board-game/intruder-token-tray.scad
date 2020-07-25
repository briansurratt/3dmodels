// 1 unit = 1/16 inch

version = "0.5.0";

discRadius = 10;
channelRadius = discRadius + 1;
trayWidth = (2 * channelRadius) + 2;
trayLength = 58;
ribHeigh = trayWidth / 2;

module rib() {
    translate ([0, 0, -(ribHeigh) / 2]) cube ([trayWidth,1, ribHeigh], true);
}

difference() { 
    cube ([trayWidth,trayLength,trayWidth], true);
    rotate ([0,90,90]) cylinder(trayLength - 2, channelRadius, channelRadius, true);
    translate ([0, 0, ribHeigh + 2]) cube ([trayWidth+3,60,trayWidth+3], true);
 translate ([0, - (trayLength / 3), - ribHeigh + 0.5])
    rotate ([0,180,0])
        linear_extrude (2) {
            scale (.5, .5, .5)
            text(version, halign = "center", valign = "center");
        } ;
}



rotate ([0,90,90]) cylinder(1, discRadius, discRadius, true);


translate ([0, (trayLength / 2) - 1 - 3, 0]) rib();  // queen & blank (2)
translate ([0, (trayLength / 2) - 1 - 7, 0]) rib();  // breeders (3)
translate ([0, (trayLength / 2) - 1 - 14, 0]) rib();  // blue creepers 
translate ([0, (trayLength / 2) - 1 - 26, 0]) rib();  // red creepers 
translate ([0, (trayLength / 2) - 1 - 37, 0]) rib();  // larva
// translate ([0, (trayLength / 2) - 1 - 53, 0]) rib();  // adults

