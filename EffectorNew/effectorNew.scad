//use <roundedBox.scad>
//use <microswitch.scad>


$fn = 50;
sqrt3 = 1.7321;
roundness = 4;
longEdge = 62;
shortEdge = longEdge * .4;


m25ScrewRadius = 1.25; 

m4ScrewRadius = 2.0; //for M4 bolt
m4ScrewHeadRadius = 4.0; 
m4NutRadius = 4.3;

m5NutRadius = 8/sqrt3+0.2;

m3ScrewRadius = 1.5; //for M3 bolt
m3ScrewHeadRadius = 3.0; 
m3NutRadius = 3.5; //
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


// ----------------------------deprecated------------------------------------------
module baseShape(){
    difference(){
	union(){
	    difference(){
		union(){
		    // Draw the basic profile
		    linear_extrude(height= upperHeight,center = false,convexity=10,scale=upperScaleFactor) triangleShape();
		    translate([0,0,-middleHeight]) linear_extrude(height= middleHeight,center = false) triangleShape();
		    translate([0,0,-middleHeight]) rotate([180,0,0]) 
		    linear_extrude(height=downHeight, center = false, scale=underScaleFactor) triangleShape();
		}
		// then dig a shallow channel for pivot
		translate([-18,0,upperHeight+ pivotRadius -1]) 
		rotate([90,0,0]) cylinder(r=pivotRadius+2, h=innerPivotWidth+2*outerPivotWidth + 5, center=true);  
		
	    }
	    // Draw the base pivots:
	    translate([pivotFarback, -innerPivotWidth/2, upperHeight+ pivotRadius-1]) 
	    rotate([90,0,0])  
	    difference()	{
		hull(){
		    cylinder(r= pivotRadius, h=outerPivotWidth, center=true);
		    translate([-2,-pivotRadius-2,0]) 
		    cube([pivotRadius*2,2, outerPivotWidth], center = true);
		}
		// dig a m4 screw hole in the center
		cylinder(r= m3ScrewRadius, h=30, center = true);
	    };
	    
	    translate([pivotFarback,innerPivotWidth/2,upperHeight+ pivotRadius-1]) 
	    rotate([90,0,0])  
	    difference()	{
		hull(){
		    cylinder(r= pivotRadius, h=outerPivotWidth, center=true);
		    translate([-2,-pivotRadius-2,0]) 
		    cube([pivotRadius*2,2, outerPivotWidth], center = true);
		}
		// dig a m4 screw hole in the center
		cylinder(r= m3ScrewRadius, h=30, center = true);
	    };
	    
	    // Draw the pillar
	    for (i=[30:120:270]) {
		translate ([cos(i)*ballSeperateDistance/2, sin(i)*ballSeperateDistance/2,0])
		translate ([sin(i)*(baseShapeRadius/2-roundness/2), -cos(i)*(baseShapeRadius/2-roundness/2),0]) 
		rotate([cos(i)*ballJointAngle, sin(i)*ballJointAngle,0]) pillar();  
		
		translate ([-cos(i)*ballSeperateDistance/2, -sin(i)*ballSeperateDistance/2,0])
		translate ([sin(i)*(baseShapeRadius/2-roundness/2), -cos(i)*(baseShapeRadius/2-roundness/2),0]) 
		rotate([cos(i)*ballJointAngle, sin(i)*ballJointAngle,0]) pillar();
	    }
	    
	    
	    
	}
	// Minus screw holes
	
	for (i=[30:120:270]) {
	    translate ([cos(i)*ballSeperateDistance/2, sin(i)*ballSeperateDistance/2,0])
	    translate ([sin(i)*(baseShapeRadius/2-roundness/2), -cos(i)*(baseShapeRadius/2-roundness/2),0]) 
	    rotate([cos(i)*ballJointAngle, sin(i)*ballJointAngle,0]) 
	    union() {
		cylinder(r=m4ScrewRadius, h=20, center = true);
		translate([0,0,-6]) cylinder(r=m4ScrewHeadRadius, h=12, center=true);
	    }
	    
	    
	    translate ([-cos(i)*ballSeperateDistance/2, -sin(i)*ballSeperateDistance/2,0])
	    translate ([sin(i)*(baseShapeRadius/2-roundness/2), -cos(i)*(baseShapeRadius/2-roundness/2),0]) 
	    rotate([cos(i)*ballJointAngle, sin(i)*ballJointAngle,0]) 						
	    union() {
		cylinder(r=m4ScrewRadius, h=20, center = true);
		translate([0,0,-6]) cylinder(r=m4ScrewHeadRadius, h=12, center=true);
	    }
	}
	
	// Minus groove HOLES
	scale([1.1,1.1,1])grooveShape();
	
	// Minus micro switch mount place
	
	translate([grooveHoleRadius +2,0, 0]) cube([8,24,upperHeight+middleHeight+downHeight+3],center=true);
	// Minus two holes for m2.5 screws
	translate([grooveHoleRadius +2, -microSwitchHolesDistance/2, -2.3]) rotate([0,90,0]) cylinder(r=m25ScrewRadius, h=30,center=true);
	translate([grooveHoleRadius +2, microSwitchHolesDistance/2, -2.3]) rotate([0,90,0]) cylinder(r=m25ScrewRadius, h=30,center=true);
	translate([grooveHoleRadius + 3, 0, -3.3]) rotate([0,0,90]) %microswitch();
	
	// Minus a pulling screw hole
	translate([longEdge*sqrt3/3-7,0,-4]) cylinder(r=3.5, h=4,center=true);
	translate([longEdge*sqrt3/3-7,0,0])  roundedBox([m3ScrewRadius*4, m3ScrewRadius*2.5,100], m3ScrewRadius, center=true);
	
	
	// Minus some preset holes for wires pass through
	translate([-longEdge*sqrt3/3+10,0,0]) rotate([0,35,0]) roundedBox([m3ScrewRadius*3+1, m3ScrewRadius*5.5+1,  100], m3ScrewRadius, center=true);
	
	// Minus an inner channel to let the wire pass through for microSwitch
	translate([-2,0,-1]) difference() {
	    cylinder(r=grooveHoleRadius + 7.5, h= 4,center=true);
	    cylinder(r=grooveHoleRadius + 5, h=4, center=true);
	    translate([50,0,0]) cube([100,20,5],center=true);
	}
	translate([-2,0,-2]) for (i=[45:45:315]) {
	    rotate([0,0,-i]) translate([grooveHoleRadius+6.5,0,0]) cube([m3ScrewRadius*2.5, m3ScrewRadius*3, 6], center=true);}
	
	// Leave fans Mounting holes
	
	for (i=[30:120:260]) {
	    translate ([cos(i)*mountingHoleDistance/2, sin(i)*mountingHoleDistance/2,0])
	    translate ([sin(i)*(ballSeperateDistance/2+3), -cos(i)*(ballSeperateDistance/2+3),0]) 
	    rotate([cos(i)*ballJointAngle, sin(i)*ballJointAngle,0]) cylinder(r=m25ScrewRadius, h=30,center=true);  
	    
	    translate ([-cos(i)*mountingHoleDistance/2, -sin(i)*mountingHoleDistance/2,0])
	    translate ([sin(i)*(ballSeperateDistance/2+3), -cos(i)*(ballSeperateDistance/2+3),0]) 
	    rotate([cos(i)*ballJointAngle, sin(i)*ballJointAngle,0]) cylinder(r=m25ScrewRadius, h=30,center=true);  
	    
	}
	
	
	
	
	
    }
    echo ("Base Height =", upperHeight+middleHeight+downHeight);
}


