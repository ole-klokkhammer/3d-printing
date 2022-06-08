


module model(){ 
    translate([-0.5,0.5,49]){
        rotate([180,0,0]){
            difference(){ 
                translate([20,6,0]) {
                    rotate([90,0,0]){
                        import("model.stl");
                    }
                }
                translate([0,0,-5]){
                    cube([150,150,45]);
                }
            }
        }
    }
}

model();