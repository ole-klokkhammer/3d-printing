/////////////////////////////////////
//
// A Base for a 5th Generation Intel NUC base.
// 
// It uses a parameteric lipped
// box model, plugs in the nuc
// dimensions and adds base slits
// and vesa mounting holes
//
// It includes the tab cut outs
// for the 5th generation base
//
// Units: mm
//
// David Johnston. dj@deadhat.com
//
// V1 : Uploaded to Thingiverse Sept 4th, 2015
//
// V2 : Fixes screw channels to hang on to the screw
//    : that comes with the NUC rather than needing
//    : a longer screw.
//    : Changed to logo built from paths2openscad
//    : from logo in Inkscape. So no file dependencies.
//    : Uploaded Sept 5th, 2015
//
////////////////////////////////

module lipped_box(height, depth, width, thickness, corner_radius, lip_height, lip_thickness, floor_thickness) {
    $fn=100;
    difference() {
        union() {
            // The main box with rounded corners
            translate([corner_radius,corner_radius,0]) {
                minkowski() {
                    cube([width-(corner_radius*2),depth-(corner_radius*2),height-1]);
                    cylinder(r=corner_radius,h=1);
                };
            };
            
            // The lip - an interior box that is skinnier and higher.
            translate([corner_radius,corner_radius,0]) {
                minkowski() {
                    cube([width-(corner_radius*2),depth-(corner_radius*2),height+lip_height-1]);
                    cylinder(r=corner_radius-(thickness-lip_thickness),h=1);
                };
            };
        };
        
        // The hole in the middle
        translate([corner_radius,corner_radius,floor_thickness]) {
            minkowski() {
                cube([(width-(corner_radius*2)),  (depth-(corner_radius*2))  , height]);
                cylinder(r=corner_radius-thickness,h=1);
            };
        };
    };
}; 

module nuc_box(height,model) {
    //if (model==5) { 
        depth=111.5;
        width=115.7;
        thickness=4;
        corner_radius=8;
        lip_height=2;
        lip_thickness=1.5;
        floor_thickness=4;
        slit_width=5;
        RJ45_space_from_floor=16;
        RJ45_xpos=50;
        hd_post_spacing_x=76.6;
        hd_post_spacing_y=61.71;
        hd_post_rise=2;
        hd_post_radius=5;
        hd_screw_hole_radius=1.5;
        hd_screw_head_radius=3.75;
        hd_screw_recess_depth=2.5;
        hd_mounting_offset=1.5;
        foot_hole_spacing_x=90;
        foot_hole_spacing_y=85;
        foot_hole_internal_radius=1.1;
        foot_hole_offset=15;
        vesa_hole_spacing=85;
        vesa_hole_internal_radius=1.1;
        dimple_spacing=25.6;
        front_dimple_spacing=18;
        front_dimple_start=47.15;
        front_dimple_width=1.5;
        
        screw_post_x_inset=10.1;       // Measured
        screw_post_y_inset=10.25;      // Measured
        screw_post_width_spacing=95;   // From the board spec from intel
        screw_post_depth_spacing=90.5; // From the board spec from intel
    
        screw_post_lower_wall_thickness=1.5;
        screw_post_upper_wall_thickness=2.0;
        screw_post_lower_height=height+4;
        screw_post_extra_height=2.5; // More tube above the base of the disc.
        screw_post_head_depth=height; // The bottom of the disc the holds the screw head down.
        screw_post_upper_hole_diameter = 6.0; // The hole through which the screw shaft goes. Shaft diameter=5.1mm measured
        screw_post_lower_hole_diameter = 12; // The hole into which the screw head drops. Head diameter=6.7mm measured
        
        show_labels=0;
        show_wall_text=0;
        show_ethernet_port=1;
        show_hd_posts=1;
        show_hd_indentations=1;
        show_vesa_holes=0;
        show_slits=0;
        show_screw_posts=1;
        show_foot_holes=0;

    //};
    
