// CSG.scad - Basic example of CSG usage

$fn=1000;
difference() {
    cylinder(h=15, r1=7.5, r2=7.5);
    translate([0,0,-5]) {
        cylinder(h=100, r1=7, r2=7);
    }
}

translate([0,0,0]) {
    difference() {
        cylinder(h=1, r1=12.5, r2=12.5);
        translate([0,0,-5]) {
            cylinder(h=100, r1=7, r2=7);
        }
    }
}