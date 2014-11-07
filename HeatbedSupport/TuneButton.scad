m3NutRadius = 3.1;

outerRadius1 = 4;
outerRadius2 = 5.5;
innerRadius = 1.8;

$fn=40;

module tuneButton(){
    difference(){
	union(){
	    cylinder(r=outerRadius2, h=3);
	    cylinder(r1=outerRadius1, r2=outerRadius1+1, h =5,center=true);
/*	    for(i=[0:30:360])rotate([0,0,i])translate([3,0,-3])
	    minkowski(){
		hull(){
		    translate([0,0,5])cube([2,1,2],center=true);
		    translate([0,0,3])cube([2,2,2],center=true);
		}
		cylinder(r=0.5,h=0.5);
	    }*/
	}

	for (i=[0:30:360]) rotate([0,0,i])translate([5.5,0,0]) cylinder(r=1, h=20,center=true);
	cylinder(r=innerRadius, h =12,center=true);
	translate([0,0,-3])cylinder(r=m3NutRadius, h =4, center=true, $fn=6);
    }

    
}

tuneButton();