    difference () {
        union() {
            lipped_box (height, depth, width, thickness, corner_radius, lip_height, lip_thickness, floor_thickness);
            
            // The solid part of the screw posts
            screw_post_lower_diameter = (screw_post_lower_wall_thickness*2)+screw_post_lower_hole_diameter;
            screw_post_upper_diameter = (screw_post_upper_wall_thickness*2)+screw_post_upper_hole_diameter;
            if (show_screw_posts==1) {
                translate([screw_post_x_inset,  screw_post_y_inset,  0]) {
                    cylinder(r=(screw_post_lower_diameter/2),h=screw_post_lower_height,$fn=100);
                    cylinder(r=(screw_post_upper_diameter/2),h=screw_post_lower_height+screw_post_extra_height,$fn=100);
                };
                translate([screw_post_x_inset+screw_post_width_spacing,  screw_post_y_inset,  0]) {
                    cylinder(r=(screw_post_lower_diameter/2),h=screw_post_lower_height,$fn=100);
                    cylinder(r=(screw_post_upper_diameter/2),h=screw_post_lower_height+screw_post_extra_height,$fn=100);
                };
                translate([screw_post_x_inset,  screw_post_y_inset+screw_post_depth_spacing,  0]) {
                    cylinder(r=(screw_post_lower_diameter/2),h=screw_post_lower_height,$fn=100);
                    cylinder(r=(screw_post_upper_diameter/2),h=screw_post_lower_height+screw_post_extra_height,$fn=100);
                };
                translate([screw_post_x_inset+screw_post_width_spacing,  screw_post_y_inset+screw_post_depth_spacing,  0]) {
                    cylinder(r=(screw_post_lower_diameter/2),h=screw_post_lower_height,$fn=100);
                    cylinder(r=(screw_post_upper_diameter/2),h=screw_post_lower_height+screw_post_extra_height,$fn=100);
                };
            };
            
            // Bracing between the screw posts and walls
                //West side x braces
                translate([0.1,screw_post_y_inset-1,floor_thickness-1]) {
                    cube([(screw_post_x_inset)-(screw_post_lower_diameter/2)+(screw_post_lower_wall_thickness/2),2,(height*(2/3))]);
                }
                translate([0.1,screw_post_y_inset+screw_post_depth_spacing-1,floor_thickness-1]) {
                    cube([(screw_post_x_inset)-(screw_post_lower_diameter/2)+(screw_post_lower_wall_thickness/2),2,(height*(2/3))]);
                }
                //East side x braces
                translate([(screw_post_x_inset+screw_post_width_spacing)+(screw_post_lower_diameter/2)-(screw_post_lower_wall_thickness/2),screw_post_y_inset-1,floor_thickness-1]) {
                    cube([(screw_post_x_inset)-(screw_post_lower_diameter/2)+(screw_post_lower_wall_thickness/2),2,(height*(2/3))]);
                }
                translate([(screw_post_x_inset+screw_post_width_spacing)+(screw_post_lower_diameter/2)-(screw_post_lower_wall_thickness/2),screw_post_y_inset+screw_post_depth_spacing-1,floor_thickness-1]) {
                    cube([(screw_post_x_inset)-(screw_post_lower_diameter/2)+(screw_post_lower_wall_thickness/2),2,(height*(2/3))]);
                }
                //West side y braces
                translate([screw_post_x_inset-1,0.1,floor_thickness-1]) {
                    cube([2,(screw_post_y_inset)-(screw_post_lower_diameter/2)+(screw_post_lower_wall_thickness/2),(height*(2/3))]);
                }
                translate([screw_post_x_inset-1,(screw_post_y_inset+screw_post_depth_spacing)+(screw_post_lower_diameter/2)-(screw_post_lower_wall_thickness/2),floor_thickness-1]) {
                    cube([2,(screw_post_y_inset)-(screw_post_lower_diameter/2)+(screw_post_lower_wall_thickness/2),(height*(2/3))]);
                }
                //East side y braces
                translate([screw_post_x_inset+screw_post_width_spacing-1,0.1,floor_thickness-1]) {
                    cube([2,(screw_post_y_inset)-(screw_post_lower_diameter/2)+(screw_post_lower_wall_thickness/2),(height*(2/3))]);
                }
                translate([screw_post_x_inset+screw_post_width_spacing-1,(screw_post_y_inset+screw_post_depth_spacing)+(screw_post_lower_diameter/2)-(screw_post_lower_wall_thickness/2),floor_thickness-1]) {
                    cube([2,(screw_post_y_inset)-(screw_post_lower_diameter/2)+(screw_post_lower_wall_thickness/2),(height*(2/3))]);
                }
                

            // The solid part of the HD posts.
            if (show_hd_posts==1) {
                // hd mounting posts
                translate([((width-hd_post_spacing_x)/2)+(hd_mounting_offset)+4.4,(depth-hd_post_spacing_y)/2,0]) {
                    cylinder (h=(hd_post_rise+floor_thickness),r=hd_post_radius,$fn=100);
                };
                translate([((width+hd_post_spacing_x)/2)+(hd_mounting_offset)+4.4,(depth-hd_post_spacing_y)/2,0]) {
                    cylinder (h=(hd_post_rise+floor_thickness),r=hd_post_radius,$fn=100);
                };
                translate([((width-hd_post_spacing_x)/2)+(hd_mounting_offset)+4.4,(depth+hd_post_spacing_y)/2,0]) {
                    cylinder (h=(hd_post_rise+floor_thickness),r=hd_post_radius,$fn=100);
                };
                translate([((width+hd_post_spacing_x)/2)+(hd_mounting_offset)+4.4,(depth+hd_post_spacing_y)/2,0]) {
                    cylinder (h=(hd_post_rise+floor_thickness),r=hd_post_radius,$fn=100);
                };
            };
        };
        
        // Everything from here on are subtractions from the solid shapes so far.
 
        
        if (show_hd_posts==1) {
            // hd mounting post holes
                translate([((width-hd_post_spacing_x)/2)+(hd_mounting_offset)+4.4,(depth-hd_post_spacing_y)/2,-1]) {
                    cylinder (h=(hd_post_rise+floor_thickness)+2,r=hd_screw_hole_radius,$fn=100);
                };
                translate([((width+hd_post_spacing_x)/2)+(hd_mounting_offset)+4.4,(depth-hd_post_spacing_y)/2,-1]) {
                    cylinder (h=(hd_post_rise+floor_thickness)+2,r=hd_screw_hole_radius,$fn=100);
                };
                translate([((width-hd_post_spacing_x)/2)+(hd_mounting_offset)+4.4,(depth+hd_post_spacing_y)/2,-1]) {
                    cylinder (h=(hd_post_rise+floor_thickness)+2,r=hd_screw_hole_radius,$fn=100);
                };
                translate([((width+hd_post_spacing_x)/2)+(hd_mounting_offset)+4.4,(depth+hd_post_spacing_y)/2,-1]) {
                    cylinder (h=(hd_post_rise+floor_thickness)+2,r=hd_screw_hole_radius,$fn=100);
                };
           // hd mounting post recessments
                translate([((width-hd_post_spacing_x)/2)+(hd_mounting_offset)+4.4,(depth-hd_post_spacing_y)/2,-1]) {
                    cylinder (h=(hd_screw_recess_depth)+1,r=hd_screw_head_radius,$fn=100);
                };
                translate([((width+hd_post_spacing_x)/2)+(hd_mounting_offset)+4.4,(depth-hd_post_spacing_y)/2,-1]) {
                    cylinder (h=(hd_screw_recess_depth)+1,r=hd_screw_head_radius,$fn=100);
                };
                translate([((width-hd_post_spacing_x)/2)+(hd_mounting_offset)+4.4,(depth+hd_post_spacing_y)/2,-1]) {
                    cylinder (h=(hd_screw_recess_depth)+1,r=hd_screw_head_radius,$fn=100);
                };
                translate([((width+hd_post_spacing_x)/2)+(hd_mounting_offset)+4.4,(depth+hd_post_spacing_y)/2,-1]) {
                    cylinder (h=(hd_screw_recess_depth)+1,r=hd_screw_head_radius,$fn=100);
                };
        };
            
        if (show_hd_indentations==1) {
            // left hd indentation
                translate([(width-(width-2)),(depth/2)-(75/2),5]) {
    cube([2,75,20]);
            };
            // right hd indentation
                translate([(width-4),(depth/2)-(75/2),5]) {
    cube([2,75,20]);
            };
        };   
         
        
        // Cutouts for the tabs on 5th gen NUCs near the base screws
        translate([-1,screw_post_y_inset-1.5,height]) {
            cube([thickness+2,3,lip_thickness+1]);
        };
        translate([width-1-thickness,screw_post_y_inset-1.5,height]) {
            cube([thickness+2,3,lip_thickness+1]);
        };
        translate([-1,depth-screw_post_x_inset-1.5,height]) {
            cube([thickness+1,3,lip_thickness+1]);
        };
        translate([width-1-thickness,depth-screw_post_x_inset-1.5,height]) {
            cube([thickness+2,3,lip_thickness+1]);
        };
        
        // Cutouts for the side dimples
        translate([-1,((depth-dimple_spacing)/2)-0.5,height]) {
            cube([width+2,2.5,lip_thickness+1]);
        };
        translate([-1,((depth+dimple_spacing)/2)+0.5-2.5,height]) {
            cube([width+2,2.5,lip_thickness+1]);
        };
        
        // Cutouts for the front dimples
        front_dimple_spacing=18;
        front_dimple_start=47.15;
        front_dimple_width=3;
        translate([front_dimple_start-(front_dimple_width/2),-1,height]) {
            cube([front_dimple_width,thickness+2,lip_thickness+1]);
        };
        translate([front_dimple_start+front_dimple_spacing-(front_dimple_width/2),-1,height]) {
            cube([front_dimple_width,thickness+2,lip_thickness+1]);
        };
        
        if (show_ethernet_port==1) {
            // Holes for an ethernet connector
            // The RJ45 Hole
            translate([RJ45_xpos,depth-10,floor_thickness+RJ45_space_from_floor]) {
                cube([16.76,20,14.22]);
            };
            // Holes for the status lights;
            translate([RJ45_xpos+16.76+1+1.5,depth-10,floor_thickness+RJ45_space_from_floor+4]) {
                rotate([-90,0,0]) cylinder(h=20,r=1.5,$fn=100);
            };
            translate([RJ45_xpos+16.76+1+1.5,depth-10,floor_thickness+RJ45_space_from_floor+8]) {
                rotate([-90,0,0]) cylinder(h=20,r=1.5,$fn=100);
            };
        };

        // the holes in the screw posts.
        // A wider one for the screw to go down into to
        // be able to reach the nut and a narrower one all
        // the way through for the screw to go through.
        if (show_screw_posts==1) {
            translate([screw_post_x_inset,screw_post_y_inset,-1]) {
                cylinder(r=(screw_post_upper_hole_diameter/2),h=height+screw_post_extra_height+10,$fn=100);
                cylinder(r=(screw_post_lower_hole_diameter/2),h=screw_post_lower_height,$fn=100);
            };
            translate([screw_post_x_inset+screw_post_width_spacing,screw_post_y_inset,-1]) {
                cylinder(r=(screw_post_upper_hole_diameter/2),h=height+screw_post_extra_height+10,$fn=100);
                cylinder(r=(screw_post_lower_hole_diameter/2),h=screw_post_lower_height,$fn=100);
            };
            translate([screw_post_x_inset,screw_post_y_inset+screw_post_depth_spacing,-1]) {
                cylinder(r=(screw_post_upper_hole_diameter/2),h=height+screw_post_extra_height+10,$fn=100);
                cylinder(r=(screw_post_lower_hole_diameter/2),h=screw_post_lower_height,$fn=100);
            };
            translate([screw_post_x_inset+screw_post_width_spacing,screw_post_y_inset+screw_post_depth_spacing,-1]) {
                cylinder(r=(screw_post_upper_hole_diameter/2),h=height+screw_post_extra_height+10,$fn=100);
                cylinder(r=(screw_post_lower_hole_diameter/2),h=screw_post_lower_height,$fn=100);
            };
        };        
    };
 

    
    // An 2.5" HD to show the space in the box.
    // Drive measurements are 100.5mm * 69.85mm * 10mm  
   // rotate([90,90,0])
    //    translate([((width/2)-(100.5/2))+4.4-110+hd_mounting_offset,(depth/2)-(69.85/2),floor_thickness+hd_post_rise]) {
           // cube([100.5,69.85,10]);
          // };
    
    // A centered y-brace
    translate([width/2,depth/2.05,1]) scale([width/10,depth/2,2]) cube(1, center=true);  
};

nuc_box(height=40);

