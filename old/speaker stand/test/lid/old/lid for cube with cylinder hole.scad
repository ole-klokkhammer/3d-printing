include <../../libs/nutsnbolts/cyl_head_bolt.scad>;

// All units in mm 
cube_x= 130;  
cube_y= 130;  
cube_z= 35;  

cyl_h = 20;
cylBotRad = 4.9;
cylTopRad = 5;

lidplate_height = 20;
lidplate_scale = 0.1;
 
// subtract the topscrew from the toplid:
difference(){
    lidPlate();
    topScrew(); 
} 

// Add the four bolts
boltA();
boltB();
boltC();
boltD();

//thread(10, 30, 3);


module lidPlate(){
    translate([0,0,cyl_h]){
        linear_extrude(height = lidplate_height, scale = lidplate_scale) {  
            square(size = [cube_x, cube_y], center = true);
        }
    }
}

module topScrew(){
    translate([0,0,(cyl_h + lidplate_height)]){
        cylinder(h = 10, r1 = 3, r2 = 3);  
    }
}

module boltA(){
    translate([(cube_x/2.5), -(cube_y/2.5), 1]){
        plug(); 
    }
}

module boltB(){
    translate([-(cube_x/2.5), -(cube_y/2.5), 1]){
        plug();  
    }
}

module boltC(){
    translate([-(cube_x/2.5), (cube_y/2.5), 1]){
		plug();
    }
}

module boltD(){
    translate([(cube_x/2.5), (cube_y/2.5), 1]){
		plug();
    }
}

module plug(){
    cylinder(h = cyl_h, r1 = cylBotRad, r2 = cylTopRad);  
}