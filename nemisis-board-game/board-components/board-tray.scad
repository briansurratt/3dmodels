include <modules.scad>;
include <shared-variables.scad>;
include <honeycomb.scad>;


module referenceTile() {
 translate([0,0,baseHeight]) 
    linear_extrude( tileThickness)  
        regularPolygon(6, tileDiameter / 2);
}

// tile tray

trayDiameter = tileDiameter + mediumWall * 2 + margin * 2;
trayRadius = trayDiameter / 2;

trayVoidRadius = trayRadius -  mediumWall ;

module trayWithWalls() {
    
    difference() {
        // base of the tray and walls
        linear_extrude(baseHeight + trayWallHeight) regularPolygon(6, trayRadius);

        // take out space for tile
        translate ([0,0,baseHeight])  
            linear_extrude( trayWallHeight + 1) // extra for clean negative 
                regularPolygon(6, trayVoidRadius);
        // translate ([0,0,-topSurfaceThickness]) 
        //     baseHoneycomb();
    }
}

doorVoidThickness = mediumWall + 2;

// difference() {
    trayWithWalls();
    doorwayArray();
    // doorway();
// }




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
            #doorway();
    
        }
    
}







module circularArray() {
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
            #children(0);
    
        }
}


module baseHoneycomb() {
    
    radius = trayRadius - thickWall;
            
    difference() {
        linear_extrude(baseHeight) 
            regularPolygon(6, radius);
    
        linear_extrude(baseHeight)
            translate([-radius,-radius,0]) {
                honeycomb(
                x = radius * 2, 
                y = radius * 2, 
                dia = 5, 
                wall = thinWall
                );
            }

    }
    
}