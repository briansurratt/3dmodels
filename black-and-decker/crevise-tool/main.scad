$fn=64;

nozzelDiameter = 0.4;
wallThickness = 5 * nozzelDiameter;

receiverDiameter = 40;
receiverBodyLength = 70;
receiverTaperLength = 15;
latchLength=65;
allowence = 2;

bladeThickness = 18;

receiverVolumeDiameter = receiverDiameter + allowence;
receiverVolumeLength = receiverBodyLength + allowence;

plateWidth= receiverVolumeDiameter + 2 * wallThickness;
plateLength = receiverBodyLength + receiverTaperLength + wallThickness;
plateBackDepth = 5;
totalDepth = plateBackDepth + receiverVolumeDiameter / 2;


versionString = "1.0.0";

difference() {
    union() {
        cube([plateWidth, plateLength, totalDepth], true);
        yTransalation = -1 * (plateLength/2 - (receiverTaperLength+wallThickness) / 2);
        translate([0,yTransalation ,-totalDepth/2]) { 
            cube([plateWidth, receiverTaperLength+wallThickness, totalDepth * 2], true);
            
        }
    }
    recieverVolume();
    holes();
    #versionText();
}
    
    

module holes() {
    translate([0,0, totalDepth / 2 - plateBackDepth - 0.5 ]) {

        translate([0,-15,0])  {
            hole();
        }

        translate([0,20,0])  {
            hole();
        }
        
        

    } 
}





module recieverVolume() {

    translate([0,receiverVolumeLength/2-receiverTaperLength/2 - 1 + receiverTaperLength + plateBackDepth,-totalDepth/2 - 1 ])  {

        rotate([90,0,0]) {

            // difference() {
                toolMockup();
            
        }
    }

}


module toolMockup() {

    difference() {
    union() {
        cylinder(receiverVolumeLength,r=receiverVolumeDiameter/2, true);
        translate([0,0,receiverVolumeLength])  {
            cylinder(receiverTaperLength,r=receiverVolumeDiameter/2, true);
        }

        translate([-bladeThickness / 2, -receiverVolumeDiameter/2,receiverVolumeLength + receiverTaperLength]) { 
            cube([bladeThickness, receiverVolumeDiameter, receiverVolumeLength]);
        }

    }

    translate([-receiverVolumeDiameter/2, -receiverVolumeDiameter/2, receiverVolumeLength+ receiverTaperLength ])  {
        rotate([-90,0,0]) {
            bladeNegative();
            translate([receiverVolumeDiameter,0,0]) {
                mirror([1,0,0])  {
                    bladeNegative();
                }
            }
        }
    }
    }

}


module bladeNegative() {
    w = (receiverVolumeDiameter - bladeThickness) / 2;
    h = receiverTaperLength + allowence;

linear_extrude(height = receiverVolumeDiameter) {

    polygon(
        [
            [0,0],
            [w,0],
            [0,h]
        ]);
}

}


module hole() {
    mirror([0,0,0]) 
    screw_countersunk(
        35,
        8.1,
        3.2,
        4
    );
}

module screw_countersunk(
        l=20,   //length
        dh = 6,   //head dia
        lh = 3,   //head length
        ds = 3.2,  //shaft dia
        )
{
    union() {
        cylinder(h=lh, r1=dh/2, r2=ds/2); // head
        cylinder(h=l, r=ds/2); // shaft
        translate([0,0,-1]) {
            cylinder(h = 1, r = dh/2); // head space
        }
    }
}


module versionText() {
    translate([0,0, totalDepth/2 - 0.5]){ 
        linear_extrude(height = 1) {
            mirror([0,0,0])  {
                text(text=versionString, size = 3, halign = "center");
            }
        }
    }
}