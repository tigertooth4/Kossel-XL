surroundHeight= 8;
radius = 12;

difference(){

    union(){
	
	intersection(){
	    difference(){
		cylinder(r=radius, h=surroundHeight, center=true,$fn=60);
		translate([0,0,-2])cylinder(r=radius-3, h=surroundHeight,center=true, $fn=60);
		
		for (i=[0:12:360]) rotate([0,0,i]) translate([radius+1,0,surroundHeight/2-3])
		cube([3,1,surroundHeight],center=true);
	    }
	    
	    translate([0,0,-35])sphere(r=40,$fn=60);
	}
	translate([0,0,-surroundHeight/2-2])
	difference(){
	    
	    cylinder(r1=5.5, r2=7,h=surroundHeight, $fn = 60);
	    translate([0,0,-.5])cylinder(r1=4, r2=2.5 ,h=surroundHeight, $fn=60);
	    
	    
	}
    }

    translate([radius/2,0,surroundHeight+3])sphere(r=8, $fn=60);
}