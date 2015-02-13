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
    cylinder(r= 9.5, h= 34); // was 8
    cylinder(r= 6.2, h= 40); // was 6-0.1
    translate([0,0,39])cylinder(r= 8, h=6);
    
}


module FotekSensor()
{
    difference(){
	// the main body
	hull(){
	    translate([0,0,6])cube([18,18,12],center=true);
	    translate([0,0,-22.5])cube([17.3, 17.3, 1], center=true);
	}
	
	for(i=[-1,1])
	{
	    translate([6,5.8*i,7]) cube([6,6.4,10],center=true);

	    // M3 holes
	    translate([0, 5.65*i,10.4-1.65])hull(){
		rotate([0,90,0])cylinder(r=1.65, h=20,center=true);
		translate([0,0, -3.7])rotate([0,90,0])cylinder(r=1.65, h=20,center=true);
	    }
	}
    }

    translate([-9+2.4+3,0,15])cylinder(r=3,h=40,center=true);
    
}


module FotekTop_mod()
{
    difference(){
	// the main body
	translate([0,0,6])
	minkowski(){
	    cube([16,16,9],center=true);
	    cylinder(r=1, h=1, center=true);
	}

	// m2.5 Screw
	for(i=[-1,1]) for(j=[-1,1])
	translate([i*7, j*7,5])
	{
	    cylinder(r=m25ScrewRadius, h=20, center=true);
	    translate([0,0,3])minkowski(){
		cube([4,4,6],center=true);
		cylinder(r=1, h=1, center=true);
	    }
	}

	// front spacer
	for(i=[-1,1]) 
	translate([9, i*9,5])
	{
	    cylinder(r=4, h=20, center=true);
	}

	

	// led inspect hole
	translate([6,0,5])cylinder(r1=2,r2=1.5, h=12,center=true);
	translate([6,0,2])cylinder(r=2.2, h=4, center=true);
	
	// slice the top conners
	translate([9,0,9])rotate([0,-45,0])cube([5,20,20],center=true);
	translate([-9,0,12])rotate([0,45,0])cube([5,20,20],center=true);

	// Wire half-hole
	translate([-9.5,0,1])rotate([0,-45,0])
	hull(){
	    cylinder(r=2.2, h=10, center=true);
	    translate([2,0,0])cylinder(r=2.2, h=10, center=true);
	}

	// inner M3 screw
	translate([-1.5,0,0])cylinder(r=m3ScrewRadius+.2, h=40, center=true);
	translate([-1.5,0,4])cylinder(r=m3NutRadius+.1, h=2.7, center=true, $fn=6);
	translate([-1.5,0,8.5])cylinder(r=m3NutRadius+.1, h=2.7, center=true, $fn=6);

	// m2 screw to bind two parts
	translate([-7,0,7.2])rotate([90,0,0])cylinder(r=m2ScrewRadius, h=10, center=true);
    }
}

module Fotek_mod(){
    FotekTop_mod();
    translate([0,0,1])intersection(){
	FotekSensor();
	translate([0,0,-11.5])cube([20,20,23],center=true);
    }
}

module l_FotekTop_mod(){
    intersection(){
	FotekTop_mod();
	translate([0,-10,0])cube([20,20,40],center=true);
    }
}

module r_FotekTop_mod(){

    intersection(){
	FotekTop_mod();
	translate([0,10,0])cube([20,20,40],center=true);
    }
}



// ------------ upper part -----------------
//
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

	    // prox sensor mount supports
	    translate([V6SinkRadius + 3 + proxSensor_x/2, 0, 3])
	    minkowski(){
		hull(){
		    translate([-4,0,3]) rotate([0,20,0])cube([proxSensor_x-4, proxSensor_y-3, 10], center=true);
		    translate([-1,0,-5])cube([proxSensor_x+5, proxSensor_y+1, 1],center=true);
		}
		//cylinder(r=2,h=5,center=true);
		sphere(r=3);
	    }

	    
	    // print fans holding supports
	    // print fans holding screws (m2)

	    for(i=[-1])
	    translate([3,-i*13.2,-5])
	    rotate([0,0,i*8])
	    rotate([i*5,0,0])
	    translate([15,0,15])rotate([i*90,0,0])cylinder(r1=3, r2=2,h=5,center=true);

	    // Fotek mounting support
	    translate([V6SinkRadius+proxSensor_x/2 +1.5, 0, 13.5])
	    cylinder(r1=m3NutRadius+4,r2=m3NutRadius+.5, h=11, center=true);

	}
	
	
	// Fotek prox sensor mount
	translate([V6SinkRadius + 3 + proxSensor_x/2, 0, -11.5])
	minkowski(){
	    hull(){
		translate([-proxSensor_x/2,0,0])cube([1, proxSensor_y, proxSensor_z], center=true);
		translate([proxSensor_x +10,0,0])cube([1, proxSensor_y-4, proxSensor_z], center=true);
		//cylinder(r=2,h=5,center=true);
		
	    }
	    sphere(r=1);
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
	translate([0,0,-14])	V6Profile(); // was -15


	
	// m3 Screws
	// rare hold screw
	translate([-11, 0, 19])rotate([90,0,0])cylinder(r=m3ScrewRadius, h=40, center=true);
	translate([-11,15.5, 19])rotate([90,0,0])cylinder(r=m3NutRadius, h=5, center=true, $fn=6);
	translate([-11,-15.5,19])rotate([90,0,0])cylinder(r=m3ScrewHeadRadius, h=5,center=true);
	
	// front hold screw
	translate([12, 0, 19])rotate([90,0,0])cylinder(r=m3ScrewRadius, h=40, center=true);
	translate([12,11, 19])rotate([90,0,0])cylinder(r=m3NutRadius, h=5, center=true, $fn=6);
	translate([12,-11,19])rotate([90,0,0])cylinder(r=m3ScrewHeadRadius, h=5,center=true);

	// Fotek Sensor hold tool
	translate([V6SinkRadius+proxSensor_x/2 +1.5, 0, 0]) cylinder(r=m3ScrewRadius+.1, h=40, center=true);
	translate([V6SinkRadius+proxSensor_x/2 +1.5, 0, 22]) cylinder(r=m3ScrewHeadRadius, h=10, center=true);
	// Fotek mount inner nut
	translate([V6SinkRadius+proxSensor_x/2 +1.5, 0, 13]) cylinder(r=m3NutRadius+.1, h=2.7, center=true, $fn=6);
	translate([V6SinkRadius+proxSensor_x/2 +1.5, 0, 9]) cylinder(r=m3NutRadius+.1, h=2.7, center=true, $fn=6);
	
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

	// shape regulation
	translate([0,0,-20]) cube([100,100,40],center=true);


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
	translate([0,0,-14])	V6Profile();



    }


    // for better adhesion
    for(i=[-1,1])
    translate([34,-i*10,0])cylinder(r=5,h=0.4);

}


