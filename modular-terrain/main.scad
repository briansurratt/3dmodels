$fn = 25;

multiplier = 25.4;

side = 6 * multiplier;
holeDiameter = 0.0625 * multiplier ; // 1/16 inch
holeOffSet = 1 * multiplier;
egedAllowance = holeOffSet / 2;

faceDepth = 0.125 * multiplier;
faceWidth = holeOffSet * 2/3;
lipDepth = faceDepth * 2.5;
lipWidth = 0.125 * multiplier;
holeHeight = faceDepth * 2;

module corner(depth, p, w) {

    linear_extrude(depth) {
        polygon(points=
        [
            [0,0],
            [p + side,0],
            [p + side,w],
            [p + w,p + w],
            [p + w,p +side],
            [0,p +side]
            ]);
    }
}

difference() {
    
union() {
    corner(faceDepth, lipWidth, faceWidth);
    corner(lipDepth, 0, lipWidth);
}

    theHole(lipWidth + egedAllowance, lipWidth + egedAllowance);
    theHole(lipWidth + egedAllowance, lipWidth + side - egedAllowance);
    theHole(lipWidth + side - egedAllowance, lipWidth + egedAllowance);

}

module theHole(x,y) {
    translate([x, y, holeHeight / 4]) 
    cylinder(d=holeDiameter, h=holeHeight, center=true);
}
