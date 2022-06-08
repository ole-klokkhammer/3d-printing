
translate([0,0,3.5]){
    rotate([90,180,0]){
        thing();
    }  
}


module thing(){
    translate([-2,0,5]){
        cube([2,7,10], center=true);
    }

    translate([-1,0,2.5]){
        cube([2,7,5], center=true);
    }

    translate([1,0,1]){
        cube([2,7,12], center=true);
    }
}