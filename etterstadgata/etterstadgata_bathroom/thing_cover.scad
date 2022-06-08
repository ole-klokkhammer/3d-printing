 // CSG.scad - Basic example of CSG usage

$fn=50;

 
base2();


module base() { 
    difference() {
        circle(d=160, center=true);
    }
} 


 
module base2() { 
    linear_extrude(3)
        difference() {
            circle(d = 160.0); 
            for(diameter = [140:-20:80])
                for(i = [0 : 360])
                    rotate(i * 10)
                        translate([0,  diameter / 2])
                            circle(d = 6); 
        }
}
