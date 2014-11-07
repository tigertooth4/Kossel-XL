Ri = 18.5;
thick = 6;
Ro = Ri + thick;
width = 19;
extrusion = 20;

m3ScrewRadius = 1.5;
m3ScrewHeadRadius = 3;
m3NutRadius=3;

m4ScrewRadius = 2;
m4ScrewHeadRadius = 3.7;
m4NutRadius=3.9;


$fn = 60;


module extruderMount(){

    difference(){

	union(){
	    // groove part
	    cylinder(r=Ro, h=width);
	    translate([Ri,-thick*2.5/2,0])
	    minkowski(){
		translate([0,0,2])cube([12,thick*2.5,width-4]);
		rotate([90,0,0])cylinder(r=2,h=1,center=true);
	    }

	    // mount part
	    translate([-width/2,thick-5,0])cube([width,Ro,width]);
	    hull(){
		translate([-width/2,Ro-5,0])cube([width,thick,width]);
		translate([0, Ro+extrusion/2-5,.5])cube([Ri*1.5, extrusion, 1],center=true);
	    }
		    
	    //mount plate
	    translate([0, Ro+extrusion/2-2,-thick*.2])
	    minkowski(){
		cube([Ri*2.5,extrusion-8,thick],center=true);
		cylinder(r=4, h=2,center=true);
	    }

	    translate([0,Ro+extrusion/2-2,-thick+1.5])rotate([0,90,0])cylinder(r=2,h=Ri*2.5, center=true);
	}
	
	cylinder(r=Ri, h=width);
	translate([Ri/2,-thick*.25,-1])cube([Ri+15,thick*.5,width+2]);

	//leave some holes 
	for(i=[45:90:360]) rotate([0,0,i]) translate([Ri-1,0,width/2]) rotate([0,90,0])
	cylinder(r1=2,r2=4,h=1.2*thick);

	// screws hole
	for(i=[width*.75,width*.25]) translate([Ro+3,0,i])
	{
	    rotate([90,0,0])cylinder(r=m4ScrewRadius, h=20,center=true);
	    
	    rotate([90,0,0])translate([0,0,-thick*1.25])
	    cylinder(r=m4ScrewHeadRadius, h=thick*.4, center=true);
	    
	    rotate([90,0,0])translate([0,0,thick*1.25])
	    cylinder(r=m4ScrewHeadRadius, h=thick*.4, $fn=6, center=true);
	}

	// screw hole for mount
	for(i=[1,-1])
	translate([i*Ri, Ro + extrusion/2-2,thick*.5])
	{
	    cylinder(r=m4ScrewRadius, h=30,center=true);
	    cylinder(r=m4ScrewHeadRadius, h=thick, center=true);
	}

	//translate([0, Ro+extrusion*1.1/2+5,thick*.5])
	//cylinder(r1=m4ScrewRadius,r2=m4ScrewRadius+6, h=20,center=true);

    }
    
}

extruderMount();