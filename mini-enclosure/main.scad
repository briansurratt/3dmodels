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


genericCap();


railEdgeDepth = 2;
railHingeAllowance = railEdgeDepth + 1;

railFooterDepth = railEdgeDepth * 2 + railHingeAllowance; // the base of the rail, below the plexi
railWallDepth = 2;
railDepth = railFooterDepth + railWallDepth; // overall depth of the rail
railShellThickness = 2; // thickness of the rail walls
railWidth = railShellThickness * 2 + plexiThickness;
railLength = 10;

hingeLength = railWidth * 2 + 2;
hingePinDimeter = 2;


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

