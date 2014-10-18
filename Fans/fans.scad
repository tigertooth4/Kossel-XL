use <effector.scad>
use <roundedBox.scad>

hotendRadius = 12.5;
hotendLength = 50.0;
hotendSlice = 1.5;
hotendHeadLength=13;
hotendHeadWidth = 16;

hotendProfileRadius = hotendRadius;



module hotend(){
    for(i=[0:3.5:hotendLength]) translate([0,0,-i]) cylinder(r=hotendRadius, h=hotendSlice);
    translate([0,0,-hotendLength])cylinder(r=2, h=hotendLength + hotendHeadLength);

    translate([0,0,-hotendLength - hotendHeadLength/2])cube([hotendHeadWidth,hotendHeadWidth,hotendHeadLength],center=true);
    translate([0,0,-hotendLength -hotendHeadLength-3]) cylinder(r1=1,r2=4, h= 3);
}

$fn=20;

module hotendFan(){
    difference()
    {
	//basic shape
	translate([-2.5,0,0])union(){
	    translate([3,0,0])roundedBox([22,30,25],2,center=true);
	    //minkowski(){cube([13,28,25],center=true); cylinder(r=2,h=2,center=true,$fn=10);}
	    translate([-8,0,0])rotate([0,90,0]) hull()
	    {
		roundedBox([25,30,0.5],2,center=true);
		translate([0,0,-3]) roundedBox([25,25,0.5],2,center=true);
		
	    }
	}

	// leave mounting space

	cylinder(r=hotendRadius, h= 40,center=true);
	translate([15,0,0])cube([20,22,40],center=true);

	// leave air holes
	scale([1,11/10,1])rotate([0,90,0]) cylinder(r=10, h=40, center=true);

	// leave mounting holes
	for (i=[0:90:360]) {
	    rotate([i, 0,0]) translate([0,10.25,-10.25]) rotate([0,90,0])cylinder(r=1.2, h=40, center=true, $fn=10);
	}

	// screws
	translate([-10,-19,0])cylinder(r=1.25,h=20,$fn=10);
	translate([-10,-19,11])cylinder(r=2.5, h=4,$fn=10);
	translate([5,-19,0])cylinder(r=1.25,h=20,$fn=10);
	translate([5,-19,11])cylinder(r=2.5,h=4,$fn=10);

	//horizontal screws
	translate([7.5,0,-8])rotate([90,0,0])cylinder(r=1.25,h=40,$fn=10,center=true);
    }
}



printFanHeight = 40;




module printFan(){
    
    difference(){
	
	    translate([0,0,-45])
	    union(){
		// First section
		translate([19,0,15])
		rotate([0,-10,0])
		minkowski(){
		    cube([2,25,25],center=true);
		    rotate([0,90,0])cylinder(r=2,h=3,center=true,$fn=20);
		}

		hull(){
		    translate([19,0,15])
		    rotate([0,80,0]) cylinder(r=16,h=5,center=true,$fn=40);
		    translate([10,0,10])  //rotate([0,-10,0])
		    union(){
			//cube([1,18,18],center=true);
			rotate([0,90,0])cylinder(r=15,h=1,center=true,$fn=60);
		    }
		}
		
		//Section section
		hull(){
		    translate([10,0,10]) //rotate([0,-10,0])

		    union(){
			//cube([1,18,18],center=true);
			rotate([0,90,0])cylinder(r=15,h=1,center=true,$fn=60);
		    }

		    
		    translate([2,0,-4])rotate([0,-10,0])cube([1,13,5],center=true);
		}
		translate([17,0,30])rotate([0,-10,0])cube([3,17,15],center=true);

		//mount to effector
		hull(){
		    translate([17,0,38])cube([1,17,4],center=true);
		    translate([11,0,38])cube([1,23,4],center=true);
		}
		translate([11.5,0,38])for(i=[-17.5/2,17.5/2])translate([0,i,0])cylinder(r=4,h=4,center=true);

		//pillars
		translate([19.5,0,14.8])rotate([0,-10,0])for(i=[-12,12]) for(j=[-12,12])translate([-1,i,j])rotate([0,90,0])
		cylinder(r=3,h=6,center=true,$fn=20);
		// for stability
		translate([16,0,26.5])rotate([0,-10,0])cube([5,4,20],center=true);
	    }
	
	    // wind hole
	    union(){
		translate([6,0,-33])hull(){
		    translate([16,0,4])rotate([0,80,0])cylinder(r=14,h=1,$fn=30);
		    translate([5,0,-3.5])rotate([0,85,0])cylinder(r=11,h=1,$fn=30);
		}
		
		translate([6,0,-33])hull(){
		    translate([5,0,-3.5])rotate([0,85,0])cylinder(r=11,h=1,$fn=30);
		    translate([-5,0,-17])cube([1,9,1.6],center=true);
		}
	    }
	    
	    translate([10,0,-10])for(i=[-17.5/2,17.5/2])
	    //screw hole for effector mounting
	    translate([0,i,0])rotate([0,30,0])cylinder(r=1.25,h=20,center=true,$fn=10);

	    //screw holes for fan
	    translate([15,0,-31])rotate([0,-10,0])for(i=[-12,12]) for(j=[-12,12])translate([5,i,j])rotate([0,90,0])
	    cylinder(r=1.25,h=10,center=true,$fn=10);
    }
}



%translate([0,0,20]) hotend();



%translate([0,0,-20]) hotendFan();

translate([10,0,0])printFan();



