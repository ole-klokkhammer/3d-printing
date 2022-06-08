use <../../../libs/thread_library/Thread_Library.scad>
  
 
difference(){
    baseStructure();
    translate([0,0,0]){
        inverseScrewBottom();
    }
} 


module baseStructure(){
    translate([0,0,20.5]){
        roundedCube();
    }
}  

module roundedCube(){
    minkowski() {
        cube(size=[31,31,31], center=true); 
        sphere(r=5);
    }
}

module inverseScrewBottom(){ 
    trapezoidThreadNegativeSpace(length=15, pitch=3, pitchRadius=7);
}