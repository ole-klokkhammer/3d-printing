include <hdd_caddy.scad>;
//translate([158,48,-22]) scale([25,25,25]) rotate([90,0,0]) color([0,1,0]) import("35_hdd.stl");
//translate([158,48,-50]) scale([25,25,25]) rotate([90,0,0]) color([0,1,0]) import("35_hdd.stl");
//translate([158 - 158 - 20,48,0]) scale([25,25,25]) rotate([90,00,180]) color([0,1,0]) import("35_hdd.stl");
//translate([158,48,0]) scale([25,25,25]) rotate([90,0,0]) color([0,1,0]) import("35_hdd.stl");

//color([1,0.5,0.5]) translate([240, 50, 9]) rotate([0,0,180]) import("cm4_io_board.stl");

// PCIE Card
//color([0.5,0.5,0.5]) translate([29, 145, 20]) cube([5,62,56]);

// FAN
//translate([$basePlateLength_mm - 25, 30, ]) color([1,0,0]) cube([25,60,60]);

//translate([136,112,29 + 10]) rotate([00,0,180]) import("hdd_caddy.stl");

$fn=30;

$basePlateLength_mm = 170 + 30;
$basePlateWidth_mm = 100 + $baseWidth_mm - 8;
$basePlateHeight_mm = 3;
$wallHeight = 20 + $basePlateHeight_mm + $railHeight_mm + 15;
$wallWidth = 6;

// Base Plate
cube([$basePlateLength_mm,$basePlateWidth_mm,$basePlateHeight_mm]);

// HDD Rails
firstRail();
secondRail();

difference() {

    union() walls();
    union() {
        translate([-7,18,8]) scale([6,1,1.35]) rotate([90,0,90]) linear_extrude(1.2) text("/////////", 50);
    }

    
    // 60mm Fan
    translate([$basePlateLength_mm-1, 30+40, 3]) {
        // FAN Hole
        translate([0,40,40]) rotate([0,90,0]) color([0,1,1]) cylinder(h=8, r=30, center=false);
        // FAN Mounting Holes
        color([0,0.5,1]) translate([0,15,15]) {
            rotate([0,90,0]) cylinder(h=8, r=1.5, center=false);
            translate([0,50,0]) rotate([0,90,0]) cylinder(h=10, r=1.5, center=false);
            translate([0,0,50]) rotate([0,90,0]) cylinder(h=10, r=1.5, center=false);
            translate([0,50,50]) rotate([0,90,0]) cylinder(h=10, r=1.5, center=false);
        }
    }
    
    // IO Wall threads
    translate([$basePlateLength_mm + 3,$basePlateWidth_mm,3]) rotate([90,0,0]) cylinder(d=3, h=4);
    translate([-3,$basePlateWidth_mm,3]) rotate([90,0,0]) cylinder(d=3, h=4);
    translate([$basePlateLength_mm + 3,$basePlateWidth_mm,$wallHeight-3]) rotate([90,0,0]) cylinder(d=3, h=4);
    translate([-3,$basePlateWidth_mm,$wallHeight-3]) rotate([90,0,0]) cylinder(d=3, h=4);
    
    // Top lid threads
    translate([-2.5,3.5,$wallHeight-4]) cylinder(d=3, h=4);
    translate([$basePlateLength_mm + 2.5,3.5,$wallHeight-4]) cylinder(d=3, h=4);
    translate([-3,$basePlateWidth_mm - 8,$wallHeight-4]) cylinder(d=3, h=4);
    translate([$basePlateLength_mm + 3,$basePlateWidth_mm - 8,$wallHeight-4]) cylinder(d=3, h=4);
}

// Walls
module walls() {
    // Draw the actual left wall (Y, 0,0)
    translate([-1 * $wallWidth, 0, 0]) {
        cube([$wallWidth, $basePlateWidth_mm, $wallHeight]);
    }
    // Fill in gaps between HDD rails and case walls
    cube([$wallWidth, $railWidth_mm, $wallHeight]);
    translate([0, $baseWidth_mm - $railWidth_mm, 0])
        cube([$wallWidth, $railWidth_mm, $railHeight_mm + $basePlateHeight_mm]);
    translate([0,0,$railHeight_mm + $wallWidth])
        cube([$basePlateLength_mm, $wallWidth, $basePlateHeight_mm - $wallWidth]);
    
    // Fill in gaps in the wall on the side with the HDD caddy touching the wall
    translate([0, 0, $railHeight_mm + $basePlateHeight_mm])
        cube([$railLength_mm + $wallWidth, $wallWidth, 35]);
    translate([$railLength_mm,0,0])
        cube([$basePlateLength_mm - $railLength_mm, $wallWidth, $wallHeight]);

    
    // Draw the right wall
    translate([$basePlateLength_mm, 0, 0])
        cube([$wallWidth, $basePlateWidth_mm , $wallHeight]);
    
    //ioWall();
}

module ioWall() {
    $ioWallWidth = 6;

