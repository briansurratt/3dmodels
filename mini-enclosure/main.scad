include <constants.scad>;
include <foot.scad>;
include <capture.scad>;

module versionNumber(version) {
    linear_extrude (1) {
    text(version, , 6, halign = "center", valign = "center");
    }
}


//leftFrontFoot();
//rightFrontFoot();

//rearFoot();
//rearFoot();

//translate ([-legSide/2, -legSide/2,27])
//#cube ([legSide, legSide, 5]);


genericFootBottom();