use <roundedBox.scad>
use <microswitch.scad>


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
middleHeight = 0.5;


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



lidHeight= 25;




module lid(){
    
    difference(){
	union(){
	    hull(){
		translate([0,0,0])
		linear_extrude(height=1,center=false)
		scale([0.75,0.75,1])
		triangleShape();
		
		translate([0,0,lidHeight])
		linear_extrude(height=1,center=false)
		scale([0.5,0.5,1])
		triangleShape();

		
		translate([-18,0,pivotRadius-1])rotate([90,0,0])
		cylinder(r= pivotRadius-1, h= innerPivotWidth + 2*outerPivotWidth, center=true);
	    }
	    
	    translate([pivotFarback,0, pivotRadius-1])rotate([90,0,0])
	    cylinder(r= pivotRadius, h=innerPivotWidth + 2*outerPivotWidth, center=true);
	    
	}
	
	// leave the outer space for the base pivot
%	translate ([pivotFarback,-innerPivotWidth/2,pivotRadius-1])rotate([90,0,0]) 
	cylinder(r= pivotRadius + 0.8, h= outerPivotWidth+1, center = true);
	
	translate ([pivotFarback,innerPivotWidth/2,pivotRadius-1])rotate([90,0,0]) 
	cylinder(r= pivotRadius + 0.8, h= outerPivotWidth+1, center = true);
	
	// drill a m3 hole 
	translate([pivotFarback,0, pivotRadius-1])rotate([90,0,0])
	cylinder(r= m3ScrewRadius, h=longEdge, center = true);
	
	// drill two m3 nut head
	translate([pivotFarback, -innerPivotWidth/2 - outerPivotWidth - 7, pivotRadius-1])rotate([90,0,0]) 
	cylinder(r=m3ScrewHeadRadius+err, h=15, center=true);
	translate([pivotFarback, innerPivotWidth/2 + outerPivotWidth+7, pivotRadius-1])rotate([90,0,0]) 
	cylinder(r=m3NutRadius+err, h=15, center=true, $fn=6);
	
	// leave the grooveMount space
	translate([0,0,-12.5])grooveShape();
	translate([0,0, 7])cylinder(r=8 + err, h=4.0, center=true);
	cylinder(r=3, h=40, center=true);

	// leave for the nut for quick fit
	translate([0,0, 10.5]) cylinder(r=m5NutRadius,h=6,$fn=6, center=true);
	
	//grouve Mounting holes
	for (i=[60:60:120])
	rotate([0,0,i]) {
	    translate([grooveMountScrewRadius, 0,0]) cylinder(r=m3ScrewRadius, h=30,center=true);
	    translate([grooveMountScrewRadius, 0,20]) cylinder(r=m3ScrewHeadRadius, h= 20, center=true);
	}
	
	for (i=[240:60:300])
	rotate([0,0,i]) {
	    translate([grooveMountScrewRadius, 0,0]) cylinder(r=m3ScrewRadius, h=30,center=true);
	    translate([grooveMountScrewRadius, 0,20]) cylinder(r=m3ScrewHeadRadius, h= 20, center=true);
	}
	
	// leave the space for mount the microswitch
	//translate([grooveHoleRadius+8/2,0, 0]) 
	//	{
	//		cube([8, 22, 22],center=true);
	//		translate([0,0,7])rotate([0,180, 90])%microswitch();
	//	}
	// mount the microswitch
	
	// Leave a m3Screw hole for mounting the pulling
	translate([longEdge*sqrt3/3-7,0,0]) cylinder(r=m3ScrewRadius, h=20, center=true);
	translate([longEdge*sqrt3/3-7,0,5]) cylinder(r=m3NutRadius, h=4, center=true, $fn=6);

	// Leave a m3Screw hole for triggering the microswitch
	translate([grooveHoleRadius + 2.8, 2.5, -1]) cylinder(r=m3ScrewRadius, h=100, center=true);
	translate([grooveHoleRadius + 2.8, 2.5, 2*pivotRadius+5]) cylinder(r=m3ScrewHeadRadius, h=2*pivotRadius+8, center=true);
	
	//make a flat bottom
	translate([0,0,-1.0]) cube([100,100,3],center = true);

	// Leave a hole for wires to pass through
	translate([-10,0,0]) roundedBox([m3ScrewRadius*2.5, m3ScrewRadius*5+2,  100], m3ScrewRadius, center=true);
	translate([-22,0,1]) rotate([0,90,0]) roundedBox([m3ScrewRadius*2, m3ScrewRadius*6.5,  50], m3ScrewRadius, center=true);
	translate([-22,0,-1]) rotate([0,60,0]) roundedBox([m3ScrewRadius*2, m3ScrewRadius*6.5,  30], m3ScrewRadius, center=true);
	translate([-22,0,-1]) rotate([0,-60,0]) roundedBox([m3ScrewRadius*2, m3ScrewRadius*6.5,  30], m3ScrewRadius, center=true);
    }
}



//**************************************** New ********************

module lowerLayerShape(){
    difference(){
	union(){
	    difference(){
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

	    // Draw Pillars for Ball Joints
	    for (i=[30:120:270])
	    for (j=[-1,1])
	    translate ([j*cos(i)*ballSeperateDistance/2, j*sin(i)*ballSeperateDistance/2,0])
	    translate ([sin(i)*(baseShapeRadius/2-roundness/2), -cos(i)*(baseShapeRadius/2-roundness/2),0]) 
	    rotate([cos(i)*ballJointAngle, sin(i)*ballJointAngle,0]) pillar();  
		
	}
	// Minus screw holes
	
	for (i=[30:120:270])
	for (j=[-1,1])
	translate ([j*cos(i)*ballSeperateDistance/2, j*sin(i)*ballSeperateDistance/2,0])
	translate ([sin(i)*(baseShapeRadius/2-roundness/2), -cos(i)*(baseShapeRadius/2-roundness/2),0]) 
	rotate([cos(i)*ballJointAngle, sin(i)*ballJointAngle,0]) 
	{
	    cylinder(r=m4ScrewRadius, h=20, center = true);
	    translate([0,0,-6]) cylinder(r=m4ScrewHeadRadius, h=12, center=true);
	}
    }
}



module lowerLayer()
{
    lowerLayerShape();
}


lowerLayer();

color("silver")
translate([0,0,-24])
import("./e3d-hotend-V5.stl");

translate([100,0,0])
baseShape();


//color([0.5,1,0.2],0.5) 	
%translate([100,0, upperHeight])
lid();

