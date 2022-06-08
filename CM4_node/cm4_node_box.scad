 
$fn=30; 

wall_thickness=2;
board_holder_size_y=115;
board_holder_size_z=7;
board_holder_spacing = 1;
connectors_elevation=board_holder_size_z;

inner_size_y=board_holder_size_y + 60;
inner_size_x=200;
inner_size_z = 100 + board_holder_size_z;

module rotate_about_pt(a, v, pt) {
    translate(pt) {
        rotate(a,v) {
            translate(-pt) {
                children();
            }
        }
    }   
}

module board_holder(){
    translate([0,inner_size_x, 0]){
        rotate_about_pt(90,0,[inner_size_x,0,0]){  
            import ("board_holder.stl");     
        } 
    }
    translate([inner_size_x - 83, 15,0]) {
        cube([75,42,wall_thickness]);
    }
    translate([inner_size_x - 88, 65,0]) {
        cube([85,75,wall_thickness]);
    }
}

module connectors(){ 
    // Side panel holes for connectors
    translate([inner_size_x,23 + board_holder_spacing, 7+connectors_elevation]) cube([20,18,11],center=true);
    translate([inner_size_x,48 + board_holder_spacing, 7 + connectors_elevation]) cube([20,18,11],center=true);
    translate([inner_size_x,74 + board_holder_spacing,10 + connectors_elevation]) cube([20,15,18],center=true);
    translate([inner_size_x,93 + board_holder_spacing,10 + connectors_elevation]) cube([20,15,18],center=true);
    translate([inner_size_x,107.7 + board_holder_spacing,5 + connectors_elevation]) cube([20,10,7],center=true);
    translate([inner_size_x,122.5 + board_holder_spacing,5 + connectors_elevation]) cube([20,17,6],center=true);
    translate([inner_size_x,154 + board_holder_spacing,10 + connectors_elevation]) cube([20,13,13],center=true);
} 

module screw_holes(){
    hole=2; 
    s=1.5; 
    difference(){
        union(){ //screw holes
            translate([hole, hole, 26]) cylinder(7,2*s,2*s, center=true);
            translate([inner_size_x-hole, hole,26]) cylinder(7,2 * s, 2 * s, center=true);
            translate([hole,inner_size_y-hole, 26]) cylinder(7,2 * s, 2*s, center=true);
            translate([inner_size_x-hole, inner_size_y-hole, 26]) cylinder(7,2 * s, 2 * s, center=true); 
        } //screw holes 
        
        translate([hole,hole,35]) cylinder(30,s,s,center=true);
        translate([inner_size_x-hole,hole,35]) cylinder(30,s,s,center=true);
        translate([hole,inner_size_y-hole,35]) cylinder(30,s,s,center=true);
        translate([inner_size_x-hole,inner_size_y-hole,35]) cylinder(30,s,s,center=true);
        
        // spherical cutouts to avoid support needs. Quite pleased with these.
        translate([2*hole,2*hole,22]) sphere(4); 
        translate([inner_size_x-2*hole,2*hole,22]) sphere(4); 
        translate([2*hole,inner_size_y-2*hole,22]) sphere(4); 
        translate([inner_size_x-2*hole,inner_size_y-2*hole,22]) sphere(4);  
    }
}

module basic_box_with_connectors(){
    difference() { 
        minkowski(){  
            cube([inner_size_x,inner_size_y, 1]);  
            cylinder(inner_size_z - 1 + wall_thickness, wall_thickness, wall_thickness);  
        }  
        group(){
             translate([0, 0, wall_thickness]) {
                cube([inner_size_x, inner_size_y, inner_size_z + 1]); //inner cube
             }
            translate([0,0,0]){
                connectors(); 
            } 
        }        
    }
}  
 
module box_with_boardholder() {
    difference() {
        size_x = 166;
        size_y = 85;
        basic_box_with_connectors();
        translate([inner_size_x - size_y -board_holder_spacing, 2 + board_holder_spacing,-5]) {
            cube([size_y,size_x,15]);
        }
    }  
    translate([-1,1,0]){
        board_holder();
    }
}

module ventilation_back(){
    group(){
        vent_size=2;
        vent_height=60;
        start_pos_z = 20; 
        for (x = [15:5:160]) {
            for (y = [18:5:80]) {
                translate([inner_size_x - 6, x, start_pos_z + y]) 
                    rotate([0,90,0])
                        cylinder(h=15,r=vent_size,$fn=25);
            }  
        }  
    }
}

module ventilation_side() {
    group() {
        vent_size=2;
        vent_height=60;
        start_pos_z = 0; 
        group(){
            for (x = [15:5:120]) {
                for (y = [18:5:80]) {
                    translate([inner_size_x - x, inner_size_x - 20, start_pos_z + y]) 
                        rotate([90,0,0])
                            cylinder(h=200,r=vent_size,$fn=25);
                }  
            }  
        }
    }
}

module ventilation_bottom(){
    group() {
        vent_size=2;
        vent_height=60;
        start_pos_z = 10; 
        group(){
            for (x = [12:5:100])
                for (y = [12:5:160])
                    translate([x,y,-5])
                        cylinder(h=10,r=vent_size,$fn=25);
        }
    }
}

module box_with_ventilation(){
     difference() { 
        difference() {  
              box_with_boardholder();
               ventilation_back();
         }  
        ventilation_side();
    }
}  

module points_to_fasten_elements(){ 
    ventilation_bottom();
        
}
// 140 - 36

 
box_with_ventilation();





