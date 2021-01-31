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
    roomNumberRelief();
    // floorTextureArray();
}

roomNumber(2);    

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

module roomNumberRelief() {
    translate([0,0, baseHeight - 0.5])
    linear_extrude(1)
    regularPolygon(6, r=roomNumberSize + 1);
}

module roomNumber(n = 1) {
    translate([-roomNumberSize/2,-roomNumberSize/2, baseHeight - 1])
    linear_extrude(1)
    text(str(n), font = "Arial Black:style=Bold", size=roomNumberSize);
}

module floorTextureArray() {
    circularArray(roomNumberSize + 2) 
        floorTexture();
}

module floorTexture() {

    w1 = 7;
    w2 = 25;
    l = 25;

    translate([0,0, baseHeight - 0.5])

    linear_extrude(1)
    // square(size=[7, 7], center=true);
    
    polygon(
        [
            [w1/2, 0],
            [-w1/2, 0],
            [-w2/2, l],
            [w2/2, l]
        ]
    );

}
