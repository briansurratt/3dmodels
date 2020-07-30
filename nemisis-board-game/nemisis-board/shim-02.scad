center = 2;

spread = 1;
rise = 1;
hieght = center + rise;
width = center + (2 * spread);
depth = center;
 
module triangle(x, y) {
    polygon ([[0,0], [x,0],[0,y]]);
}


translate([spread,0,0])  cube([center,depth,center]);

module lhs() {    
    translate([spread,depth,0]) 
        rotate([0,0,180]) 
            linear_extrude(hieght) 
                triangle(spread , depth);
}

module rhs() {
    translate([width-spread,depth,0]) 
    mirror ([0,1,0])
            linear_extrude(hieght) 
                triangle(spread, depth);
}

module top() {
    translate([width,depth,hieght - rise])
        rotate([-90,180,90])
            linear_extrude(width)
                triangle(depth, rise);
}

module leftPanel() {
    translate([spread,depth,0]) 
        rotate([0,0,180]) 
            linear_extrude(hieght - rise) 
                triangle(spread, depth);
}

module rightPanel() {
    translate([width-spread,depth,0]) 
    mirror ([0,1,0])
            linear_extrude(hieght - rise) 
                triangle(spread, depth);
}

module topPanel() {
    translate([width - spread,depth,hieght - rise])
        rotate([-90,180,90])
            linear_extrude(width - spread * 2)
                triangle(depth, rise);
}


union() {
    intersection() {
        top();
        lhs();
    }

    intersection() {
        top();
        rhs();
    }

    leftPanel();
    rightPanel();
    topPanel();
}

   //faces=[ [0,1,4],[1,2,4],[2,3,4],[3,0,4],[1,0,3],[2,1,3] ]  