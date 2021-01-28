 module regularPolygon(order = 4, r=1){
     angles=[ for (i = [0:order-1]) i*(360/order) ];
     coords=[ for (th=angles) [r*cos(th), r*sin(th)] ];
     polygon(coords);
 }

 module magHole() {
    
    magHoleThickness = magnetThickness + magnetMargin;
    magHoleDiameter = magnetDia+ magnetMargin;

    translate ([-magHoleThickness/2,0,0])
        rotate([0,0,90])
            translate ([0,0,magHoleDiameter/2 + 1])
                rotate([90,0,0])
    
                    union() {

                        cylinder(magHoleThickness, d = magHoleDiameter);

                        translate([-magHoleDiameter/2,0,0]) {
                            cube([magHoleDiameter, magHoleDiameter + baseHeight, magHoleThickness]);
                        }
                        
                    }

}