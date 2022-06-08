// Hard Drive Width
$hhdWidth = 102.5;

// Base Plate
$baseHeight_mm = 3;
$baseLength_mm = 136 - 5 - 5 + 13;
$baseWidth_mm = 115.5;
// Base Plate holes
$baseHoleWidth_mm = 37;
$baseHoleLength_mm = 52;

$secondRowHolesOffset = 30;

// Rails
$railHeight_mm = 11.5 + $secondRowHolesOffset + 4.5;
$railLength_mm = $baseLength_mm;
$railWidth_mm = ($baseWidth_mm - $hhdWidth) / 2;

// Rail Notch
$railNotchHeight = $railHeight_mm - 4;
$railNotchLength = $railLength_mm - 8;
$railNotchWidth = $railWidth_mm - 1;

// HDD hole locations starting from the back
$holeXAxisOffset_mm = 18;
$holeHeightOffset = $baseHeight_mm + 6;
$holeDiameter_mm = 4;


$holeOne = $holeXAxisOffset_mm + 6;
//$holeTwo = $holeXAxisOffset_mm + 37 + $holeDiameter_mm + 6;
$holeTwo = 84;
$holeThree = $holeXAxisOffset_mm + 97 + $holeDiameter_mm + 6;


module drawMounts() {
    // Draw the base unit
    union() {
        // Draw the first rail
        firstRail();

        // Draw the second rail
        secondRail();
    }
}



// It is really (x,y,z), but named differently because the rotate
// screws it up.
module screwHole(xOffset, zOffset, yOffset) {
    rotate(a=[90,0,0]) {
        translate([xOffset,yOffset,(0 - $railWidth_mm)-1]) {
            cylinder(h=$railWidth_mm+2, d=$holeDiameter_mm,$fn=20);
        }
    }
}
