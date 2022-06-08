
cube_x= 130;  
cube_y= 130;  
cube_z= 35;    
pot_x= 60;
pot_y = 60;
pot_z = 60;
 
 

difference(){
    translate([-(cube_x/2),-(cube_y/2),0]){
        cube([cube_x, cube_y, cube_z]);
    }
	translate([0,0,1]){
		cylinder(pot_x,pot_y,pot_z); 
    }
    translate([(cube_x/2.5), (cube_y/2.5), 1]){
		cylinder(40,5,5);
    }
    translate([-(cube_x/2.5), (cube_y/2.5), 1]){
		cylinder(40,5,5);
    }
    translate([-(cube_x/2.5), -(cube_y/2.5), 1]){
		cylinder(40,5,5);
    }
    translate([(cube_x/2.5), -(cube_y/2.5), 1]){
		cylinder(40,5,5);
    }
} 