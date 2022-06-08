/*
*
* 50mm 12V Blower Proxy Model
*
* Author: R Sutherland
*
* License: CC BY-SA 4.0
* License URL: https://creativecommons.org/licenses/by-sa/4.0/
*
*/

$fn = 80;

module c_fan(radius, height) {

   color("red") cylinder(r=radius,h=1,center=true);

   rotate([0,0,$t*10])
   for (theta= [0:10:350]) {
       rotate([0.0,0.0,theta]){
           translate([radius-(radius*0.15),0.5,0.0]) rotate([0,0,15]) cube([radius*0.3,1.0,height-2.0],center=true);
       }
   }

   color("orange") cylinder(r=radius*0.4,h=height-3,center=true);
   color("black") cylinder(r=radius*0.1,h=height,center=true);

}

module main_box(){
   difference(){
       cube([50.0,50.0,20.0],center=true);
       cylinder(r=18.0,0.0, h=22.0,center=true);
       cylinder(r=23.5, h=17.0,center=true);
       translate([12,13.5,0.0]) cube([23.0,27.0,17.0],center=true);
       rotate_extrude () {
           translate([25,-11,0]) square(22);
       }
   }
   
  difference(){
       translate([12,12.5,0])  cube([26.0,25.0,20.0],center=true);
       translate([12.0,12.5,0])  cube([23.5,26.0,17.0],center=true);
       cylinder(r=18.0,0.0, h=22.0,center=true);
   } 
}

module chamber() {
    difference(){
        main_box();
        translate([0,0,10.9]){
            cube(size=[100,100,5], center=true);
        }   
    }
}

module bottom_lock() {
    difference(){
        translate([0, 0, 0]){ // wrapper
            translate([0,0,8.5]){
                cylinder(r=20,h=1.5);
            }
            intersection(){
                main_box();
                translate([0,0,11]){
                    cube(size=[100,100,5], center=true);
                }
            } 
        }
       cylinder(r=4,h=20);
    }
} 

difference(){
    c_fan(radius=22.0, height=19.0);    
translate([0,0,-50]){
        cylinder(r=50,h=50);
    }
}
    
/*
module blower_50mm(){

   c_fan(radius=22.0, height=19.0);

    difference(){
        hull(){
           translate([21.75,-20.00,0]) cylinder(r=3.25,h=21.0,center=true);
           translate([-21.75,19.75,0]) cylinder(r=3.25,h=21.0,center=true);
        }
       translate([21.75,-20.00,0]) cylinder(r=2.25,h=21.5,center=true);
       translate([-21.75,19.75,0]) cylinder(r=2.25,h=21.5,center=true);
       cylinder(r=24, h=19.0,center=true);
   }

   difference(){
       translate([12,12.5,0])  cube([26.0,25.0,20.0],center=true);
       translate([12.0,12.5,0])  cube([23.5,26.0,17.0],center=true);
       cylinder(r=18.0,0.0, h=22.0,center=true);
   }

   difference(){
       cube([50.0,50.0,20.0],center=true);
       cylinder(r=18.0,0.0, h=22.0,center=true);
       cylinder(r=23.5, h=17.0,center=true);
       translate([12,13.5,0.0]) cube([23.0,27.0,17.0],center=true);
       rotate_extrude () {
           translate([25,-11,0]) square(22);
       }
   }
}
*/