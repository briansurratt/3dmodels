core = 2;

spread = 1;
rise = 1;
height = core + rise;
width = core + (2 * spread);
depth = core;
 
intersection() {
    linear_extrude(height) polygon ([[0,0], [width,0],[width-spread,depth],[spread,depth]]);
     
    translate([width,depth,0]) 
        rotate([90,0,270]) 
            linear_extrude(width) 
                polygon([[0,0], [depth, 0], [depth,height], [0,height-rise]]);
}
 