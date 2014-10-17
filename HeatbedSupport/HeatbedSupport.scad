mountDistance= 133;
boardMountDistance = 86.75;
thick=10;
extrusion=20;

m4ScrewRadius = 2;
m4ScrewHeaderRadius = 4;

m3ScrewRadius = 1.5;
m3ScrewHeaderRadius = 3;
m3NutRadius= 3.5;

circleOuterRadius=40;
circleInnerRadius=40-extrusion/2;

hbsupportDistance = 150;

centerArmLength=hbsupportDistance/2 +5;

module hbsupport(){

    difference(){
	union(){
	    hull()
	    {
		for(i=[-mountDistance/2,mountDistance/2])
		translate([i,0,0])cylinder(r=extrusion/2,h=thick,center=true);
		
		//hull()
		for(i=[-boardMountDistance/2,boardMountDistance/2])
		translate([i,extrusion/2,0])cylinder(r=extrusion/2,h=thick,center=true);
	    }

	    // spring fixing poles
	    for(i=[-boardMountDistance/2,boardMountDistance/2])
	    translate([i,extrusion/3,thick-2]){
		//cylinder(r1=3.5,r2=3, h=20,center=true,$fn=20);
		cylinder(r1=extrusion/2, r2=extrusion/2-2,h=5, center=true, $fn=40);
	    }
	    
	    hull()
	    for(y=[extrusion/2, 3*extrusion])
	    translate([0,y,0]) cylinder(r=extrusion*.4,h=thick,center=true, $fn=6);
	}

	// m4 screw hole to mount on the aluminum
	for(i=[-1,1])
	{
	    hull()for(j=[0,10])translate([(mountDistance/2-j)*i,0,0])
	    cylinder(r=m4ScrewRadius,h=thick*2,center=true, $fn=20);
	    
	    hull()for(j=[0,10])translate([(mountDistance/2-j)*i,0,0])
	    translate([0,0,thick/2])cylinder(r=m4ScrewHeaderRadius, h= 4, center=true, $fn=20);
	}

	// m4 screw hole to mount the plate
	for(i=[-boardMountDistance/2,boardMountDistance/2])
	translate([i,extrusion/3,0]){
	    cylinder(r=m3ScrewRadius+.5, h=thick*5,center=true,$fn=20);
	    translate([0,0,-2])cylinder(r=m3ScrewHeaderRadius+1, h=thick*.8, center=true, $fn=20);
	}

	// for space to make the connections
	translate([0,3*extrusion,thick/2])
	{
	    cylinder(r=extrusion*.8, h=thick,center=true, $fn=10);
	    cylinder(r=m3ScrewRadius, h=thick*5,center=true, $fn=20);
	    translate([0,0,-thick])cylinder(r=m3NutRadius,h=thick/3, center=true, $fn=6);
	}

	// leave some holes
	for(i=[-extrusion,0, extrusion]) translate([i,extrusion/3,0])
	cylinder(r=extrusion/3, h=thick*2,center=true, $fn=20);

    }
	
}



module centerSupport(){
    // circle in the middle
    difference(){
	cylinder(r=circleOuterRadius, h=thick, $fn=60);
	translate([0,0,-1])cylinder(r=circleInnerRadius, h=thick*2, $fn=60);
    }

    // 3 arms
    difference(){
	for(i=[0,120,240])rotate([0,0,i+30])
	hull(){
	    translate([0,-centerArmLength,0])cylinder(r=extrusion*.4,h=thick,$fn=6);
	    translate([0,0,0])cylinder(r=extrusion*.4,h=thick,$fn=20);
	}

	// m3 screw at the center
	cylinder(r=m3ScrewRadius, h=thick*5, center=true, $fn=20);
	cylinder(r=m3ScrewHeaderRadius, h=thick, center=true, $fn=20);

	// m3 screw at the cross of circle and arm
	for(i=[0,120,240]) rotate([0,0,i+30])
	translate([0,-circleOuterRadius-10,0]){
	    cylinder(r=m3ScrewRadius, h=thick*3, center=true, $fn=20);
	    translate([0,0,-1]) cylinder(r=m3ScrewHeaderRadius, h=thick/2, $fn=20);
	}

	// spaces and m3 screw holes at the end of the arm
	for(i=[0,120,240])rotate([0,0,i+30])
	{
	    hull() for(j=[-2,10])
	    translate([0,-centerArmLength+j,0])cylinder(r=m3ScrewRadius,h=thick*2,$fn=20);

	    hull() for(j=[-2,10])
	    translate([0,-centerArmLength+j,-2])cylinder(r=extrusion*.5, h=thick/2+1,$fn=6);

	    hull() for(j=[-2,10])
	    translate([0,-centerArmLength+j,thick*.75])cylinder(r=m3ScrewHeaderRadius,h=3,$fn=20);
	}

	
    }
    
    
}

//for(i=[0,120,240])rotate([0,0,i+30])translate([0, -hbsupportDistance,thick/2])
//hbsupport();

centerSupport();