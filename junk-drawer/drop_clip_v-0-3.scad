$fn=50;

largeWidth = 8;
thinWidth = 5;

shell = 1;
baseShell = 1;
depth = 10;

largeBaseWidth = largeWidth + 2 * shell;
thinBaseWidth = thinWidth + 2 * shell;

legLength = 20;
totalLenght = 2* legLength + largeBaseWidth;

//wall(20);
//rib();

module myOwnKindOfBrim() {
polygon (
        [
            [0,0],
            [totalLenght,0],
            [totalLenght,thinBaseWidth],
//            [legLength + largeBaseWidth ,thinBaseWidth],
            [legLength + largeBaseWidth,legLength + largeBaseWidth],
            [legLength,legLength + largeBaseWidth],
//            [legLength,largeBaseWidth],
            [0,largeBaseWidth]
        ]
    );
}

// rightHandClip();
leftHandClip();

module rightHandClip() {
    mirror([1,0,0]) leftHandClip() ;
}



module rib() {
    
    translate ([-shell, 0,0 ]) cylinder(depth,shell , shell * .5);
    
}

module rib2()
{
    rotate([90,0,0])
    linear_extrude(shell)
        polygon(
        [
            [0,0],
            [- shell * 2,0],
            [- shell * 2,shell],
            [- shell ,depth],
            [0,depth]
        ]
        ) ;
}

module leftHandClip() {
    linear_extrude(.25)
   myOwnKindOfBrim();
    
    // base
    linear_extrude(baseShell)
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
    
    translate([totalLenght, shell,0]) mirror([0,1,0]) rotate([0,0,90]) wall(totalLenght);
    translate([legLength + shell, largeBaseWidth - shell,0]) rotate([0,0,90]) legWall();
    translate([2* legLength + largeBaseWidth, thinBaseWidth - shell,0]) rotate([0,0,90]) legWall();
    translate([legLength + shell, largeBaseWidth - shell, 0]) mirror([1,0,0]) legWall();
    translate([legLength+ largeBaseWidth - shell, thinBaseWidth - shell, 0]) wall(largeBaseWidth - thinBaseWidth + legLength + shell);   

}

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
    
    union() { 
        cube([shell, length, depth]);
        
        
        gap = 15;
        
        steps = floor(length / gap);
        remain =  length - (gap * steps);
        offset = floor(remain / 2);
  //      echo(gap);
   //     echo(steps);
    //    echo(remain);
     //   echo(offset);
        for (a =[1:steps ]) {
            translate([shell, (a * gap) - offset / 2  -2 ,0])  rib();
        }
    }
    
}

module largeBase() {
    base(largeBaseWidth);
}


module thinBase() {
    base(thinBaseWidth);
}