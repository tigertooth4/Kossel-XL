pb_x = 113/2;
pb_y = 215/2;
pb_z = 45/2;

m4ScrewRadius = 2;
m4ScrewHeadRadius=4;
thick=7;

module powerBrick(){
    difference(){
	cube([pb_x*2, pb_y*2, pb_z*2],center=true);
	translate([pb_x-32,pb_y-32,0])cylinder(r=m4ScrewRadius,h=40,$fn=20);
	translate([pb_x-32,-pb_y+32,0])cylinder(r=m4ScrewRadius,h=40,$fn=20);
	translate([-pb_x+32,pb_y-32,0])cylinder(r=m4ScrewRadius,h=40,$fn=20);
	translate([-pb_x+32,-pb_y+32,0])cylinder(r=m4ScrewRadius,h=40,$fn=20);
	translate([0,pb_y-32,pb_z-11])rotate([0,90,0])cylinder(r=m4ScrewRadius,h=140,center=true,$fn=20);
	translate([0,-pb_y+32,pb_z-11])rotate([0,90,0])cylinder(r=m4ScrewRadius,h=140,center=true,$fn=20);
    }
    
}



module mount(length){
    difference(){
	
	union(){
	    cylinder(r=10, h=thick, $fn=20,center=true);
	    translate([-length/2,0,0]){
		cube([length,20,thick],center=true);
		translate([0,-6,-thick/2])cube([length+7,thick,thick],center=true);
		translate([0,6,-thick/2])cube([length+7,thick,thick],center=true);
	    }
	    translate([-length,0,0])cylinder(r=10, h=thick, $fn=20,center=true);
	}

	//m4Screw holes
	cylinder(r=m4ScrewRadius, h=20, center=true, $fn=20);
	translate([0,0,-4])cylinder(r=m4ScrewHeadRadius, h=thick, center=true, $fn=20);
	
	hull(){
	    translate([-length-3,0,0])cylinder(r=m4ScrewRadius, h=20, center=true, $fn=20);
	    translate([-length+3,0,0])cylinder(r=m4ScrewRadius, h=20, center=true, $fn=20);
	}

	hull(){
	    translate([-length-3,0,-thick/2])cylinder(r=m4ScrewHeadRadius, h=thick, center=true, $fn=20);
	    translate([-length+3,0,-thick/2])cylinder(r=m4ScrewHeadRadius, h=thick, center=true, $fn=20);
	}
    }
}

//translate([-pb_x+32,pb_y-32,-pb_z-4])rotate([0,0,-30])mount(68);
translate([-pb_x+32,-pb_y+32,-pb_z-4]) rotate([0,0,90]) mount(45);

//translate([pb_x-32,pb_y-32,-pb_z-4])rotate([0,0,-150])mount(68);
//translate([pb_x-32,-pb_y+32,-pb_z-4]) rotate([0,0,90]) mount(45);


%color("silver")rotate([0,180,0])powerBrick();