distanceBetweenRings = 36;
insetLength = 1;
insetWidth = 3;

width = 3;
overlap = 2;


lowerOverLength = distanceBetweenRings + 2 * insetLength;
overLength = lowerOverLength + 2 * overlap;



workableSpace = overLength - overlap - insetLength - 4;

holeLength = 5;
unitLength = holeLength + 1;
numberOfHoles = (workableSpace / unitLength) - 1;

startingPoint = (overLength - workableSpace) / 2;

difference() {
    cube([overLength, width, 2]);
    negative();

    translate([lowerOverLength + overlap + insetLength + 1, width,0]) 
    rotate([0,0,180]) 
        negative();

for (i=[1:numberOfHoles])  {
	#translate([startingPoint + (i * unitLength),1,0]) cube([holeLength,1,2]);
}


}






module negative() {
    union() {
        translate([0, 0,1]) cube([overlap, width, 1]);
    }
}