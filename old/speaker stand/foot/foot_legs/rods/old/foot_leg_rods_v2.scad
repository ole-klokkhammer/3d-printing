use <../../../../libs/thread_library/Thread_Library.scad>

rotate([0,180,0]){
    rodWithScrewTopAndInverseScrewBottom();  
}

/*
* Compound objects
*/
module rodWithScrewTopAndInverseScrewBottom(){
    translate([3,0,110]){
        screwTop(); 
    }
    mainCylinderWithInverseScrewBottom();
}

module mainCylinderWithInverseScrewBottom(){
    difference(){
        mainCylinder(); 
        inverseScrewBottom(); 
    }
}


/*
* Seperate objects
*/
module mainCylinder(){
    cylinder(100, 10, 10); 
}

module screwTop(){
    roundedCube();
}

module inverseScrewBottom(){ 
    trapezoidThreadNegativeSpace(length=15, pitch=3, pitchRadius=7);
}  

module roundedCube(){
    minkowski() {
        cube(size=[25,18,25], center=true); 
        sphere(r=5);
    }
}