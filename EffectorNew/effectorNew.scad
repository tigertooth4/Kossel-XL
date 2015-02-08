//use <roundedBox.scad>
//use <microswitch.scad>


$fn = 50;
sqrt3 = 1.7321;
roundness = 4;
longEdge = 62;
shortEdge = longEdge * .4;


m25ScrewRadius = 1.25;
m25ScrewHeadRadius= 2.5;

m4ScrewRadius = 2.0; //for M4 bolt
m4ScrewHeadRadius = 4.0; 
m4NutRadius = 4.3;

m5NutRadius = 8/sqrt3+0.2;

m3ScrewRadius = 1.5; //for M3 bolt
m3ScrewHeadRadius = 3.0; 
m3NutRadius = 3.5; //

m2ScrewRadius = 1.0; //for M4 bolt
m2ScrewHeadRadius = 2.0; 
m2NutRadius = 2.3;


cylinderMaxRadius = 7; // enough
cylinderMinRadius = 3;
cylinderHeight = 7.0;


ballSeperateDistance = 48.0;
mountingHoleDistance = ballSeperateDistance - 30;
ballScrewRadius = 2.0;
ballJointAngle = 30;
ballJointRadius = 5;
ballBaseRadius = 3.5;

baseShapeRadius =(2*shortEdge + longEdge)/3*sqrt3-roundness*2;

upperScaleFactor=0.8;
underScaleFactor = 0.9;
upperHeight = (1-upperScaleFactor)*longEdge/sqrt3;
downHeight = (1-underScaleFactor)*longEdge/sqrt(2);
middleHeight = 2;


grooveHoleRadius = 18.5;
grooveMountScrewRadius = 13;


microSwitchHolesDistance = 9.5;


pivotRadius = 7.5;
pivotFarback = -20;
innerPivotWidth = 0.3 * longEdge;
outerPivotWidth = 0.15 * longEdge;

err = 0.4;

module triangleShape (){
    minkowski(){
	intersection(){
	    circle(r= baseShapeRadius,$fn=3); //small one, 2/3 shortEdge, 1/3 longEdge 
	    rotate([0,0,180]) circle(r=(2*longEdge + shortEdge)/3*sqrt3-roundness*2, $fn=3);
	}
	circle( r= roundness);	
    }
}

module pillar(){
    hull(){
	translate([0,0,5])cylinder(r= ballBaseRadius, h=1, center = true, $fn=20);
	cylinder (r=ballBaseRadius+1,h=1,center =true, $fn=20);
    }
}


module grooveShape(){
    difference(){
	cylinder(r=grooveHoleRadius, h=40, center = true);
	translate([-grooveHoleRadius+4-5, 0,0]) cube([10,grooveHoleRadius*2,40], center=true);}
}

RadiatorRadius = 20;
RadiatorHeight = 30;
GrooveMountRadius = 8;

V6SinkHeight = 25;
V6SinkRadius = 22.3/2;
proxSensor_x = 17.5;
proxSensor_y = 17.5;
proxSensor_z = 35;


module V6Profile()
{
    cylinder(r= V6SinkRadius+3, h=26);
    cylinder(r= 8, h= 34);
    cylinder(r= 6-0.1, h= 40);
    translate([0,0,39])cylinder(r= 8, h=6);
    
}


module lowerLayerShape(){
    difference(){
	union(){
	    //lower Shape
	    union(){
		// Draw the basic profile
		linear_extrude(height= upperHeight,center = false,convexity=10,scale=upperScaleFactor/1.05)
		scale([1.07,1.07,1])triangleShape();
		
		translate([0,0,-middleHeight]) linear_extrude(height= middleHeight,center = false)
		scale([1.07,1.07,1])	triangleShape();
		
		translate([0,0,-middleHeight]) rotate([180,0,0]) 
		linear_extrude(height=downHeight, center = false, scale=underScaleFactor*1.05)
		scale([1.07,1.07,1])	triangleShape();
		
	    }

	    // Draw Pillars for Ball Joints
	    for (i=[30:120:270])
	    for (j=[-1,1])
	    translate ([j*cos(i)*ballSeperateDistance/2, j*sin(i)*ballSeperateDistance/2,0])
	    translate ([sin(i)*(baseShapeRadius/2-roundness/2), -cos(i)*(baseShapeRadius/2-roundness/2),0]) 
	    rotate([cos(i)*ballJointAngle, sin(i)*ballJointAngle,0]) pillar();  
	    
	}
	// screw holes
	
	for (i=[30:120:270])
	for (j=[-1,1])
	translate ([j*cos(i)*ballSeperateDistance/2, j*sin(i)*ballSeperateDistance/2,0])
	translate ([sin(i)*(baseShapeRadius/2-roundness/2), -cos(i)*(baseShapeRadius/2-roundness/2),0]) 
	rotate([cos(i)*ballJointAngle, sin(i)*ballJointAngle,0]) 
	{
	    cylinder(r=m4ScrewRadius, h=20, center = true);
	    translate([0,0,-6]) cylinder(r=m4ScrewHeadRadius, h=12, center=true);
	}
	
	// Central Hole
	translate([0,0,-20 ])linear_extrude(height= 30) scale([0.67,0.67,1]) triangleShape();
	
    }
    
}