// ------------ lower part -----------------
//
module lowerLayerShape(){
    difference(){
	union(){
	    //lower Shape
	    union(){
		// Draw the basic profile
		linear_extrude(height= upperHeight,center = false,convexity=10,scale=upperScaleFactor/1.07)
		scale([1.07,1.07,1])triangleShape();
		
		translate([0,0,-middleHeight]) linear_extrude(height= middleHeight,center = false)
		scale([1.07,1.07,1])	triangleShape();
		
		translate([0,0,-middleHeight]) rotate([180,0,0]) 
		linear_extrude(height=downHeight, center = false, scale=underScaleFactor)
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
			translate([0,0,0])rotate([0,90,0])cylinder(r=6,h=17,center=true);
			//    translate([0,0,-3.5])rotate([0,90,0])cylinder(r=2,h=20,center=true);
		    }

		    // side wind hole
		    for(j=[-1,1])
		    translate([10,0,0])
		    intersection(){
			hull(){
			    for(i=[-1.5,1.5])
			    translate([i*6,j*25,3])
			    translate([0,0,-2.5])rotate([0,0,-j*15])rotate([90,0,0])
			    cylinder(r=6,h=40,center=true);
			}
			cylinder(r1=59,r2=59, h=20,center=true, $fn=3);
			cylinder(r1=45,r2=80, h=20,center=true, $fn=3);
			
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
		    translate([-25,i*8-4.5,2])
		    rotate([0,90,0])cylinder(r=3,h=20,center=true);
		//    translate([0,0,-3.5])rotate([0,90,0])cylinder(r=2,h=20,center=true);
		}

		// side holes
		for(j=[-1,1])
		translate([10,0,0])
		hull(){
		    for(i=[-1.5,1.5])
		    translate([i*6,j*25,0.5])
		    rotate([0,0,-j*15])rotate([90,0,0])cylinder(r=3.5,h=35,center=true);
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

	// rare tool for holding wires
	hull(){
	    for(i=[-1,1])
	    translate([-28,i*14,-7])
	    rotate([0,90,0])
	    cylinder(r=2, h=14,center=true);
	}

	// holding screws (m2x10)
	for(i=[-1,1])
	translate([-28,i*18.5,-3])
	cylinder(r=1, h=10,center=true);
    }    
}


module wireCover()
{
    difference(){
	hull(){
	    for(i=[-1,1])
	    translate([-28,i*18.5,0])
	    scale([1.2,1,1])
	    cylinder(r1=2.5,r2=3, h=2.5, center=true);
	}

	for(i=[-1,1])
	translate([-28,i*18.5,0])
	cylinder(r1=1.5, r2=1, h=4, center=true);
	    
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

module fans(){
    // Heat sink fan
    
    translate([-20,0,0])
    minkowski(){
	cube([8,21,21],center=true);
	rotate([0,90,0])
	cylinder(r=2, h=1, center=true);
    }
    
    // print fans
    
    for(i=[-1,1])
    translate([3,-i*21,-5])
    rotate([0,0,i*8])
    rotate([i*5,0,0])
    minkowski(){
	cube([31,8,31], center= true);
	rotate([90,0,0]) cylinder(r=2, h=1, center=true);
    }
  

}


module assembly()
{
    lowerPart_v2();
    translate([0,0,7]){
	l_upperPart_v2();
//	upperPart_v2();
    }

    translate([0,0,-8])wireCover();

//    #color("silver") translate([-2,0,-27]) rotate([0,0,0])import("./e3d-v6.stl");
    #translate([V6SinkRadius+proxSensor_x/2 + 3,0,-2]) Fotek_mod();
    #color("grey")translate([0,0,7])fans();  

}

//assembly();


module printArrange()
{
//    translate([0,0,6.375])lowerPart_v2();
    rotate([0,0,-30])translate([0,40, 0])l_upperPart_v2(); rotate([0,0,30])translate([0,-40, 0])r_upperPart_v2();
    //translate([0,-5,9])rotate([90,0,0])l_FotekTop_mod(); translate([0,5,9])rotate([-90,0,0])r_FotekTop_mod();
 //       translate([0,10, 0])l_upperPart_v2(); translate([0,-10, 0])r_upperPart_v2();

    //translate([20,0,1.25])wireCover();
}

printArrange();


