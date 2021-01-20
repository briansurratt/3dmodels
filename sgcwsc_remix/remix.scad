$fn = 100;


module importLid() {
    translate([0,0,72.7])
    mirror([0,0,1])
    import("./source/silicatop.stl", , convexity=10);
}

module holes() {
    holeArray();
    holeArray(num = 20, pathRadius = 14);

//holeArray(num = 25, pathRadius = 14);
//holeArray(num = 35, pathRadius = 21);

}

module buildLid() {


    difference() {
        
        union() {
            importLid(); 
            cylinder(3.0, r=20);
        }
        holes();
    }

}


module holeArray(num = 30, pathRadius = 17.5) {
    for (i=[1:num])  {
        translate([pathRadius*cos(i*(360/num)),pathRadius*sin(i*(360/num)),-4])
        cylinder(10, d=2);
    }
}


module importBody() {
    translate([0,0,1.6])
    import("./source/silicabottom.stl", , convexity=3);
}


module buildBody() {
    difference() {
        union() {
            importBody();
            cylinder(3.0, r=20);
        }
        holes();
        translate([0,0,-1])
            cylinder(5.0, r=10);
    } 
}

buildBody();
//buildLid();