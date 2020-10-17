socketLength = 6; // x
socketWidth = 12; // z
socketDepth = 9; // y

verticalOffSet = 3;
horizontalOffset = 2;

holeLength = socketLength; // x
holeWidth = socketWidth; // z
holeDepth = socketDepth + 1; // y

vertLip = 2;
horzLip = 1;

bodyLength = holeLength + horizontalOffset * 2; // x
bodyWidth = holeWidth + verticalOffSet; // z
bodyDepth = holeDepth; // y

//translate ([20,20,0])
difference() {
    cube ([bodyLength,bodyDepth,bodyWidth]);

    union() {
        translate ([horizontalOffset,-1,verticalOffSet])
        cube ([socketLength,holeDepth + 2 ,holeWidth]);
        translate ([horizontalOffset - horzLip,-1,verticalOffSet - vertLip])
        cube ([socketLength + (horzLip * 2),2 ,holeWidth + (2 * vertLip)]);
    }
}

runner();

translate([bodyLength,0,0])
mirror([1,0,0])
    runner();

module runner() {
    linear_extrude(bodyWidth)
        translate([0,3,0])
            rotate([0,0,90])
                polygon (
                    [
                        [0,0],
                        [1,1],
                        [3,1],
                        [4,0],
                        [4,-1],
                        [0,-1]
                ]);
}

