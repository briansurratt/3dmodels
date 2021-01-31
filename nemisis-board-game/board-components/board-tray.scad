include <modules.scad>;
include <shared-variables.scad>;
include <honeycomb.scad>;


module referenceTile() {
 translate([0,0,baseHeight]) 
    linear_extrude( tileThickness)  
        regularPolygon(6, tileDiameter / 2);
}

// tile tray

module trayWithWalls() {
    
    difference() {
        // base of the tray and walls
        linear_extrude(baseHeight + trayWallHeight) regularPolygon(6, trayRadius);

        // take out space for tile
        translate ([0,0,baseHeight])  
            linear_extrude( trayWallHeight + 1) // extra for clean negative 
                regularPolygon(6, trayVoidRadius);
    }
}

doorVoidThickness = mediumWall + 2;

// #referenceTile();

difference() {
    trayWithWalls();
    doorwayArray();
    magHoleArray();
    versionStamp("1.2.2");
    doorMarker();
    
}

module doorMarker() {
    
    pathRadius = -trayWidth + 5;

    rotate(30)
    translate([
        pathRadius*cos(60),
        pathRadius*sin(60),
        baseHeight - 0.5])
    linear_extrude (1)
    regularPolygon(3, 3);

}

module doorway() {

    translate([
            hallVoidWidth/2,
            -doorVoidThickness / 2,
            baseHeight
        ]) 
        rotate(90)
            cube([doorVoidThickness, hallVoidWidth , trayWallHeight + 1 ]);
    
}

module doorwayArray() {
    num = 6;
    pathRadius = (tileWidth / 2) + (doorVoidThickness / 2);
    
    for (i=[1:num])  {
        
        angle = (i * (360/num)) + 30;
        
            translate(
                [
                    pathRadius*cos(angle),
                    pathRadius*sin(angle) ,
                    0
                ]) 
            rotate((i-1)*60)    
            doorway();
    
        }
    
}