/**
 * Honeycomb library
 * License: Creative Commons - Attribution
 * Copyright: Gael Lafond 2017
 * URL: https://www.thingiverse.com/thing:2484395
 *
 * Inspired from:
 *   https://www.thingiverse.com/thing:1763704
 */

// a single filled hexagon
module hexagon(l)  {
	circle(d=l, $fn=6);
}

// parametric honeycomb  
module honeycomb(x, y, dia, wall)  {
	// Diagram
	//          ______     ___
	//         /     /\     |
	//        / dia /  \    | halfFlat
	//       /     /    \  _|_
	//       \    /     /   ____ 
	//        \  /     /   / 
	//     ___ \/_____/   / 
	// wall |            /
	//     _|_  ______   \
	//         /      \   \
	//        /        \   \
	//                 |---|
	//                   projWall
	//
	halfFlat = dia * cos(30);
	projWall = wall * cos(30);

    echo("halfFlat: ", halfFlat);

	yStep = halfFlat + wall;
	xStep = dia*3/2 + projWall*2;

	difference()  {
		square([x, y]);

		// Note, number of step+1 to ensure the whole surface is covered
		for (yOffset = [0:yStep:y+yStep], xOffset = [0:xStep:x+xStep]) {
			translate([xOffset, yOffset]) {
				hexagon(dia);
			}
			translate([xOffset + dia*3/4 + projWall, yOffset + (halfFlat+wall)/2]) {
				hexagon(dia);
			}
		}
	}
}