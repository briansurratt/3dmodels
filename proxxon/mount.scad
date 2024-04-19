include<constants.scad>;

module buildMount() {

    interiorZ = 4.6;
    interiorY = 14.4;
    armWallThickness = 1;

    centerHeight = interiorZ+armWallThickness;


    cube([totalWidth, interiorY, interiorZ]);

    // middle
    translate([0,(interiorY-apperature)/2,0]) 
    cube([totalWidth, apperature, centerHeight]);
    
    // crown
    translate([totalWidth,(interiorY-apperature)/2,centerHeight]) 
    mirror([0,0,1]) 
    rotate([-90,0,90]) {

        linear_extrude(totalWidth) {
        polygon([
            [0,0],
            [apperature/2,apperature/2],
            [apperature,0]
        ]);
        }
    }
    
    
    translate([pinInset,interiorY/2,centerHeight]) 
    cylinder(h = pinHeight + apperature/2, r = pinHoleRadius);

    translate([totalWidth - pinInset,interiorY/2,centerHeight]) 
    cylinder(h = pinHeight + apperature/2, r = pinHoleRadius);

}


difference () {
    buildMount();
    versionText();
}



module versionText() {
    
    versionString = "1.0.4";
    
    translate([totalWidth/2,6,-0.5]){ 
        linear_extrude(height = 1) {
            mirror([1,0,0]) 
        text(text=versionString, size = 3, halign = "center");
        }
    }
}






