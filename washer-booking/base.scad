 // CSG.scad - Basic example of CSG usage

$fn=50;

base();

module base() {
    difference(){
        
        minkowski() {
          cube([38,22, 3], true);
          cylinder(r=3,h=3);
        }
        cylinder(h=30, d=15, center=true);
    }
} 