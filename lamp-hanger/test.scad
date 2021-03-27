include <constants.scad>




//railTest();


echo (bridgingWidth);


difference() {
    cube ([shellW, shellL, shellH], true);
    translate ([shell,0, 0])
    cube ([bodyVoidW+ shell, bodyVoidL, bodyVoidH], true);
    outerWindow() ;
    innerWindow();
}


module outerWindow() {

    sideVoidH = bodyHeight / 2;
    sideVoidW = bodyWidht - 35;

    translate([sideVoidH / 2 + 11, -5, sideVoidH/2]) 
    cube ([sideVoidW, shellL , sideVoidH], true);

}

module innerWindow() {

    innerWing = 4;

    innerWingVoidH = shellH - innerWing * 2 - allowence - shell * 2;

    translate([shell + 1, bodyVoidL / 2, 0]) 
    cube([bodyVoidW, 10, innerWingVoidH], true);
    
}

module railTest() {

    railVoidWidth = railSide +  allowence  ;
    railEnclosureWidth = shell * 2 + railVoidWidth;

    difference() {
        cube ([railEnclosureWidth, railEnclosureWidth, 25]);
        translate ([-1, shell, shell])
        cube ([railEnclosureWidth + 2, railVoidWidth, 27]);
    }

}