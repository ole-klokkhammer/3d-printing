include <hdd_caddy.scad>;

$basePlateLength_mm = 170 + 30;
$basePlateWidth_mm = 100 + $baseWidth_mm - 8;
$basePlateHeight_mm = 3;
$wallHeight = 20 + $basePlateHeight_mm + $railHeight_mm + 15;
$wallWidth = 6;

//color([1,0.5,0.5]) translate([240, 50, 9]) rotate([0,0,180]) import("cm4_io_board.stl");

$fn=50;

echo($wallHeight);

// Top Plate
translate([0-$wallWidth,0,30]) color([0,1,0]) {
    difference() {
        cube([$basePlateLength_mm+(2*$wallWidth),$basePlateWidth_mm,$basePlateHeight_mm]);
        
        translate([$wallWidth,0,0]) {
            translate([-2.5,3.5,0]) cylinder(d=3, h=4);
            translate([$basePlateLength_mm + 2.5,3.5,0]) cylinder(d=3, h=4);
            translate([-3,$basePlateWidth_mm - 8,0]) cylinder(d=3, h=4);
            translate([$basePlateLength_mm + 3,$basePlateWidth_mm - 8,0]) cylinder(d=3, h=4);
        }
        
        translate([35,115,-1]) scale([1,1,1]) rotate([0,0,90]) linear_extrude(5) text("///////", size=20, font="Ubuntu:style=Bold");
        translate([65,115,-1]) scale([1,1,1]) rotate([0,0,90]) linear_extrude(5) text("\\\\\\\\\\\\\\", size=20, font="Ubuntu:style=Bold");
        
        translate([95,115,-1]) scale([1,1,1]) rotate([0,0,90]) linear_extrude(5) text("///////", size=20, font="Ubuntu:style=Bold");
        translate([125,115,-1]) scale([1,1,1]) rotate([0,0,90]) linear_extrude(5) text("\\\\\\\\\\\\\\", size=20, font="Ubuntu:style=Bold");
    }

    
}
