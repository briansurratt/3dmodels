module couple() {

    unitLenght = slotDepth * 2 + materialWidth;
    pinOffset = (unitLenght - slotDepth) / 2; 

    difference() {
        
        union() {
            
            translate([0,wallShift,0]) wall(unitLenght);
            translate([0,-wallShift,0]) wall(unitLenght);
            rotate([0,0,90]) wall(totalWidth);
            bottom(lenght=unitLenght);

        }
   

    translate([pinOffset, 0, 0]) pinHole();
    translate([-pinOffset, 0, 0]) pinHole();

    }    

}