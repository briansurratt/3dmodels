bodyWidht = 122.5;   // x
bodyLenght = 56;     // y
bodyHeight = 42;     // z

shell = 3;
allowence = 0.25;

railSide = 18.2;

clipLip = 10;

shelfWidth = 358.775;

// this was something that I had to add after printing
xFudge = 11;

bodyVoidH = bodyHeight + allowence;
bodyVoidL = bodyLenght + allowence;
bodyVoidW = bodyWidht + allowence;

shellW = bodyVoidW + 2 * shell;  // x
shellL = bodyVoidL + 2 * shell;  // y
shellH = bodyVoidH + 2 * shell;  // z

receiverW = 30+ xFudge;
foundationL = shellL;
foundationW = shelfWidth / 2  - shellW / 2 + receiverW;

rcvrVoidW = receiverW - shell - allowence;
rcvrVoidL = bodyVoidL;
rcvrVoidH = bodyVoidH;

// how much space is between the end of the body and the tubes
tuberInset = 7.5;

// distance to shift in the y axis 
ribOffset = foundationL/2 * 2/3;

wireDia = 7; // 4.7 + sum padding
wireAllowance = railSide / 2;

clipWidth = 25;



