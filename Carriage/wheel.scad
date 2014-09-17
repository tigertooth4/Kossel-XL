$fn = 60;

err = 0.1;
module wheel(r, holeRadius, thick){
	deducedRadius = r - thick/2;
	difference(){
		union(){
			rotate_extrude(convexity = 30){ translate([deducedRadius, 0, 0]) circle(r = thick/2, center=true); }	
			translate([0,0,-thick/2])	cylinder(r=deducedRadius, h = thick);
	}

	translate([0,0, -thick/2-err]) cylinder(r=holeRadius, h=thick+2*err);
}}

wheel(9.5,2,5);

