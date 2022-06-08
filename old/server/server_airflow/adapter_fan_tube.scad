 // CSG.scad - Basic example of CSG usage


translate([0,0,1]) {
     thing();
}

module base() {
        cube([130,130,5],center=true);
        cylinder(h=20,r1=65,r2=49);
}

module thing() {
    difference(){
            translate([0,0,20]) {
                cylinder(10, r=49);
            }
             translate([0,0,18]) {
                cylinder(15, r=47);
            }
     }
     difference(){
            base();
            cylinder(45, r1=75, r2=45, center = true);
      }
}