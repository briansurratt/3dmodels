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




railClip();
translate([receiverW + allowence, -foundationL/2, shellH - 2]) support();

ribOffset = foundationL/2 * 2/3;



difference() {
    union() {
        translate([foundationW/2,0,shell/2])
        cube([foundationW, foundationL, shell], true);
        translate([receiverW/2,0,shellH/2])
        cube ([receiverW, , foundationL, shellH], true);
        ribs();
        diagShell();
    }
    translate([receiverW / 2 - 1,0,rcvrVoidH/2+shell])
    cube([receiverW+ 2, rcvrVoidL, rcvrVoidH], true);
    innerWindow();
    diagVoid();

}


module ribs() {
    rib();
    translate([0,ribOffset,0]) rib();
    translate([0,-ribOffset,0]) rib();
}

module rib() {
    translate([receiverW + shell,-shell/2,0])
    cube([foundationW-receiverW-shell, shell, shell * 2]);
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

    windowW = receiverW - tuberInset + 1;

    translate([windowW/2-1, bodyVoidL / 2, (innerWingVoidH / 2) + (shellH - innerWingVoidH) / 2]) 
    cube([windowW, 10, innerWingVoidH], true);
    
}

module railClip() {

    ih = railSide +  allowence;
    eh = ih + 2 * shell;

    w = 25;
    l = foundationL;

    railVoidWidth = railSide +  allowence  ;
    railEnclosureWidth = shell * 2 + railVoidWidth;


    translate([foundationW-w,-foundationL/2,-eh + shell])
    difference() {
        cube ([w, l, eh]);
        translate ([-shell, 0, shell])
        cube ([w, l , ih]);
    }

}


module diagShell() {
    
    ribHeight = shellH;

    translate([rcvrVoidW,-shellL/2,0])

    rotate([180, -90, 90]) {
        linear_extrude(shellL)
        polygon(points=
        [
            [0,0],
            [ribHeight,0],
            [0,ribHeight]
        ]
        );    
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


