//$fn = 200;
$fn = 20;

radius = 40;
height = 5;

grateWidth = 1;
grateHeight = grateWidth + 1;
grateGap = 3;
grateDepth = radius * 2;

totalHeight = height + grateHeight - 1;

edgeLip = 2;



perBar = grateGap + grateWidth;

numberOfBars = grateDepth / perBar;


cylinder(height, r = radius);
translate([0, 0,height - 1]) 
   croppedGrate();
edge();



module edge() {

    rotate_extrude(angle = 360, convexity = 10) 
    translate([radius - 1, 0,0]) 
polygon(
[

    [0,0],
    [0,totalHeight],
    [edgeLip, totalHeight],
    [totalHeight, edgeLip],
    [totalHeight, 0]
]
    );
        
}

module croppedGrate() {
    intersection() {
        cylinder(grateHeight, r = radius);
        translate([-radius, -radius,0]) 
            grate();
    }
}

module grate() {
        
    union() {
        
        // this makes the hash pattern of the grating
            bars();
            translate([grateDepth, 0,0]) 
                rotate([0,0,90]) 
                    bars();
    }
    
}

module bars() {
    for (i = [0:numberOfBars]) {
        translate([i * perBar, 0, 0])
            cube ([grateWidth, grateDepth , grateHeight]);
    }
}

