 // CSG.scad - Basic example of CSG usage

$fn=50;

cube([20,16, 3], true);
difference(){
    cylinder(h=10, d=14, center=false);
    translate([0,0,5]){
        cylinder(h=15, d=5, center=false);
    }
}



