 // CSG.scad - Basic example of CSG usage

$fn=50;

 
base();

module base() { 
    difference() {
        cube([80, 70, 20], center=true);
        translate([3,0,10])  cube([80, 67, 37], center=true);
    }
} 