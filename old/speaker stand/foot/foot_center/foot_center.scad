use <../../../libs/thread_library/Thread_Library.scad>
  

baseStructure(); 
topScrew();
screwA();
screwB();
screwC();
screwD();


module baseStructure(){
    translate([0,0,20]){
        roundedCube();
    }
}  

module roundedCube(){
    minkowski() {
        cube(size=[31,31,31], center=true); 
        sphere(r=5);
    }
}

module topScrew(){
    translate([0,0,40]){
        trapezoidThread(length=12, pitch=3, pitchRadius=7);   
    }
} 

module screwA(){
    rotate([0,90,0]){
        translate([-20,0,20]){
            trapezoidThread(length=12, pitch=3, pitchRadius=7);   
        } 
    } 
}


module screwB(){
    rotate([90,0,0]){
        translate([0,20,20]){
            trapezoidThread(length=12, pitch=3, pitchRadius=7);   
        } 
    } 
} 

module screwC(){
    rotate([0,-90,0]){
        translate([20,0,20]){
            trapezoidThread(length=12, pitch=3, pitchRadius=7);   
        } 
    } 
} 

module screwD(){
    rotate([-90,0,0]){
        translate([0,-20,20]){
            trapezoidThread(length=10, pitch=3, pitchRadius=7);   
        } 
    } 
} 