 
$fn=30; 

module holder(){   
    arm();       
}

module arm() { 
    rotate([90,0,00]) {
            scale([1, 1, 1 ])
                import ("arm.stl");      
       }
}


holder();

// 71mm
// 71 - 3 = 68mm

// + 3mm

//74 / 55 