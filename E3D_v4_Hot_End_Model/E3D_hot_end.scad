//Stand in model for the E3D v4 hot end
//Fan mount borrowed from thing:71073 - thanks!
//I don't guarentee the total length of this model being correct
//The all important mount-point, however, was modeled from measurements taken
//from my actual hot end

color("red"){ 
translate([-17.1,-93.5,-117]) rotate([90,0,90]) import("E3d-Fan-Mount.stl");}
	//begin hot end
color("silver"){
difference(){
	//top mounting point
union(){
translate([0,0,8.64]) cylinder(3.66,8,8);
cylinder(12.3,6,6);
cylinder(3.04,8,8);
	//small thermal break
translate([0,0,-6.6]) cylinder(6.6,4.575,4.575);
translate([0,0,-4.15]) cylinder(1.9,8,8);
	//big thermal break
translate([0,0,-38.14]) cylinder(31.54,4.575,4.575); //smallest inner shaft
translate([0,0,-38.14]) cylinder(18.88,6.5,6.5); //medium inner shaft
translate([0,0,-38.14]) cylinder(14.66,7.5,7.5); //large-bottom inner shaft
for (z = [0:7]){
translate([0,0,-8.8-4.2*z]) cylinder(2,12.5,12.5);}} //heatsink fins
	//through and through hole
union(){
translate([0,0,10.31]) cylinder(2,1,4.465); //filament funnel - from ref. drawing
translate([0,0,-39.1]) cylinder(51.4,1,1,$fn=20);}}} //filament hole
	
	//begin heater block (from ref. drawings and extrapolation, not measured)
color("gray"){
translate([0,0,-40.14]) cylinder(2.1,1.2,1.2);
difference(){
translate([-4,-7.5,-48.14]) cube([15,15,8]);
union(){
translate([7,8,-44.14]) rotate([90,0,0]) cylinder(16,2,2,$fn=20);
translate([9,-4.5,-46.9]) rotate([90,0,0]) cylinder(3.1,.5,.5,$fn=20);}}}
translate([0,0,-51.14]) cylinder(3,4,4,$fn=6);
color("goldenrod") translate([0,0,-53.14]) cylinder(2,.4,3.5,$fn=20);