surroundHeight= 10;
radius = 6;
innerRadius = 5.7/2;
deep = 7;

intersection(){

    union(){
	
	difference(){
		cylinder(r1=radius+1.5,r2=radius, h=surroundHeight,$fn=60);
		cylinder(r1=innerRadius+0.5, r2=innerRadius, h=deep, $fn=60);
	}

	for (i=[0:15:360]) rotate([0,0,i]) 
		translate([radius-2,0,0])
		cube([3,0.75,surroundHeight]);

    }

	translate([0,0,-20])sphere(r=20+surroundHeight,$fn=60);

}