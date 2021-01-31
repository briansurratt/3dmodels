// all dimensions in millimeter
// height is used for all dimensions in Z dimension
$fn=50;

nozzelDiameter = 0.4;

tileDiameter = 89;
tileThickness = 2.5;

trayWallHeight = tileThickness * 2;

margin = 1;

thinWall = nozzelDiameter * 3;
mediumWall = nozzelDiameter * 5;
thickWall = nozzelDiameter * 7;

// this is the "floor"
baseHeight = 7;

hallBaseWidth = 33;
hallVoidWidth = hallBaseWidth - mediumWall * 2;

trayDiameter = tileDiameter + mediumWall * 2 + margin * 2;
trayRadius = trayDiameter / 2;

trayVoidRadius = trayRadius -  mediumWall ;

tileWidth = cos(30) * tileDiameter;
trayWidth = cos(30) * trayRadius;


magnetDia = 5;
magnetThickness = 2;
magnetMargin = 0.25;

roomNumberSize = 6;