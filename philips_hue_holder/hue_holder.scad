

 
$fn=3000; 
 
 

module clipped_holder(){
    difference(){ 
        translate([0,0,2]) { 
            import ("hue_holder_original.stl");       
        }
        translate([-75,-75,-20]){
            cube([150,150,20]);
        }
    }
}
 
clipped_holder();