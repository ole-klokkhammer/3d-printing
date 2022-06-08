 
extra_space_sdcard = 3;
box_length = 85  + extra_space_sdcard;
box_width = 56;
board = [box_length, box_width , 1.3 ];  //dimension of rasp pi
t     = 1.40;             //Thickness of rasp pi board
p     = 1.5;              //Thickness of plastic case
g     = 2;                //gap around board
$fn   = 12;               //roundness of rendering
rb    = 4;                //roundness of box
huge  = 200;              // for drilling out holes etc 
stand_off = 3;            //raise board above bottom plastic
box_height = 45;
full_rpi_stands_height = 45;
box   = board + [7 , 7, box_height];  //outside dimensions of our case
bh    = 15;               //Where to slice box
d = 3.5;                  //displacement of hole from edge  
eps = 0.01;               //a very tiny value F
micro =  [[6.5 + extra_space_sdcard ,-1.5 ,1] ,[8    ,6     , 3   ] ,[-1, -10,    0] , [2,   4,  2  ]];
hdmi  =  [[24.4 + extra_space_sdcard,-2   ,1] ,[15.2 ,12    , 7.9 ] ,[0,  -10,    0] , [0,  10,  0  ]];
camera=  [[43  + extra_space_sdcard ,0    ,1] ,[4    ,22.4  , 7   ] ,[0,    0,    0] , [0,   0, 10  ]];
audio =  [[50.4 + extra_space_sdcard ,-2   ,1] ,[6.2  ,14.5  , 6.4 ] ,[0,  -10,    0] , [0,  10,  0  ]]; 
//SD is below the board so needs to drop a fair bit to give access to the card
SD    =  [[-3  ,19.5 ,-2.5] ,[14   ,17  , 2.5 ] ,[-16,   0,    -4] , [6,   0,  4  ]];
// make a list so we can handle our devices as a group 
echidna = [micro,hdmi,camera,audio,gpio,display,SD];  

shift =[p+g,p+g,p+stand_off];  //plastic + gap at e8dge and height of screw pad
holes =  [[p+g+d + extra_space_sdcard, p+g+d], [65 + extra_space_sdcard, p+g+d], [65 + extra_space_sdcard, box_width], [p+g+d + extra_space_sdcard, box_width]]  ; 

//Utility module to make a solid box with rounded corners
module hull_build(box,r){
    //spheres at the corners of a box and run hull over it
    x = box  - 2 * [r,r,r];
    difference(){
    hull(){
        for (i=[0:1]){
            for (j=[0:1]) {
                for (k=[0:1]){
                        translate([i*x[0],j*x[1],k*x[2]]+[r,r,r]) //move up r because we moved box up
                            sphere(r);
                            }            
                        }   
                    }  
              }   
         }  
}

module complete_box(){
    embiggen = [2,2,2]; // make holes 1mm bigger all round
    //substract devices out of our case
    difference(){
        hull_build(box,rb); //outer shell
        translate([p,p,p])
            hull_build(box-[p+p,p+p,p+p],rb);   
        //move, embiggen then subtract
        for (i=echidna) {
            translate(i[0] + i[2] + shift -embiggen/2) 
                    cube(i[1]+ i[3] + embiggen);
        }
    }
}
   
module stand_off() {
    difference(){
        union(){
            children();  // this will the complete_box
            for (q=holes){
                translate([q[0],q[1],p+3/2]) 
                    cylinder(d1=9,d2=7,h=3,center=true); 
            }
        }   
    }
}

module whole_case(only_bottom = true){
    difference(){
        difference(){
            group() {
                stand_off(holes);
                difference(){
                    difference(){
                        difference(){
                            complete_box();
                            translate([8 + extra_space_sdcard,0,23]){
                                cube([40,10,20]);
                            }
                        } 
                        translate([0,0,if(only_bottom) 36 else 100]){
                            cube([100,100,60]);
                        }
                    }
                    translate([box_length + 5,0,6]){
                        cube([10,100,15]);
                    }
                }
            }
            for (q=holes){
                translate([q[0]+eps,q[1]+eps,3/2]){
                    cylinder(d=3.5,h=20,center=true); 
                }
            }
        }
        translate([0,0,-4]) {
                for (q=holes){
                    translate([q[0]+eps,q[1]+eps,3/2]){
                        cylinder(d=6, h =4,  $fn=6);
                    }
                }
        }
    }
} 

module filtration_bottom(){
    rotate([90,90,0]){
        translate([-5,20,-50]){
            cube([10,50, 4]); 
        }
        translate([-5,20,-43]){
            cube([10,50, 4]); 
        }
        translate([-5,20,-35]){
            cube([10,50, 4]); 
        }
        translate([-5,20,-27]){
            cube([10,50, 4]); 
        }
        translate([-5,20,-19]){
            cube([10,50, 4]); 
        } 
    }
}

module filtration_back(){
    rotate([90,0,0]){
        translate([-5,10,-55]){
            cube([10,20, 5]); 
        }
        translate([-5,10,-45]){
            cube([10,20, 5]); 
        }
        translate([-5,10,-35]){
            cube([10,20, 5]); 
        }
        translate([-5,10,-25]){
            cube([10,20, 5]); 
        }
        translate([-5,10,-15]){
            cube([10,20, 5]); 
        }
    }
}

module usb_charging(){
   translate([box_length,2,29]){
        cube([8,15,8]);
    }
   translate([box_length,46,29]){
        cube([8,15,8]);
    }
}

module bottom_case() {
    difference(){
        difference(){
            difference(){
                whole_case(only_bottom = true);
                filtration_bottom();
            } 
            filtration_back();
        }
        usb_charging();
    }
}
 
module top_case_base() {
    difference(){
        whole_case(only_bottom = false);
        cube([100,100,36]);
    }
} 

module flipped_holes(){ 
    translate([0,0, full_rpi_stands_height]) {
        for (q=holes){
            translate([q[0], q[1], 3]) { 
                rotate([180, 0, 0])
                    cylinder(d1=9, d2=7, h=3);  
            }
        } 
    } 
}

module flipped_holes_inside(){
     for (q=holes){
        translate([q[0]+eps,q[1]+eps, box_height]){
            cylinder(d=6, h =4,  $fn=6);
        }
    } 
}

module screwholes(){
   for (q=holes){
        translate([q[0]+eps,q[1]+eps, 0]){
            cylinder(d=3.5, h =100);
        }
    } 
}

module box_aligner(){
    inset = p+p - 0;
    translate([inset/2,inset/2, 36]){ 
        translate([0, box_width/2, 0]){
            cube([1,5,5]);    
        }
        translate([box_length + 3, box_width/2, 0]){
            cube([1,5,5]);    
        }
        translate([55,0 , 0]){
            cube([5,1,5]);    
        }
        translate([55, box_width + 3, 0]){
            cube([5,1,5]);    
        }
    }
} 

module top_case(){ 
    difference(){
        group(){
            difference(){
                 top_case_base();   
                 flipped_holes_inside();
            }  
        }
        screwholes();
    }
//   box_aligner(); 
} 

top_case(); 
//bottom_case();