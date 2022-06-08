// CSG.scad - Basic example of CSG usage


cube(size = [10,10,10], center = true);

translate([0,0,0])
rotate([0,0,0])
import("Dali_Fazon_Mikro-wallmount_with_hinge-partB.stl", convexity=3);

