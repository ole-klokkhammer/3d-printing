include <hdd_caddy.scad>;

$basePlateLength_mm = 170 + 30;
$basePlateWidth_mm = 100 + $baseWidth_mm - 8;
$basePlateHeight_mm = 3;
$wallHeight = 20 + $basePlateHeight_mm + $railHeight_mm + 15;
$wallWidth = 6;

$fn=50;


echo($wallHeight);


translate([0,0,-207.5]) rotate([90,0,0]) ioWall();

module ioWall() {
    $ioWallWidth = 6;
    
    

    difference() {
        union() {
            translate([0 - $wallWidth, $basePlateWidth_mm, 0]) {
                cube([$basePlateLength_mm + (2*$wallWidth), $ioWallWidth, 8]);
                cube([$wallWidth, $ioWallWidth, $wallHeight]);
                translate([0,0,$wallHeight]) cube([$basePlateLength_mm + (2*$wallWidth), $ioWallWidth, $basePlateHeight_mm]);
            }
            translate([15, $basePlateWidth_mm, 16]) {
                cube([42,$ioWallWidth,20]);
            }

            translate([0, $basePlateWidth_mm, 28]) {
                cube([$basePlateLength_mm, $ioWallWidth, 51]);
                translate([$basePlateLength_mm - 33,0,-23]) cube([39,$ioWallWidth,$wallHeight-5]);
                translate([$basePlateLength_mm - 100,0,-10]) cube([70,$ioWallWidth,20]);
            }
        }
        
        // Barrel Plug
        color([1,1,1]) translate([21,$basePlateWidth_mm+10,23]) rotate([90,0,0]) cylinder(d=6, h=20);
        
        // PCIE hole
        color([0.5,0.5,0.5]) translate([27, 145, 20]) cube([10,66.5,52]);
        
        translate([$basePlateLength_mm + 3,$basePlateWidth_mm+4,3]) rotate([90,0,0]) cylinder(d=3, h=4);
        translate([-3,$basePlateWidth_mm+4,3]) rotate([90,0,0]) cylinder(d=3, h=4);
        translate([$basePlateLength_mm + 3,$basePlateWidth_mm+4,$wallHeight-3]) rotate([90,0,0]) cylinder(d=3, h=4);
        translate([-3,$basePlateWidth_mm+4,$wallHeight-3]) rotate([90,0,0]) cylinder(d=3, h=4);
    }
}