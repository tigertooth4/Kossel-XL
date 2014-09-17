extrusion=20+1;
roundness=6;

m4ScrewRadius=2;
m4ScrewHeadRadius=4;
//draw two extrusion
//%translate([0,32,15])cube([100,extrusion,extrusion],center=true);
//%translate([0,32,-15]) cube([100,extrusion,extrusion],center=true);

module powerBox(){
    difference(){
	// main part
	translate([0,10,0])
	minkowski(){
	    cube([50-roundness*2,50-roundness*2,58],center=true);
	    cylinder(r=roundness,h=1,$fn=20);
	}

	// aluminum mount
	translate([0,28,15])cube([100,extrusion,extrusion],center=true);
	translate([0,28,-15]) cube([100,extrusion,extrusion],center=true);

	// empty inside:
	translate([0,0,0])cube([27.5,30,47.5],center=true);

	//L, N, ground lines pass
	cube([20,100,10],center=true);

	// switch mount screws
	for(x=[20,-20])translate([x,0,1])rotate([90,0,0])cylinder(r=m4ScrewRadius,h=30,center=true,$fn=20);

	// for m4 at bottom and top
	for(x=[-15,15]){translate([x,28,0])cylinder(r=m4ScrewRadius,h=100,center=true,$fn=20);
	for(z=[-32,32])translate([x,28,z])cylinder(r=m4ScrewHeadRadius,h=10,center=true,$fn=20);}
    }

    
}

module powerBoxRight(){
    intersection(){
	powerBox();
	translate([20,0,0])cube([40,100,100],center=true);
    }
}

module powerBoxLeft(){
    intersection(){
	powerBox();
	translate([-20,0,0])cube([40,100,100],center=true);
    }
}



//powerBoxLeft();
powerBoxRight();

