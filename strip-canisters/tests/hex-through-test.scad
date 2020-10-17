$fn = 100;

sides = 6;
shell = 2;
innerRadius = 27/2;
outerRadius = innerRadius + shell;
height = 20;
throughRadius = outerRadius / 2;
throughLength = outerRadius * 2.25;

 difference() {
     cylinder(height, r=outerRadius);
    cylinder(height + 4, r=innerRadius);
     
    translate([throughLength / -2,0,height/2]) {
        rotate([0,90,0]) {
            throughPolygon();
        }
    }
    
    translate([0,throughLength / -2,height/2]) {
        rotate([0,90,90]) {
            throughPolygon();
        }
    }
    
 

 }

 module regular_polygon(order = 4, r=1){
     angles=[ for (i = [0:order-1]) i*(360/order) ];
     coords=[ for (th=angles) [r*cos(th), r*sin(th)] ];
     polygon(coords);
 }
 
 

 
 module throughPolygon() {
         
     linear_extrude (throughLength) {
     rotate([0, 0,180/sides]) {         
        regular_polygon(sides,throughRadius);
              }
     }
 }