module upperPart_v2(){
    
    //basic shape
    difference(){
	union(){
	    hull(){
		linear_extrude(height= 2) scale([0.76, 0.76, 1])triangleShape();
		minkowski(){
		    intersection(){
			translate([0,0, V6SinkHeight-5]) linear_extrude(height=3)
			scale([0.25, 0.25,1]) triangleShape();
		    }
		    cylinder(r=4, h=1,center=true);
		}
		// front screw support for holding the upper part
		// using two m2 screws
		for(i=[-1,1])
		translate([25,i*14,0]) cylinder(r1=2, r2=1.6, h=5);
	    }
	    // print fans holding supports
	    // print fans holding screws (m2)

	    for(i=[-1])
	    translate([3,-i*13.2,-5])
	    rotate([0,0,i*8])
	    rotate([i*5,0,0])
	    translate([15,0,15])rotate([i*90,0,0])cylinder(r1=3, r2=2,h=5,center=true);

	}
	
	
	// prox sensor mount
	translate([V6SinkRadius + 3 + proxSensor_x/2, 0, -10])
	minkowski(){
	    cube([proxSensor_x, proxSensor_y, proxSensor_z], center=true);
	    //cylinder(r=2,h=5,center=true);
	    sphere(r=1.5);
	}
	
	// Heat sink cooling fan
	translate([-18,0,12])
	//rotate([0,90,0])
	minkowski(){
	    hull(){
		cube([21,21,1],center=true);
		translate([-10,0,-20]) cube([35,31,1],center=true);
	    }
	    sphere(r=2);
	}
	
	// Print fans
	for(i=[-1,1])
	translate([3,-i*19,-8])
	rotate([0,0,i*8])
	rotate([i*5,0,0])
	minkowski(){
	    hull(){
		cube([32,1,40],center=true);
		translate([-4,-i*15,0]) cube([40,1,40], center=true);
	    }
	    sphere(r=3);
	}
	
	// Heat sink mount
	translate([0,0,-15])	V6Profile();


	
	// m3 Screws
	// rare hold screw
	translate([-10, 0, 19])rotate([90,0,0])cylinder(r=m3ScrewRadius, h=40, center=true);
	translate([-10,16.5, 19])rotate([90,0,0])cylinder(r=m3NutRadius, h=5, center=true, $fn=6);
	translate([-10,-16.5,19])rotate([90,0,0])cylinder(r=m3ScrewHeadRadius, h=5,center=true);
	
	// front hold screw
	translate([11, 0, 19])rotate([90,0,0])cylinder(r=m3ScrewRadius, h=40, center=true);
	translate([11,12, 19])rotate([90,0,0])cylinder(r=m3NutRadius, h=5, center=true, $fn=6);
	translate([11,-12,19])rotate([90,0,0])cylinder(r=m3ScrewHeadRadius, h=5,center=true);

	// m2Screws to mount upper part to lower Basement
	// rare
	for(i=[-1,1])
	translate([-20,i*20,0])
	{
	    cylinder(r=m2ScrewRadius, h=40,center=true);
	    translate([0,0,12])cylinder(r=m2ScrewHeadRadius, h=10, center=true);
	}

	// front
	for(i=[-1,1])
	translate([25,i*14,0])
	{
	    cylinder(r=m2ScrewRadius, h=40,center=true);
	    translate([0,0,10])cylinder(r=m2ScrewHeadRadius, h=10, center=true);
	}

	// print fans holding screws (m2)
	for(i=[-1,1])
	translate([3,-i*15,-5])
	rotate([0,0,i*8])
	rotate([i*5,0,0])
	for(j=[-1,1])
	translate([15*j,0,15])rotate([90,0,0])cylinder(r=m2ScrewRadius,h=30,center=true);

    }

    // Sink cooling fan holding supports
    for(i=[-1,1])
    difference(){
	translate([-9,i*11,11])
	rotate([0,90,0])
	// support thing
	minkowski(){
	    cube([6,5,8],center=true);
	    cylinder(r=2,h=2,center=true);
	}
	// screw holes
	translate([-15, i*10, 10])
	rotate([0,90,0])
	cylinder(r=m2ScrewRadius, h= 20, center=true);


	// avoid the m2 screw for printing fans
	for(j=[-1,1])
	translate([3,j*(-15),-5])
	rotate([0,0,j*8])
	rotate([j*5,0,0])
	translate([-15,0,15])rotate([90,0,0])cylinder(r=m2ScrewRadius,h=20, center=true);

	// avoid the heat sink
	translate([0,0,-15])	V6Profile();


    }

    // Heat sink fan
    
