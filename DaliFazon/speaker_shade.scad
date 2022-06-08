

module curved_plane(angle, radius, height, thickness) {   
    r = radius; 
    a = angle;  
    translate([0,0,height/2]){        
        rotate_extrude(angle = a, convexity = 10, $fn= 500){
            translate([r, 0, 0]) {  
                square(size = [thickness, height], center = true);
            }
        }
    } 
}
 
module hexpattern(radius = 105, height = 190) {
    rod_length = radius;
    rod_diameter = 11;
    tilt_angle = 7;
    height_step = 10;
 
    translate([0, 5, 0]){ 
        for (height = [ 4 : height_step : height ]){
            stepNumber = height / height_step; 
            step = stepNumber * (3.5) ; 
            translate([0, 0, height]){
                for (azimuth = [ 0 : tilt_angle : 360 ]) { 
                    rotate([step, 90, azimuth]) {  
                        cylinder(h = rod_length, d = rod_diameter, $fn=6);
                    }
                }
            } 
        } 
    }
}

plane_angle = 180;
plane_thickness = 2;
plane_radius = 95;
plane_height = 200;
oval_factor = 1.5;
hex_radius = 105;
hex_height = 170;

 
resize([0, plane_radius*oval_factor, 0]){
    difference() {
        curved_plane(plane_angle, plane_radius, plane_height, plane_thickness); 
        translate([0,0,15]){
            hexpattern(hex_radius, hex_height);       
        }
    }
}
 
curved_plane(2, plane_radius - 14, plane_height, 30); 
rotate([0, 180, 0]){
    translate([0, 0, -plane_height]) {
        curved_plane(2, plane_radius - 14, plane_height, 30); 
    }
}
