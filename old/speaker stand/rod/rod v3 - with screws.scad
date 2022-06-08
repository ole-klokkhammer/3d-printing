use <../../libs/thread_library/Thread_Library.scad>


difference(){ 
    rodWithScrewTopAndInverseScrewBottom();
    cylinder(150,4,4);
} 


/*
* Compound objects
*/
module rodWithScrewTopAndInverseScrewBottom(){
    translate([0,0,120]){
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
    trapezoidThread(length=10, pitch=3, pitchRadius=7);   
}

module inverseScrewBottom(){ 
    trapezoidThreadNegativeSpace(length=15, pitch=3, pitchRadius=7);
}