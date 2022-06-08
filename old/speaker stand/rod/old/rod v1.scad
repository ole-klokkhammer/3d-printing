
 
difference(){
    mainStructure();
    cylinder(140,5, 5);
}

module mainStructure(){
    top();
    difference(){
        rod();
        bottom(); 
    }
}

module rod(){
    cylinder(125,10, 10);
    
}

module bottom (){
    translate([0,0,0]){
        cylinder(10,7, 7);
    }
}

module top(){
    translate([0,0,125]){
        cylinder(10,7, 7);
    }
}