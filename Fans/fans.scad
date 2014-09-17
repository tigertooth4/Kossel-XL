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
	union(){
	    roundedBox([20,30,25],2,center=true);
	    //minkowski(){cube([13,28,25],center=true); cylinder(r=2,h=2,center=true,$fn=10);}
	    translate([-8,0,0])rotate([0,90,0]) hull()
	    {
		roundedBox([25,30,0.5],2,center=true);
		translate([0,0,-3]) roundedBox([25,25,0.5],2,center=true);
		
	    }
	    // second fan mount
	    translate([-14,-22,7.4])cube([24,15,5]);

	}

	// leave mounting space

	cylinder(r=hotendRadius, h= 40,center=true);

	// leave air holes
	rotate([0,90,0]) cylinder(r=8, h=40, center=true);

	// leave mounting holes
	for (i=[45:90:360]) {
	    rotate([i, 0,0]) translate([-10,10,0]) rotate([0,90,0])cylinder(r=1.5, h=30, center=true, $fn=10);
	}

	// screws
	translate([-10,-19,0])cylinder(r=1.25,h=20,$fn=10);
	translate([-10,-19,11])cylinder(r=2.5, h=4,$fn=10);
	translate([5,-19,0])cylinder(r=1.25,h=20,$fn=10);
	translate([5,-19,11])cylinder(r=2.5,h=4,$fn=10);
    }
}



printFanHeight = 40;

module secondFan(){
    
    
    difference(){
	union(){
	    //mount
	    translate([-14,-23,2])cube([23,9,3]);
	    
	    // base part
	    translate([0,-32,-6])rotate([-140,0,0])
	    hull(){
		minkowski(){
		    cube([26,26,5],center=true);
		    cylinder(r=2,h=1);
		}
		translate([0,0,30]) cube([10,7,1],center=true);
	    }
	}
	
	union(){
	    translate([0,-32,-6])rotate([-140,0,0]) hull(){
		minkowski(){
		    cube([17,17,6],center=true);
		    cylinder(r=2,h=3);
		}
		translate([0,0,30]) cube([6,5,2],center=true);
	    }
	}

	// second fan mount hole
	translate([-10,-17,0])cylinder(r=1.25,h=100,$fn=10);
	translate([5,-17,0])cylinder(r=1.25,h=100,$fn=10);

	// mount screws holes
	translate([0,-32,-6])rotate([-140,0,0]) {
	    for(i=[0:90:360]) rotate([0,0,i])
	    translate([11.5,11.5,-10]) cylinder(r=1.25, h=20,$fn=10);
	}
    }
}



module printFan(){
    union(){
	difference(){
	    hull(){
		roundedBox([35,40,5],1,center=true,$fn=10);
		translate([0,-12.5,-printFanHeight]) roundedBox([15,10,1],3,center=true,$fn=10); 
	    }
	    
	    hull(){
		translate([0,-3,1]) roundedBox([30,30,5],1,center=true,$fn=10);
		translate([0,-12.5,-printFanHeight-5]) cube([8,3,3],center=true); 
	    }
	}
	translate([0,35/2+2,0])
	rotate([90,0,0])roundedBox([35,5,20],1);
    }
}


module fanSupport(){
    difference(){
	union(){
	    cube([20, 28, 3]);
	    //translate([7, 0,-7])cube([5,28, 10]);
	}
	// leave two holes
	translate([5,5,0]) cylinder(r=1.25, h =30, center=true);
	translate([5,23,0]) cylinder(r=1.25, h =30, center=true);

	translate([15,4,0]) cylinder(r=1.25, h =30, center=true);
	translate([15,24,0]) cylinder(r=1.25, h =30, center=true);

    }
	

}


%translate([0,0,10]) hotend();



translate([0,0,-20]) hotendFan();

translate([0,0,-20]) secondFan();



