$fn = $preview ? 32 : 128;

foundation = 2; // the thickness under the minis
baseThickness = 4;
totalThickness = baseThickness + foundation;

cornerRadius = 1;

spacing = 2;
exteriorSpacing = 2;


// 32
// 2x5

margin = 0.5;

tray(32,4,4);



module tray(diameter, xCount, yCount) {

    effectiveDiameter = diameter + margin;


    width = (xCount * effectiveDiameter) + (spacing * (xCount -1)) + (exteriorSpacing * 2) - (2 * cornerRadius);
    depth = (yCount * effectiveDiameter) + (spacing * (yCount -1)) + (exteriorSpacing * 2) - (2 * cornerRadius);

    intitialOffset = exteriorSpacing + effectiveDiameter/2 - cornerRadius;
    internalOffset = effectiveDiameter + spacing;

    difference() {

        linear_extrude(totalThickness) {
            offset(r=cornerRadius) {
                square(size=[width, depth]);
            }
        }

        for(y = [1 : 1 : yCount]) {

            for(x = [1 : 1 : xCount]) {
                translate([intitialOffset + (x - 1) * internalOffset, intitialOffset + (y - 1) * internalOffset, foundation]) {
                    cylinder(d=effectiveDiameter, h=(baseThickness + margin), center=false);
                }
            }

        }


    }

}


