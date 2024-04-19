$fn = 100;

extenstionWidth = 2;
shellThickness = 1;

lipExtenstion = (extenstionWidth * 2);

lenseBodyID = 33;
lensInsertHeight = 2;
lenseLipOD = lenseBodyID + lipExtenstion;

mountBodyID = 35;
mountInsertHeight=2;
mountInsertLip= mountBodyID + lipExtenstion;

frontID = lenseBodyID - 2 * shellThickness;

scopeInsertOD = 27;


anchorHeight = 5;
anchorHoleID = 24;
anchorDrop = 2;
anchorCollarOD = 35;




//head();
foot();
//anchorInsert();


module head() {
    translate ([0,0,- anchorHeight / 2]) anchorCollar();
    difference() {
        union() {
            lensIntergation();
            translate ([0,0,mountInsertHeight / 2 - 0.5]) anchorFoot();
        }
        cylinder(h=20, d = anchorHoleID - 2, center = true);
    }
}

module foot() {
    difference() {
        union() {
            translate ([0,0,anchorHeight / 2 + mountInsertHeight]) anchorCollar();
            translate ([0,0,shellThickness / 2 + mountInsertHeight]) anchorFoot();
            #translate ([0,0,mountInsertHeight / 2]) anchorInsert();
        }
        cylinder(h=20, d = anchorHoleID - 2, center = true);
    }
}

module anchorFoot() {
    cylinder(h=shellThickness, d = anchorCollarOD, center = true);
}

module anchorCollar() {
    difference() {
        cylinder(h=anchorHeight, d = anchorCollarOD, center = true);
        cylinder(h=anchorHeight + 2, d = scopeInsertOD, center = true);
    }
}


module anchorInsert() {
    difference() {
        cylinder(h=mountInsertHeight, d = anchorHoleID, center = true);
        cylinder(h=mountInsertHeight + 2, d = anchorHoleID - 2, center = true);
    }
}

module lensIntergation() {
    union() {
        translate ([0,0,5]) lenseInsert();
        translate ([0,0,3]) bodyLip();
        translate ([0,0,1]) bodyInsert();
    }
}

module bodyLip() {
    difference() {
        cylinder(h=mountInsertHeight, d = mountInsertLip, center = true);
        cylinder(h=mountInsertHeight + 2, d = frontID, center = true);
    }
}

module lensLip() {
    difference() {
        cylinder(h=lensInsertHeight, d = lenseLipOD, center = true);
        cylinder(h=lensInsertHeight + 2, d = frontID, center = true);
    }
}


module bodyInsert() {
    difference() {
        cylinder(h=mountInsertHeight, d = mountBodyID, center = true);
        cylinder(h=mountInsertHeight + 2, d = frontID, center = true);
    }
}

module lenseInsert() {
    difference() {
        cylinder(h=lensInsertHeight, d = lenseBodyID, center = true);
        cylinder(h=lensInsertHeight + 2, d = frontID, center = true);
    }
}