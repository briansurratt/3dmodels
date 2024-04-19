$fn=100;


// all measurements in mm
innerDiameter = 23.8;
wallThickenss = 0.7;
fudgeFactor = 0.25;
outerDiameter = innerDiameter + 2 * (wallThickenss + 1);
lidDepth = 2;
insertDepth = 3;
totalDepth = lidDepth + insertDepth;

ventDiameter = 3;

// lid top

difference() {

union() {
cylinder (lidDepth, d = outerDiameter);

difference() {
cylinder (totalDepth , 
            d = innerDiameter);
translate([0,0,lidDepth + fudgeFactor])
cylinder (insertDepth , d = innerDiameter - 5);
}
}


translate([0,0, -0.5])
cylinder (lidDepth + 1, d = ventDiameter);

}

