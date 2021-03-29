include <constants.scad>
include <honeycomb.scad>

// print volume
// translate([-90,0,0]) %cube ([180, 180, 180], true);

// original shell
//%cube ([shellW, shellL, shellH], true);


// validation
// base 
//  %translate([shelfWidth/2 - foundationW /2, 0,shell/2]) 
//  cube([foundationW, foundationL, shell], true);
// receiver
// translate([shelfWidth/2 - foundationW + receiverWidth /2, 0,shell/2]) 
// #cube ([receiverWidth, , foundationL, shellH], true);

// mock shelf
// %translate([0,0,railSide/2]) cube ([shelfWidth, 120, railSide], true);

#modifiedRailClip();
// railClip();
// translate([receiverW + allowence, -foundationL/2, shellH - 2]) support();

core();

module core() {

    difference() {
        union() {
            translate([foundationW/2,0,shell/2])
            cube([foundationW, foundationL, shell], true);
            translate([receiverW/2,0,shellH/2])
            cube ([receiverW, , foundationL, shellH], true);
            lowerRibs();
            upperRibs();
            diagShell();
        }
        translate([receiverW / 2 - 1,0,rcvrVoidH/2+shell])
        cube([receiverW+ 2, rcvrVoidL, rcvrVoidH], true);
        innerWindow();
        diagVoid();

    }

}


supportBlade();

module supportBlade() {

    xDim = bodyVoidH;
    yDim = foundationL;

    h1 = foundationW - receiverW + allowence;
    h2 = foundationW - receiverW - shellH + shell * 2+ allowence;



    translate([foundationW - shell / 2, 0, railSide + 3 * shell + allowence])
    rotate([0, -90, 0])

    union() { 

        translate([1/2 * xDim,shell / 2,-shell/2])
        rotate([90,0,0])
        linear_extrude(shell)
        polygon(points=[
            [0,0],
            [-xDim,0],
            [-xDim,h2],
            [0,h1]
            ]
        );

        cube([xDim, yDim, shell], true);

        translate([-2 * shell, -yDim/2, 0])
        rotate([90,0,90])
        linear_extrude(shell)
        polygon(points=[
            [0,0],
            [yDim,0],
            [yDim,shell],
            [yDim/2,xDim]
        ]
        );

    }

}

module upperRibs() {
    // translate([-receiverW,0,-shell])
    ribLen = foundationW - foundationL + xFudge;
    translate([0,0, -shell])
    union() {
        cube([ribLen, shell, shell * 2]);
        translate([0,ribOffset,0]) cube([ribLen, shell, shell * 2]);
        translate([0,-ribOffset,0]) cube([ribLen, shell, shell * 2]);
    }
}

module lowerRibs() {
    rib();
    translate([0,ribOffset,0]) rib();
    translate([0,-ribOffset,0]) rib();
}

module rib(ribLen = foundationW - shellH) {
    translate([foundationW - ribLen,-shell/2,0])
    cube([ribLen, shell, shell * 2]);
}

module support() {

    l = foundationL;
    w = foundationW - receiverW - allowence;
    h = 2;

 difference() {
    cube([w, l, h ]);
    translate([1, 1, 0])
    cube([w - 2, l -2, h ]);
 }

     linear_extrude(h)
     honeycomb(w,l, 4, 1);

}  // end support()



module innerWindow() {

    innerWing = 4;

    innerWingVoidH = shellH - innerWing * 2 - allowence - shell * 2;

    windowW = receiverW - (xFudge * 3/4) - tuberInset + 2 ;

    translate([windowW/2-1, bodyVoidL / 2, (innerWingVoidH / 2) + (shellH - innerWingVoidH) / 2]) 
    cube([windowW, 10, innerWingVoidH], true);
    
}

module modifiedRailClip() {

    internalHeight = railSide +  allowence;
    externalHeight = internalHeight + 2 * shell;

    mod = wireDia;
    inset = wireAllowance;

    translate([foundationW,0,shell])
    mirror([1,0,0])
    rotate([-90, 0, 0])
    translate([0,0,-foundationL/2])

    linear_extrude(foundationL)
    polygon(
        [
            [0,0],
            [0, externalHeight + mod],
            [clipWidth, externalHeight + mod],
            [clipWidth,externalHeight - mod],
            [inset + shell,externalHeight - mod],
            [inset + shell,externalHeight+ mod-shell],
            [shell,externalHeight+ mod-shell],
            [shell,shell],
            [clipWidth,shell],
            [clipWidth,0]
        ]
    );


}

module railClip() {

    internalHeight = railSide +  allowence;
    externalHeight = internalHeight + 2 * shell;

    l = foundationL;

    translate([foundationW-clipWidth,-foundationL/2,-externalHeight + shell])
    difference() {
        cube ([clipWidth, l, externalHeight]);
        translate ([-shell, 0, shell])
        cube ([clipWidth, l , internalHeight]);
    }

}

module diagShell() {
    
    side = shellH;

    translate([rcvrVoidW + side + shell,-shellL/2,0])
    rotate([0, -90, 0]) {
    
        rotate([180, -90, 90]) {
            linear_extrude(shellL)
            polygon(points=
            [
                [0,0],
                [side + shell,0],
                [side + shell,side],
                [side,side]
            ]
            );    
        }

    }


}


module diagVoid() {
    
    translate([rcvrVoidW,-bodyVoidL/2,shell])
    rotate([180, -90, 90]) {
    linear_extrude(bodyVoidL)
    polygon(points=
    [
        [0,0],
        [bodyVoidH,0],
        [0,bodyVoidH]
    ]
    );    
    }


}


