largeWidth = 8;
thinWidth = 5;

shell = 2;
depth = 10;

//largeBaseWidth = largeWidth ;
//thinBaseWidth = thinWidth ;

 largeBaseWidth = largeWidth + 2 * shell;
 thinBaseWidth = thinWidth + 2 * shell;



legLength = 20;


totalLenght = 2* legLength + largeBaseWidth;

linear_extrude(shell)
polygon (
    [
        [0,0],
        [totalLenght,0],
        [totalLenght,thinBaseWidth],
        [legLength + largeBaseWidth ,thinBaseWidth],
        [legLength + largeBaseWidth,legLength + largeBaseWidth],
        [legLength,legLength + largeBaseWidth],
        [legLength,largeBaseWidth],
        [0,largeBaseWidth]
    ]
);

translate([totalLenght, 0,0]) rotate([0,0,90]) wall(totalLenght);
translate([legLength + 2, largeBaseWidth - shell,0]) rotate([0,0,90]) legWall();
translate([2* legLength + largeBaseWidth, thinBaseWidth - shell,0]) rotate([0,0,90]) legWall();
translate([legLength, largeBaseWidth - shell, 0])legWall();

#translate([legLength+ largeBaseWidth - shell, thinBaseWidth - shell, 0]) wall(largeBaseWidth - thinBaseWidth + legLength + shell);




module legWall() {
    wall(legLength + shell);
}

module base(width) {
    union() { 
        cube([width, legLength + shell, shell]);
        //translate([0, shell,0]) wall(legLength);
        //translate([width - shell, shell,0]) wall(legLength);
    }
}


module wall(length) {
    cube([shell, length, depth]);
}

module largeBase() {
    base(largeBaseWidth);
}


module thinBase() {
    base(thinBaseWidth);
}