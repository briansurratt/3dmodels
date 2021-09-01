// all dimensions in millimeter
// height is used for all dimensions in Z dimension
$fn=50;

nozzelDiameter = 0.4;

tileDiameter = 89;
tileThickness = 2.5;

trayWallHeight = tileThickness * 2;

margin = 1;
allowance = 0.5;
smallallowance = 0.25;

thinWall = nozzelDiameter * 3;
mediumWall = nozzelDiameter * 5;
thickWall = nozzelDiameter * 7;

// this is the "floor"
baseHeight = 7;
textureDepth = 2;

tileVoidRadius = (tileDiameter + margin) / 2;
tileVoidDepth = tileThickness / 2;



hallBaseWidth = 32;
hallVoidWidth = hallBaseWidth + margin + allowance;





magnetDia = 5;
magnetThickness = 2;
magnetMargin = 0.25;

roomNumberSize = 6;
doorVoidThickness = mediumWall + 2;



standardDepth = 3;                // starting point for all vertical dimensions

hallTabDepth = standardDepth;     // how deep the male part of the hallway attachment go
hallTabLength = hallBaseWidth;    
hallTabWidth = standardDepth;     


// this is how thick the filler walls will be
wallInsertThickness = standardDepth; 



// the vertical height of the tray without walls;
trayDepth = standardDepth + hallTabDepth + smallallowance;

totalHeight = trayDepth + trayWallHeight;

hallSlotLength = hallTabLength + 2 * margin;
hallSlotWidth = hallTabWidth + margin;
hallSlotDepth = totalHeight + margin;

trayDiameter = tileDiameter + (mediumWall + margin + hallSlotWidth+ margin * 2) * 2;

trayRadius = trayDiameter / 2;
trayVoidRadius = trayRadius -  mediumWall ;

tileWidth = cos(30) * tileDiameter;
trayWidth = cos(30) * trayRadius;

hallSlotRadius = trayWidth - mediumWall - hallSlotWidth / 2;

doorPathRadius = trayWidth - doorVoidThickness / 2  + mediumWall;
    
    // the gap between the tab and the rest of the hallway
hallTabReach = trayWidth -  + hallSlotRadius;

hallReceiverWidth = hallTabReach + margin;
hallReceiverLength = hallVoidWidth;
hallReceiverDepth = trayDepth;
