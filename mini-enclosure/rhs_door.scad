




module railProfile() {

polygon(
    [
    [0,0],
    [railDepth, 0],
    [railDepth, railShellThickness],
   [ railFooterDepth, railShellThickness],
   [railFooterDepth, railShellThickness + plexiThickness],
      [railDepth, railShellThickness + plexiThickness],
      
      [railDepth, railWidth],
      [0,railWidth]
]
);

}


module railHinge() {


    hingeHeadDiameter = railWidth - 0.25;

    difference() {

        union () {
            
            cylinder (railEdgeDepth, d=hingeHeadDiameter);

            translate([railWidth, 0,0])  cylinder (railEdgeDepth, d=hingeHeadDiameter);


            translate([0, -hingeHeadDiameter / 2,0])  cube ([hingeHeadDiameter, hingeHeadDiameter, railEdgeDepth]);
        }

    translate ([0,0,-1])
        cylinder (railEdgeDepth + 2, d=hingePinDimeter + 0.5);

     translate ([railWidth,0,-1])
        cylinder (railEdgeDepth + 2, d=hingePinDimeter + 0.5);
        
    }

}