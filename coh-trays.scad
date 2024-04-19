baseHeight = 2;
wallHeight = 3;
wallThickness = 2;

totalHeight = baseHeight + wallHeight;

margin = 0.25;

damageCubeSide = 10;
featureCubeSide = 14;


numberOfDamageCubes = 5;
numberOfFeatureCubes = 3;

vehicleTrayLength = 60;
vehicleTrayWidth = 35;




damageTrayLength = numberOfDamageCubes * damageCubeSide + margin;
damageTrayWidth = damageCubeSide + margin;

featureTrayLength = numberOfFeatureCubes * featureCubeSide + margin;
featureTrayWidth = featureCubeSide + margin;

hexRadius = 85/2;
insetHexRadius = hexRadius - wallThickness;
insetHeight = wallHeight + 1;


module regularPolygon(order = 6, r=1, h=1){
     angles=[ for (i = [0:order-1]) i*(360/order) ];
     coords=[ for (th=angles) [r*cos(th), r*sin(th)] ];
          linear_extrude(h) polygon(coords);
 }
 
 
//hexTray();

module hexTray() {
    difference() {
    regularPolygon(6, hexRadius, totalHeight);
    translate([0,0, baseHeight])
        regularPolygon(6, insetHexRadius, insetHeight);
}
}

//baseHeight + 

module tray(length = 1, width = 1) {
    
    wallLenght = length + 2 * wallThickness;
    wallWidth = width + 2 * wallThickness;
    
    difference() {
        translate([0,0,(totalHeight/2)])
        cube([wallLenght, wallWidth, totalHeight ], true);
        translate([0,0,baseHeight + (insetHeight/2)])
        cube([length, width, insetHeight ], true);
    }

    
}

translate([0,(vehicleTrayWidth /2 + featureTrayWidth/2 + wallThickness),0])
tray(featureTrayLength, featureTrayWidth);

translate([0,-1 * (vehicleTrayWidth /2 + damageTrayWidth/2 + wallThickness),0])
tray(damageTrayLength, damageTrayWidth);

#tray(vehicleTrayLength, vehicleTrayWidth);