module fanCone(){
    difference(){
	// outer profile
	hull(){
	    minkowski(){
		cube([25-roundness*2,25-roundness*2,5],center=true);
		cylinder(r=roundness,h=1,center=true);
	    }
	    translate([0,10,-25])
	    rotate([5,0,0])
	    minkowski(){
		cube([24-roundness,15-roundness,1],center=true);
		cylinder(r=roundness/2,h=1,center=true);
	    }
	}
    }
}

module fanConeInner(){
    // inner profile
    hull(){
	minkowski(){
	    cube([20-roundness*2,20-roundness*2,6],center=true);
	    cylinder(r=roundness,h=1,center=true);
	}
	translate([0,10,-26])
	rotate([5,0,0])
	minkowski(){
	    cube([18-roundness,10-roundness,1],center=true);
	    cylinder(r=roundness/2,h=1,center=true);
	}
    }
}




//**************************************** New **************************************************
RadiatorRadius = 20;
RadiatorHeight = 30;
GrooveMountRadius = 8;

V6SinkHeight = 25;
V6SinkRadius = 22.3/2;
proxSensor_x = 17.5;
proxSensor_y = 17.5;
proxSensor_z = 35;


module lowerLayerShape()
{
    union(){
	// Draw the basic profile
	linear_extrude(height= upperHeight,center = false,convexity=10,scale=upperScaleFactor)
	triangleShape();
	
