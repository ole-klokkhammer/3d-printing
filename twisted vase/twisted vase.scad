
$fn=3000; 

linear_extrude(height = 60, twist = 90, slices = 60) {
   difference() {
     offset(r = 10) {
      square(20, center = true);
     }
     offset(r = 8) {
       square(20, center = true);
     }
   }
 }