    %translate([-20,0,0])
    minkowski(){
	cube([8,21,21],center=true);
	rotate([0,90,0])
	cylinder(r=2, h=1, center=true);
    }
    
    // print fans
    
    %for(i=[-1,1])
    translate([3,-i*21,-5])
    rotate([0,0,i*8])
    rotate([i*5,0,0])
    minkowski(){
	cube([31,8,31], center= true);
	rotate([90,0,0]) cylinder(r=2, h=1, center=true);
    }

    // for better adhesion
    for(i=[-1,1])
    translate([32,-i*10,0])cylinder(r=5,h=0.4);

}


module lowerPart_v2(){
    difference(){
	union(){
	    difference(){
		union(){
		    lowerLayerShape();

		    // wind hole cover
		    hull(){
			for(i=[-1,2])
			translate([-25,i*8-4.5,1.5])
			translate([0,0,0])rotate([0,90,0])cylinder(r=4.5,h=17,center=true);
			//    translate([0,0,-3.5])rotate([0,90,0])cylinder(r=2,h=20,center=true);
		    }

		    // side wind hole
		    for(j=[-1,1])
		    translate([10,0,0])
		    intersection(){
			hull(){
			    for(i=[-2,1])
			    translate([i*6,j*25,3])
			    translate([0,0,-2.5])rotate([0,0,-j*15])rotate([90,0,0])
			    cylinder(r=4.5,h=40,center=true);
			}
			cylinder(r1=62,r2=55, h=20,center=true, $fn=3);
			cylinder(r1=55,r2=62, h=20,center=true, $fn=3);
			
		    }


		}

		// Central Hole
		translate([0,0,-20 ])linear_extrude(height= 30) scale([0.67,0.67,1]) triangleShape();

		// Heat sink fan
		
		translate([-20,0,0])
		minkowski(){
		    cube([8,21,21],center=true);
		    rotate([0,90,0])
		    cylinder(r=3, h=3, center=true);
		}
	    
		// print fans
		
		for(i=[-1,1])
		translate([3,-i*18,-5])
		rotate([0,0,i*8])
		rotate([i*5,0,0])
		minkowski(){
		    cube([33,12,31], center= true);
		    //rotate([90,0,0]) cylinder(r=3, h=3, center=true);
		    sphere(r=2);
		}
	    
		// prox sensor
		translate([V6SinkRadius + 4 + proxSensor_x/2, 0, -10])
		minkowski(){
		    cube([proxSensor_x, proxSensor_y, proxSensor_z], center=true);
		    //cylinder(r=2,h=5,center=true);
		    sphere(r=1);
		}


		// wind holes
		hull(){
		    for(i=[-1,2])
		    translate([-25,i*8-4.5,1.5])
		    translate([0,0,0])rotate([0,90,0])cylinder(r=3,h=20,center=true);
		//    translate([0,0,-3.5])rotate([0,90,0])cylinder(r=2,h=20,center=true);
		}

		// side holes
		for(j=[-1,1])
		translate([10,0,0])
		hull(){
		    for(i=[-2,1])
		    translate([i*6,j*25,3])
		    translate([0,0,-2.5])rotate([0,0,-j*15])rotate([90,0,0])cylinder(r=3,h=35,center=true);
//		    translate([0,0,-3.5])rotate([90,0,-j*5])cylinder(r=1.5,h=35,center=true);
		}

	    
	    }
	
	    // rare screw places for holding the upper part
	    // use m2 screws
	    for(i=[-1,1])
	    translate([-20,i*20,4.565])
	    cylinder(r1=2.5, r2=4, h=upperHeight-2, center=true);
	}

	// rare screw places for holding the upper part
	// use m2 screws
	for(i=[-1,1])
	translate([-20,i*20,0])
	{
	    cylinder(r=m2ScrewRadius, h=20, center=true);
	    translate([0,0,-3])cylinder(r=m2NutRadius, h=10, center=true, $fn=6);
	}

	// front screw places for holding the upper part
	// use m2 screws
	for(i=[-1,1])
	translate([25,i*14,0])
	{
	    cylinder(r=m2ScrewRadius, h=40,center=true);
	    translate([0,0,-3])cylinder(r=m2NutRadius, h=10, center=true, $fn=6);
	}


    }    
}

module body()
{
    difference(){
	union(){
	    lowerPart_v2();
            translate([0,0,upperHeight])   upperPart_v2();
	}
    }
}


module l_upperPart_v2(){
    intersection(){
	upperPart_v2();
	translate([0,40,0])cube([80,80,60],center=true);
    }
}


module r_upperPart_v2(){
    intersection(){
	upperPart_v2();
	translate([0,-40,0])cube([80,80,60],center=true);
    }
}

//body();
//lowerPart_v2();
//translate([0,0,7])upperPart_v2();

//l_upperPart_v2();

r_upperPart_v2();

//color("silver") translate([-2,0,-27]) rotate([0,0,0])import("./e3d-v6.stl");


