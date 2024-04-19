$fn = 100;


outerRingDiameter = 35;
middleRingDimeter = 20;
innerRingDiameter = 6;
linear_extrude(1) { 
union() {
    
ring(outerRingDiameter);
ring(middleRingDimeter);
//ring(innerRingDiameter);

translate([-0.5, -outerRingDiameter/2, 0]) square([1, outerRingDiameter]);
translate([-outerRingDiameter/2, -0.5, 0]) square([outerRingDiameter, 1]);

}

}

module ring(dia) {

    difference() {
        circle(d=dia);
        circle(d=dia-2);
    }

}