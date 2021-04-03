include <constants.scad>;
include <foot.scad>;
include <capture.scad>;
include <cap.scad>;
include <rhs_door.scad>;

module versionNumber(version) {
    linear_extrude (1) {
    text(version, , 6, halign = "center", valign = "center");
    }
}


//leftFrontFoot();
//rightFrontFoot();

//rearFoot();
//rearFoot();
//leftRearCap();

footTopWithLip();
//genericCap();


//translate([15, 15, 0]) railHinge();


module railWIP() {

difference() {

    union() {
        translate([0, railWidth / 2, 0])
        cylinder (railDepth , d=railWidth);
        translate([0,0, railDepth])
        rotate([0,90,0])
        linear_extrude(railLength)  railProfile();
        #cube([3.5, railWidth, railEdgeDepth]);
    }

    // pin shaft
    translate([0, railWidth / 2, 0])
        cylinder (railFooterDepth + 4 , d=hingePinDimeter); 
    
    // slot for hinge plate
    translate([-railWidth /2 - 2, -1, railEdgeDepth])
    cube([railWidth + 2, railWidth + 2, railHingeAllowance]);
    
}

}

