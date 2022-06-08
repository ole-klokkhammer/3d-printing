 // CSG.scad - Basic example of CSG usage


translate([0,0,1]) {
     thing();
}

module base() {
      translate([0,0,4]) {
            cube([130,130,10],center=true);
        }
}

module thing() {
     difference(){
        base();
         translate([0,0,-1.1]) {
            cylinder(h=10.2, r1=50, r2=60);
         }
    }
}