 // CSG.scad - Basic example of CSG usage

$fn=50;

minkowski() {
    cube([16,16, 2], true);
    cylinder(r=3,h=3);
}


cylinder(h=8, d=5, center=false);