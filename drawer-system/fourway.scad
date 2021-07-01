
module fourWay() {

    fourWayHalf();
    rotate([0, 0, 90]) fourWayHalf();

}

module fourWayHalf() {
   unitLenght = slotDepth * 2 + shellWidth * 2 + materialWidth + margin;
    pinOffset = (unitLenght - slotDepth) / 2; 

    difference() {
        
        union() {
            translate([0,wallShift,0]) wall(unitLenght);
            translate([0,-wallShift,0]) wall(unitLenght);
            bottom(lenght=unitLenght);
        }

        translate([pinOffset, 0, 0]) pinHole();
        translate([-pinOffset, 0, 0]) pinHole();

    }
}

