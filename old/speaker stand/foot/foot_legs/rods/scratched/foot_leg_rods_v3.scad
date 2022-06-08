use <../../../../libs/thread_library/Thread_Library.scad>


rodWithScrewTopAndInverseScrewBottom(); 

/*
* Compound objects
*/
module rodWithScrewTopAndInverseScrewBottom(){
    translate([4,0,120]){
        screwTop(); 
    }
    mainCylinderWithInverseScrewBottom();
}

module mainCylinderWithInverseScrewBottom(){
    difference(){
        mainCylinder();
        translate([0,0,0]){
            inverseScrewBottom();
        }
    }
}


/*
* Seperate objects
*/
module mainCylinder(){
    cylinder(120, 10, 10); 
}

module screwTop(){  
    roundedCube();
}

module inverseScrewBottom(){ 
    trapezoidThreadNegativeSpace(length=15, pitch=3, pitchRadius=7);
}  

module roundedCube(){ 
    cube(size=[32,23,30], center=true);  
}