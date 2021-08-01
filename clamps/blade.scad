include <variables.scad>;

module blade() {
        
    polygon(points=[
        [0,0],
        [bladeHeight - bladeHeadHeight, 0],
        [bladeHeight - bladeHeadHeight / 2, - bladeHeadExt],
        [bladeHeight,0],
        [bladeHeight ,bladeThickness],
        [bladeHeight - bladeHeadHeight / 2, bladeThickness + bladeHeadExt],
        [bladeHeight - bladeHeadHeight, bladeThickness],
        [0, bladeThickness]
    ]);

}

module bladeReceiver() {

        polygon(points=[
        [0,0 - bladeHeadExt],
        [bladeHeight - bladeHeadHeight / 2 - margin, 0 - bladeHeadExt],
        [bladeHeight - bladeHeadHeight / 2, - 1 - margin],
        [bladeHeight,0 - margin],
        [bladeHeight ,bladeThickness + margin],
        [bladeHeight - bladeHeadHeight / 2, bladeThickness + 1 + margin],
        [bladeHeight - bladeHeadHeight / 2 - margin, bladeThickness+ bladeHeadExt],
        [0, bladeThickness+ bladeHeadExt]
    ]);

}


translate ([0, 20, 0]) 
{
    linear_extrude(height=bladeWidth, center=false, convexity=10, twist=0) {
        blade();
    }
}

difference() {

translate([3,-bladeHeight/2 + 1,-bladeWidth/2]) {
    cube(size=[bladeHeight - 2, bladeHeight, bladeHeight], center=false);
 }

linear_extrude(height=bladeWidth, center=false, convexity=10, twist=0) { 
    bladeReceiver();
}
}

