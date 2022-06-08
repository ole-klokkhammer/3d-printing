include <../../libs/nutsnbolts/cyl_head_bolt.scad>;
 


difference(){
    translate([-6,-6,0]){
        cube([12, 12, 12]);
    }
    thread(5, 30, 1);
} 