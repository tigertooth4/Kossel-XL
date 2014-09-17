//This is based on the Atom 3dp design

extrusion = 20;
err = 0.2;
channelWidth= 4;
channelWidthInside=8.5;
channelDeep = 6;

outRoundness = .5*extrusion;
innerRoundness = 0.2*extrusion;
endRoundness = 0.08* extrusion;

armLength = extrusion * 2.7;


//height = extrusion;

sqrt3 = 1.7321;

m25ScrewRadius = 1.25; 

m4ScrewRadius = 2.0; //for M4 bolt
m4ScrewHeadRadius = 4.0; 
m4NutRadius = 4.3;

m5NutRadius = 8/sqrt3+0.2;

m3ScrewRadius = 1.5; //for M3 bolt
m3ScrewHeadRadius = 3.0; 
m3NutRadius = 3.5; //

module endstop(){
    difference(){
	
	union(){
	    minkowski(){
		cube([16,8,13],center=true);
		rotate([90,0,0])cylinder(r=2,h=1,center=true);
	    }
	    translate([0,5,-5])cylinder(r=2.5, h=7,center=true,$fn=10);
	}

	translate([0,0,3])rotate([90,0,0])cylinder(r=m4ScrewRadius, h=20,center=true,$fn=20);
	translate([0,-3.5,3])rotate([90,0,0])cylinder(r=m4ScrewHeadRadius, h=6,center=true,$fn=20);
	

	translate([4.75,0,-3])rotate([90,0,0])cylinder(r=m25ScrewRadius, h=20,center=true,$fn=20);
	translate([-4.75,0,-3])rotate([90,0,0])cylinder(r=m25ScrewRadius, h=20,center=true,$fn=20);
    }
    
}

endstop();