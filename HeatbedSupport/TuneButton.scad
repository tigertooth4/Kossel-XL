m3NutRadius = 2.8;

outerRadius1 = 4;
outerRadius2 = 7;
innerRadius = 1.8;

$fn=40;

module tuneButton(){
    difference(){
	union(){
	    cylinder(r1=outerRadius1,r2=outerRadius2, h =5,center=true);
	    for(i=[0:30:360])rotate([0,0,i])translate([3,0,-3])
	    minkowski(){
		hull(){
		    translate([2,0,4])cube([5,1,2],center=true);
		    translate([1,0,2])cube([2,2,2],center=true);
		}
		cylinder(r=0.5,h=0.5);
	    }
	}
	    
	cylinder(r=innerRadius, h =9,center=true);
	translate([0,0,1.5])cylinder(r=m3NutRadius+.5, h =4, center=true, $fn=6);
    }

    
}

tuneButton();