    difference() {
        union() {
            translate([0 - $wallWidth, $basePlateWidth_mm, 0]) {
                cube([$basePlateLength_mm + (2*$wallWidth), $ioWallWidth, 8]);
                cube([$wallWidth, $ioWallWidth, $wallHeight]);
            }
            translate([15, $basePlateWidth_mm, 16]) {
                cube([42,$ioWallWidth,20]);
            }

            translate([0, $basePlateWidth_mm, 28]) {
                cube([$basePlateLength_mm, $ioWallWidth, 51]);
                translate([$basePlateLength_mm - 33,0,-23]) cube([39,$ioWallWidth,$wallHeight-5]);
                // Over the HDMI
                translate([$basePlateLength_mm - 100,0,-7]) cube([70,$ioWallWidth,20]);
            }
        }
        
        color([1,1,1]) translate([7.5,$basePlateWidth_mm+10,40]) rotate([90,0,0]) cylinder(d=11.5, h=20);
        color([0.5,0.5,0.5]) translate([27, 145, 20]) cube([10,66.5,56]);
        
        translate([$basePlateLength_mm + 3,$basePlateWidth_mm+4,3]) rotate([90,0,0]) cylinder(d=3, h=4);
        translate([-3,$basePlateWidth_mm+4,3]) rotate([90,0,0]) cylinder(d=3, h=4);
        translate([$basePlateLength_mm + 3,$basePlateWidth_mm+4,$wallHeight-3]) rotate([90,0,0]) cylinder(d=3, h=4);
        translate([-3,$basePlateWidth_mm+4,$wallHeight-3]) rotate([90,0,0]) cylinder(d=3, h=4);
    }
}



module standoffs() {
    translate([0,-2,0]) {
        difference() {
            union() {
                translate([11,8,0]) cylinder(d=7, h=8);
                translate([11,77,0]) cylinder(d=7, h=8);
                translate([145,8,0]) cylinder(d=7, h=8);
                translate([145,77,0]) cylinder(d=7, h=8);
                
                //color([1,0,0]) translate([85,3.5,0]) cylinder(d=7, h=8);
            }
            translate([11,8,0]) cylinder(d=3, h=8);
            translate([11,77,0]) cylinder(d=3, h=8);
            translate([145,8,0]) cylinder(d=3, h=8);
            translate([145,77,0]) cylinder(d=3, h=8);
        }
    }
}

// Mock the CM4 I/O Board
translate([5, $baseWidth_mm + 5 + 5, $basePlateHeight_mm - 2]) {
    standoffs();
    //translate([0,0,8]) color([1,0,0]) cube([160, 90, 1.5]);
}

$holeOne = $holeXAxisOffset_mm + 6;
//$holeTwo = $holeXAxisOffset_mm + 37 + $holeDiameter_mm + 6;
$holeTwo = 84;
$holeThree = $holeXAxisOffset_mm + 97 + $holeDiameter_mm + 6;

echo($holeOne);
echo($holeTwo);
echo($holeThree);


module firstRail() {
    translate([0,0,$baseHeight_mm]) {
        // The rail base
        difference() {
            // The rail rectangle
            cube([$railLength_mm,$railWidth_mm,$railHeight_mm]);
            // Hole One
            screwHole($holeOne,(0 - $railWidth_mm),$holeHeightOffset);
            // Hole Two
            screwHole($holeTwo,(0 - $railWidth_mm),$holeHeightOffset);
            // Hole Three
            screwHole($holeThree,(0 - $railWidth_mm),$holeHeightOffset);
            
            // Hole Four
            screwHole($holeOne,(0 - $railWidth_mm),$holeHeightOffset + $secondRowHolesOffset);
            // Hole Five
            screwHole($holeTwo,(0 - $railWidth_mm),$holeHeightOffset + $secondRowHolesOffset);
            // Hole Six
            screwHole($holeThree,(0 - $railWidth_mm),$holeHeightOffset + $secondRowHolesOffset);
            
            // Notch
            translate([5, -1, 3]) {
                cube([$railNotchLength,$railNotchWidth+1,$railNotchHeight]);
            }
        }
        // Side supports/reinforcement
        //translate([(($railLength_mm - 11) / 15) * i, 0, 0])
        cube([16,$railWidth_mm,$railHeight_mm]);
        translate([32, 0, 0])
            cube([45,$railWidth_mm,$railHeight_mm]);
        translate([91, 0, 0])
            cube([27,$railWidth_mm,$railHeight_mm]);
        translate([71 + 48 + 13, 0, 0])
            cube([4,$railWidth_mm,$railHeight_mm]);
        
        
        //translate([37 + 17 + 20 + 50 + 5, 0, 0])
        //    cube([12,$railWidth_mm,$railHeight_mm]);
    }
}

module secondRail() {
    translate([0, $baseWidth_mm, 0]) {
        mirror([0,1,0]) {
            firstRail();
        }
    }
}