	translate([0,0,-middleHeight]) linear_extrude(height= middleHeight,center = false)
	triangleShape();
	
	translate([0,0,-middleHeight]) rotate([180,0,0]) 
	linear_extrude(height=downHeight, center = false, scale=underScaleFactor)
	triangleShape();

    }

}
    

module lowerLayer(){
    difference(){
	union(){
	    //hull(){ 
		lowerLayerShape();
		//for(i=[0,1])mirror([0,i,0])rotate([0,0,-30])translate([0,baseShapeRadius*sqrt3/3-10,0])rotate([70,0,0])
		//cube([25,10,25],center=true);
	    //}
	    
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




module V6Profile()
{
    cylinder(r= V6SinkRadius+1.5, h=26);
    cylinder(r= 8, h= 34);
    cylinder(r= 6, h= 40);
    translate([0,0,39])cylinder(r= 8, h=6);
    
}
    
module upperLayer()
{
    difference(){
	// Basic shape
	minkowski(){
	    union(){
		// Heat Sink mount
		translate([0,0,8])
		rotate([0,0,0])
		linear_extrude(height=V6SinkHeight-10, scale=0.6) scale([0.35, 0.35, 1]) triangleShape();
		
		
		for(i=[0:120:240])
		rotate([0,0,i])
		translate([V6SinkRadius,0,0])
		{
		    translate([0,0, V6SinkHeight/3-2])cube([V6SinkRadius, V6SinkRadius*.7, V6SinkHeight/3],center=true);
		    hull(){
			translate([V6SinkRadius*0.5,0, V6SinkHeight/3-2])cube([1, V6SinkRadius*.7, V6SinkHeight/3],center=true);
			translate([18,0,.5]) cube([2, V6SinkRadius*.8, 1],center=true);
		    }
		}
		
	    }
	    
	    // smooth the profile
	    cylinder( r=3.5, h=3);
	}
	translate([0,0,-14]) V6Profile();

	// Heat sink cooling fan
	
    }
    
}


module upperPart(){

    // prox sensor mount
    #translate([V6SinkRadius + proxSensor_x/2, 0, -13])
    cube([proxSensor_x, proxSensor_y, proxSensor_z], center=true);

    difference(){
	import("./upperLayer.stl");
	// Heat sink cooling fan
	#translate([-16,0,-1])
	rotate([0,90,0])
	minkowski(){
	    cube([21,21,8],center=true);
	    cylinder(r=2, h=1, center=true);
	}

	// Print fans
	for(i=[-1,1])
	#rotate([0,0,i*120])
	translate([-30,0,-5])
	rotate([0,75,0])//-i*15])
	minkowski(){
	    cube([31,31,8], center=true);
	    cylinder(r=2, h=1, center=true);
	}
    }
    
}
 

module body()
{
    difference(){
	union(){
	    lowerLayer();
            translate([0,0,upperHeight-4]) upperPart();

//	    for(i=[0,1])mirror([0,i,0])rotate([0,0,30])
//	    translate([0,-(baseShapeRadius+4)*sqrt3/3,3])
//	    rotate([10,0,0])
//	    fanCone();
	}


	//translate([0,0,-27.5])cylinder(r=grooveHoleRadius+5, h= 70, center=true);
	//%translate([0,0,5])cylinder(r=10, h= 70, center=true);
	

//	translate([-35,0,12])rotate([0,0,0]) //fanCone();
//	minkowski(){
//	    cube([50,25-roundness*2,25-roundness*2],center=true);
//	    rotate([0,90,0])cylinder(r=roundness, h=1,center=true);
//	}
	// wind holes
	//translate([18,0,25])
//	for(i=[-10:5:10])
//	translate([25,i,12])
//	hull(){
//	    rotate([0,90,0])cylinder(r=1.1, h=40,center=true);
//	    translate([0,0,8-i*i*.03]) rotate([0,90,0])cylinder(r=1.1, h=40, center=true);
//	}
	
//	for(i=[0,1])mirror([0,i,0])rotate([0,0,30])
//	translate([0,-(baseShapeRadius+4)*sqrt3/3,3])
//	rotate([10,0,0])
//	fanConeInner();

    }
}


//color("grey")
 body();
!upperLayer();

color("silver") translate([-2,0,-29]) rotate([0,0,0])import("./e3d-v6.stl");

//translate([100,0,0])
//baseShape();


