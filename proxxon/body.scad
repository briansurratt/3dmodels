include<constants.scad>;
use <Arc_Module_01.scad>;
//include <ScrewsMetric/ScrewsMetric.scad>;

// blade();

 blade(true);
//bar();
// union() {

//main();
// screwHole();

module main() {
    difference() {
        body();
        pivot();
        versionText();
    }
    lettering();
    mountInterface();
}

module mountInterface() {


    inset = (headerHeight + apperature) / 2;
    headerWidth = apperature;
    midPoint = headerHeight / 2;


    translate([-(pivotTopRadius + halfBladeWidth),totalWidth/2,0]) 

    rotate([90,-90,0]) 

    difference() {

        linear_extrude(totalWidth) {
        polygon([
                [0,-halfBladeWidth],
                [0,apperature],
                [inset,apperature],
                [midPoint,apperature/2],
                [headerHeight-inset,apperature],
                [headerHeight,apperature],
                [headerHeight,0]
            ]

        );
        }

        translate([midPoint,apperature/2-pinHoleDepth,0]) 
        rotate([-90,-90,0]) {
                
            translate([pinInset,0,0]) 
            cylinder(h = apperature, r = pinHoleRadius);

            translate([totalWidth - pinInset,0,0]) 
            cylinder(h = apperature, r = pinHoleRadius);

        }
    }

}

module versionText() {
    
    xDelta =  pivotTopRadius + (tensionScrewOC - pivotTopRadius) / 2;
    
    translate([xDelta,0,bodyHeight-0.5]){ 
        rotate(a = 90) 
        linear_extrude(height = 1) {
        text(text=versionString, size = 3, halign = "center");
        }
    }
}

module tensionChannel() {

    innerRad = tensionScrewOC - tensionScrewDiam/2;
    outerRad = innerRad + tensionScrewDiam + thinWall;

    cylRad = tensionScrewDiam/2 + thinWall/2;

    rotate(a = -90) {
        translate([0,0,-0.5]) {
            
            translate([-tensionScrewOC- thinWall/2,0,0]) { 
                cylinder(h=bodyHeight+ 1, r=cylRad, center = false);
            }

            translate([tensionScrewOC + thinWall/2,0,0]) { 
                cylinder(h=bodyHeight+ 1, r=cylRad, center = false);
            }

            linear_extrude(height = bodyHeight + 1)  {
                arc(a=180, r1= innerRad  , r2=outerRad);
            }
        }
    }
}



module body() {

    radius = bodyRadius +  bladeLength/2 - bladeWidth /2  ;

    translate([- (pivotTopRadius + halfBladeWidth), -totalWidth/2 ,0]) 
    cube([pivotTopRadius,totalWidth,bodyHeight]);

    difference() {
        truncatedArc();
        tensionChannel();
        translate([0,0,-1]) {
            resize([0,0,bodyHeight + 2])  {
                for (a =[-6:6]) {
                    orbit(radius, a*15 + 90) {blade();};
                }
            }
        }

    }

}


module truncatedArc (){ 

    color("olive") {
        difference() {


        cylinder(
            h=bodyHeight, 
            r1=bottomRadius,
            r2=bodyRadius, 
            center = false);

        translate([-totalWidth-halfBladeWidth-tolerace,-totalWidth/2,-0.5]) {
            cube([totalWidth, totalWidth, bodyHeight + 1]);
        }

    }
}
}


module lettering() {

    radius = tensionScrewOC + tensionScrewDiam + 3;

    translate([0,0,bodyHeight]){ 

    linear_extrude(height = 1) {
        for (a =[-6:6]) {
            s = str(abs(a * 15));
            orbit(radius, a*15 + 90) {
                text(text=s, size = 3, halign = "center");
            };
        

        }
    }
    }

}
    


module pivot() {
    // translate([0,0,barHeight/2 + 5]) 
    
    color("Gainsboro") { 
    union() {
        translate([0,0,pivotBottomHeight]){
            cylinder(h=pivotTopHeight + tolerace, r=pivotTopDiam / 2, center = false);
        }
        
        translate([0,0,-tolerace]){
            cylinder(h=pivotBottomHeight + tolerace, r=pivotBottomDiam / 2, center = false);
        }
    }
}
}

module blade(includeHole = false) {

    // translate([-bladeWidth/2,-bladeLength/2,0 ]) {

        union() {

            translate([0,-bladeTailWidth,0]) {
                cube([bladeWidth, bladeTailWidth,bodyHeight+barHeight-1]);
            }

            difference() {
                linear_extrude(height = bodyHeight) {
                    polygon(points=[[0,0],[bladeWidth,0],[bladeWidth,bladeBodyLength],[bladeWidth-bladeWidth/2,bladeLength],[0,bladeBodyLength]]);
                }


            if (includeHole) {
                translate(v = [0,0,-0.5]) {
                linear_extrude(height = bodyHeight+1) {
                    hull() {
                    #translate([bladeWidth/2,bladeChannelLength-bladeChannelWidth/2,0]) {
                        // cylinder(h=bodyHeight+1, r=bladeChannelWidth / 2, center = false);
                        circle(d=bladeChannelWidth);
                    }

                    #translate([bladeWidth/2,bladeChannelWidth/2+heavyWall,0]) {
                        // cylinder(h=bodyHeight+1, r=bladeChannelWidth / 2, center = false);
                        circle(d=bladeChannelWidth);
                    } 
                    }
                }
                }
            }
            }
        // }
    }

}

module bar() {

    difference() {
        color("Gainsboro") { 
            cube([barWidth, barLength, barHeight], true);
        }



        translate([0, 27,0]) {
            cylinder(h=barHeight+1, r=tensionScrewDiam / 2, center=true);
        }
    }

}



module orbit(pathRadius = 10, angle=0) {

    a = angle + 180;

    translate(
        [
            pathRadius*sin(-a),
            pathRadius*cos(a),
            0
        ]) {
            rotate(angle)   {
                children();
            }
        }

}

module screwHole() {
    boltCenterHeight = bodyHeight + 1 + getHeadDiameter(allenBolt, M3) / 2;
    translate([-(pivotTopRadius + bladeWidth),0,boltCenterHeight]){
        rotate([0,90,0]) {
            AllenBoltHole(M3, 8, 10 ,0);
        }
    }

}