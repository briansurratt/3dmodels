include <fourway.scad>;
include <couple.scad>;
include <tee.scad>;
include <corner.scad>;

$fn = 25;

// millimeters per inch
ratio = 25.4;

materialWidth = 1/8 * ratio;
materialHeight = 27.5;
shellWidth = 1.5;

margin = 0.25;
totalWidth = 2*shellWidth + materialWidth + margin;

wallHeight = materialHeight + shellWidth;
slotDepth = wallHeight / 2;

wallShift = (materialWidth + shellWidth + margin)/2;

pinHoleDia = materialWidth + margin;
pinLenth = totalWidth + 1;
pinHeight = shellWidth + (materialHeight/2);


shortCornerArm = slotDepth + shellWidth * 2 + materialWidth + margin;
longCornerArm = wallHeight + shellWidth * 2 + materialWidth + margin;

// mock wall
translate([0, 0, shellWidth + materialHeight/2])
%cube([50,materialWidth,materialHeight], true);

module wall(len = 25) {
    translate([0,0,wallHeight/2])
    cube([len, shellWidth, wallHeight], true);
}

module pinHole() {
    translate([0, 0, pinHeight]) 
    rotate([90, 0, 0]) 
    cylinder(d=pinHoleDia, h=pinLenth, center=true);
}

// buttCouple();


module bottom(width = totalWidth, lenght = 10) {
    translate([0,0,shellWidth/2])
    cube([lenght,width,shellWidth], true);
}


// couple();
// fourWay();
// tee();
//corner();

outsideCorner();

