include <constants.scad>;
include <foot.scad>;
include <capture.scad>;
include <cap.scad>;

module versionNumber(version) {
    linear_extrude (1) {
    text(version, , 6, halign = "center", valign = "center");
    }
}


//leftFrontFoot();
//rightFrontFoot();

//rearFoot();
//rearFoot();

rearCap();

