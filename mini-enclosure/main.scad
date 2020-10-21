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

// leftRearCap();

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


translate([15, 15, 0])
railHinge();


difference() {
 linear_extrude(railLength)  railProfile();
 
 // hinge slot
 translate ([railEdgeDepth, -1,-1])
 cube([railEdgeDepth, railWidth + 2, railWidth + 1]);
 
  translate ([-1, railWidth / 2, railWidth / 2])
 rotate([0,90,0])
 cylinder (railFooterDepth , d=hingePinDimeter);
}