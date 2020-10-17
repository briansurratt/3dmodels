socketLength = 5; // x
socketWidth = 10; // z
socketDepth = 10; // y

verticalOffSet = 10;
horizontalOffset = 5;

holeLength = socketLength;
holeWidth = socketWidth;
holeDepth = socketDepth + 1;

difference() {
    cube ([holeLength + horizontalOffset * 2,holeDepth,socketWidth + verticalOffSet * 2]);

    union() {
    translate ([horizontalOffset,-1,verticalOffSet])
    cube ([socketLength,holeDepth + 2 ,holeWidth]);
    translate ([horizontalOffset - 1,-1,verticalOffSet - 1])
    cube ([socketLength + 2,2 ,holeWidth + 2]);
    }
}