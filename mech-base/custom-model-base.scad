$fn = 200;


innerDiameter = 119;

edgeDepth = 5;

diameter = innerDiameter + 2 * edgeDepth;

baseHieght = 3;

lipHieght = 4;

slotWidth = 10;
slotDepth = edgeDepth;
slotOffset = (diameter /2)- slotDepth;

//cylinder(baseHieght, d = diameter, center = true);

    ringOverallHeight = 9;
    ringInteriorHeight = ringOverallHeight - 2;
module verticalRing() {
    


//    rotate_extrude(angle = 360, convexity = 2)
    translate([-diameter/2, 0,0])
    polygon (
    [
    [0,0],
    [0,10],
    [2,baseHieght + ringOverallHeight],
    [4,baseHieght + ringOverallHeight],
    [4,baseHieght + ringInteriorHeight],
    [5,10],
    [5,0]
    ]
    );
    
}


 //verticalRing();
simpleRing();
// mirror([0,0,1]) capRing();

module simpleRing() {
    rotate_extrude(angle = 360, convexity = 2)
translate([-diameter/2 + 0.125 + 4, baseHieght + ringInteriorHeight,0])
polygon([
    [0,0],
    [0,2],
    [1,2],
    [2,1],
    [2,0]
    ]);

}

module capRing () {
    rotate_extrude(angle = 360, convexity = 2)
translate([-diameter/2 + 0.25 + 4, 0,0])
polygon(
[
[0,0.25],
[1,0.25],
[1,2],
[3,2],
[2,4],
[-0.25, 4],
[-2.25, 2],
[0,2]
]
);
}