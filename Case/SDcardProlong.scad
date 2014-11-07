union(){
	cube([24,14,2]);
	difference(){
		translate([0,0,2])cube([24, 10,2]);
		translate([4,2,3])cube([16,3,2]);
	}
}