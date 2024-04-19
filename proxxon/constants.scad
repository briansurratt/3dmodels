$fn= $preview ? 64 : 128;

versionString = "1.1.1";

nozzelDiam = 0.4;
tolerace = 0.25;

thinWall = nozzelDiam * 2;
regWall = nozzelDiam * 3;
heavyWall = nozzelDiam * 4;

barWidth = 7.6; //x
barHeight = 7.8; // z
barLength = 150; // y

tensionScrewOC = 27;
tensionScrewDiam = 4.8 + tolerace;

pivotTopTarget = 29.6;
privotTopActual = 29.5;

underScale = pivotTopTarget/privotTopActual;

pivotTopDiam = pivotTopTarget * underScale + tolerace;
pivotTopRadius = pivotTopDiam / 2;

pivotBottomDiam = 24.5 * underScale + tolerace;
pivotTotalHeight = 10.3 ;
pivotTopHeight = 2.1+ tolerace;
pivotBottomHeight = pivotTotalHeight-pivotTopHeight;

bodyHeight = pivotBottomHeight + pivotTopHeight - tolerace;
bodyRadius = tensionScrewOC + 15 ;
bottomRadius = 50;
totalWidth = bottomRadius * 2;


bladeWidth = barWidth + tolerace;
bladeScrewDia = 3 + tolerace;
bladeBodyLength = 35;
bladeLength= bladeBodyLength + bladeWidth/2;

bladeChannelWidth = bladeScrewDia + 2* tolerace;
bladeChannelLength = bladeBodyLength - heavyWall;
bladeArmWidth = 2.5;
bladeArmLength = bladeBodyLength / 2;
bladeArmDepth = bodyHeight + 3;
bladeTotalWidth = bladeWidth + 2 * bladeArmWidth + tolerace;
halfBladeWidth = bladeWidth / 2;
bladeTailWidth = 4;



headerHeight = 20;

pinRadius = 2;
pinHeight = 3;
pinHoleRadius = pinRadius + tolerace;
pinHoleDepth = pinHeight + tolerace;

pinInset = 15;

apperature = 9.8;

mountOffset = pivotTopRadius + 2;

