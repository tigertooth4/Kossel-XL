use <wheel.scad>
use <roundedBox.scad>


$fn=60;

extrudeWidth = 20.0 ;
// Distance from wheel center to side of extrusion
wheelCenterExtrusionOffset = 8.15 ;  // 8.2 for general use // was 8.25
 
wheelCentersDistance = (wheelCenterExtrusionOffset * 2 + extrudeWidth);//cos(45);
wheelOriginDistance = wheelCentersDistance/2/cos(45);

centerCircleRadius = 5.0;
wheelRadius = 10;
wheelThickness = 6;

m4ScrewRadius = 2.0; //for M4 bolt
m4ScrewHeadRadius = 4.0; 
m4NutRadius = 4.3;

m3ScrewRadius = 1.5; //for M3 bolt
m3ScrewHeadRadius = 3.0; 
m3NutRadius = 3.5; //


m25ScrewRadius = 1.25;
m25ScrewHeadRadius = 2.5;
m3NutRadius = 3;

cylinderMaxRadius = 7; // enough
cylinderMinRadius = 3;
cylinderHeight = 7.0;

carriageThickness = 9;

extrusionX = -wheelOriginDistance+wheelCenterExtrusionOffset; //leftSide
extrusionY = -40;
extrusionZ = -25;


ballSeperateDistance = 48.0;
ballScrewRadius = 2.0;
ballJointAngle = 30;
ballJointRadius = 5;
ballBaseRadius = 5;
wingThickness = 6;

beltWidth = 6.0;
beltThickness = 1.1;


module Xshape(){ //(1/3, 3.0)
    polygon([[1.5, 0.], [1.51473, 0.132522], [1.56093, 0.275233], [1.64816, 
  0.441623], [1.82498, 0.664237], [2.7714, 1.29232], [2.85243, 
  1.64685], [2.7974, 1.95876], [2.66544, 2.23657], [2.47487, 
  2.47487], [2.23657, 2.66544], [1.95876, 2.7974], [1.64685, 
  2.85243], [1.29232, 2.7714], [0.664237, 1.82498], [0.441623, 
  1.64816], [0.275233, 1.56093], [0.132522, 1.51473], [0., 
  1.5], [-0.132522, 1.51473], [-0.275233, 1.56093], [-0.441623, 
  1.64816], [-0.664237, 1.82498], [-1.29232, 2.7714], [-1.64685, 
  2.85243], [-1.95876, 2.7974], [-2.23657, 2.66544], [-2.47487, 
  2.47487], [-2.66544, 2.23657], [-2.7974, 1.95876], [-2.85243, 
  1.64685], [-2.7714, 1.29232], [-1.82498, 0.664237], [-1.64816, 
  0.441623], [-1.56093, 0.275233], [-1.51473, 0.132522], [-1.5, 
  0], [-1.51473, -0.132522], [-1.56093, -0.275233], [-1.64816, 
-0.441623], [-1.82498, -0.664237], [-2.7714, -1.29232], [-2.85243, 
-1.64685], [-2.7974, -1.95876], [-2.66544, -2.23657], [-2.47487, 
-2.47487], [-2.23657, -2.66544], [-1.95876, -2.7974], [-1.64685, 
-2.85243], [-1.29232, -2.7714], [-0.664237, -1.82498], [-0.441623, 
-1.64816], [-0.275233, -1.56093], [-0.132522, -1.51473], [0., -1.5], 
[0.132522, -1.51473], [0.275233, -1.56093], [0.441623, -1.64816], 
[0.664237, -1.82498], [1.29232, -2.7714], [1.64685, -2.85243], 
[1.95876, -2.7974], [2.23657, -2.66544], [2.47487, -2.47487], 
[2.66544, -2.23657], [2.7974, -1.95876], [2.85243, -1.64685], 
[2.7714, -1.29232], [1.82498, -0.664237], [1.64816, -0.441623], 
[1.56093, -0.275233], [1.51473, -0.132522], [1.5, 0.]]);
}

module Xshape1(){ //(2/3, 3)
    polygon([[2.5, 0.], [2.53095, 0.22143], [2.62233, 0.462388], [2.77225, 
  0.742821], [2.99644, 1.09062], [3.45417, 1.61071], [3.57665, 
  2.06498], [3.55284, 2.48772], [3.41608, 2.86643], [3.18198, 
  3.18198], [2.86643, 3.41608], [2.48772, 3.55284], [2.06498, 
  3.57665], [1.61071, 3.45417], [1.09062, 2.99644], [0.742821, 
  2.77225], [0.462388, 2.62233], [0.22143, 2.53095], [0., 
  2.5], [-0.22143, 2.53095], [-0.462388, 2.62233], [-0.742821, 
  2.77225], [-1.09062, 2.99644], [-1.61071, 3.45417], [-2.06498, 
  3.57665], [-2.48772, 3.55284], [-2.86643, 3.41608], [-3.18198, 
  3.18198], [-3.41608, 2.86643], [-3.55284, 2.48772], [-3.57665, 
  2.06498], [-3.45417, 1.61071], [-2.99644, 1.09062], [-2.77225, 
  0.742821], [-2.62233, 0.462388], [-2.53095, 0.22143], [-2.5, 
  0.], [-2.53095, -0.22143], [-2.62233, -0.462388], [-2.77225, 
-0.742821], [-2.99644, -1.09062], [-3.45417, -1.61071], [-3.57665, 
-3.18198], [-2.86643, -3.41608], [-2.48772, -3.55284], [-2.06498, 
-3.57665], [-1.61071, -3.45417], [-1.09062, -2.99644], [-0.742821, 
-2.77225], [-0.462388, -2.62233], [-0.22143, -2.53095], [0., -2.5], 
[0.22143, -2.53095], [0.462388, -2.62233], [0.742821, -2.77225], 
[1.09062, -2.99644], [1.61071, -3.45417], [2.06498, -3.57665], 
[2.48772, -3.55284], [2.86643, -3.41608], [3.18198, -3.18198], 
[3.41608, -2.86643], [3.55284, -2.48772], [3.57665, -2.06498], 
[3.45417, -1.61071], [2.99644, -1.09062], [2.77225, -0.742821], 
[2.62233, -0.462388], [2.53095, -0.22143], [2.5, 0.]]);
    
}

module Xshape(){ //(1/2, 2.5)
    polygon([[1.5, 0.], [1.5248, 0.133403], [1.60008, 0.282137], [1.7318, 
  0.464035], [1.95765, 0.712527], [2.64344, 1.23266], [2.77744, 
  1.60355], [2.76483, 1.93596], [2.6577, 2.23007], [2.47487, 
  2.47487], [2.23007, 2.6577], [1.93596, 2.76483], [1.60355, 
  2.77744], [1.23266, 2.64344], [0.712527, 1.95765], [0.464035, 
  1.7318], [0.282137, 1.60008], [0.133403, 1.5248], [0., 
  1.5], [-0.133403, 1.5248], [-0.282137, 1.60008], [-0.464035, 
  1.7318], [-0.712527, 1.95765], [-1.23266, 2.64344], [-1.60355, 
  2.77744], [-1.93596, 2.76483], [-2.23007, 2.6577], [-2.47487, 
  2.47487], [-2.6577, 2.23007], [-2.76483, 1.93596], [-2.77744, 
  1.60355], [-2.64344, 1.23266], [-1.95765, 0.712527], [-1.7318, 
  0.464035], [-1.60008, 0.282137], [-1.5248, 0.133403], [-1.5, 
  0.], [-1.5248, -0.133403], [-1.60008, -0.282137], [-1.7318, 
-0.464035], [-1.95765, -0.712527], [-2.64344, -1.23266], [-2.77744, 
-1.60355], [-2.76483, -1.93596], [-2.6577, -2.23007], [-2.47487, 
-2.47487], [-2.23007, -2.6577], [-1.93596, -2.76483], [-1.60355, 
-2.77744], [-1.23266, -2.64344], [-0.712527, -1.95765], [-0.464035, 
-1.7318], [-0.282137, -1.60008], [-0.133403, -1.5248], [0., -1.5], 
[0.133403, -1.5248], [0.282137, -1.60008], [0.464035, -1.7318], 
[0.712527, -1.95765], [1.23266, -2.64344], [1.60355, -2.77744], 
[1.93596, -2.76483], [2.23007, -2.6577], [2.47487, -2.47487], 
[2.6577, -2.23007], [2.76483, -1.93596], [2.77744, -1.60355], 
[2.64344, -1.23266], [1.95765, -0.712527], [1.7318, -0.464035], 
[1.60008, -0.282137], [1.5248, -0.133403], [1.5, 0.]]);
}


module wheelHolder(){
    N = 8;
    difference(){
        union(){
	    translate([0,0,cylinderHeight+2]) cylinder(h=cylinderHeight+2, r=cylinderMaxRadius, center = true); 
	    
	    //translate([0,0,0.5]) cylinder(h=cylinderHeight+1,r1=cylinderMinRadius+1,r2=cylinderMaxRadius, center=true);
	    translate([0,0,0.5]) cylinder(h=cylinderHeight+1,r1=cylinderMinRadius+1,r2=cylinderMinRadius+2.5, center=true);
	    for (i=[0:N-1]){
            rotate([0,0, 360/N*i]) translate([0,0,-3.5]) hull(){
                translate([-0.5,0.5,0]) cube([1,cylinderMinRadius,1]);
                translate([-1,0,cylinderHeight]) cube([2,cylinderMaxRadius,1]);
            }
        }
     }   
     cylinder(h=cylinderHeight*3,r=m4ScrewRadius,center=true);
    
    }
}


sf = (wheelOriginDistance -wheelRadius/15 )/3.5;

echo(sf);



module Xcarriage(){
    difference(){
	intersection(){
	    union() {
		//hull() 
		scale([sf,sf,1])
		linear_extrude(height = carriageThickness, center = true, convexity = 10, scale =[1,1])
		Xshape();
		
		for (i=[0:3]){
		    translate([wheelOriginDistance*cos(45+90*i),wheelOriginDistance*sin(45+90*i),-cylinderHeight-2])
		    wheelHolder();
		    
		    //translate([wheelOriginDistance*cos(45+90*i), wheelOriginDistance*sin(45+90*i), -cylinderHeight*2]) 
		    //color("white") wheel(wheelRadius, m4ScrewRadius, wheelThickness);
        }
	    }
	    //translate([0,0,-91]) sphere (r=100,center=true, $fn=60);
	}
	for (i=[0:3]){
	    translate([wheelOriginDistance*cos(45+90*i),wheelOriginDistance*sin(45+90*i),-cylinderHeight-2])
	    cylinder(r=m4ScrewRadius, h=30);
	    
	    translate([wheelOriginDistance*cos(45+90*i),wheelOriginDistance*sin(45+90*i),-0.5])
	    cylinder(r=m4NutRadius, h=6, $fn=6);
	
 //       rotate([0,0,45+i*90])hull(){ translate([7,0,0])cylinder(r=2, h=15,center=true);
 //           translate([10,0,0])cylinder(r=2, h=15,center=true);}
        }
    }
}

module XcarriageBack(){
    difference(){
	intersection(){
	    union() {
		//hull() 
		scale([sf,sf,1])
		linear_extrude(height = carriageThickness*2/3, center = true, convexity = 10, scale =[1,1])
		Xshape();
		
		for (i=[0:3]){
		    translate([wheelOriginDistance*cos(45+90*i),wheelOriginDistance*sin(45+90*i),-cylinderHeight-3.5])
		    wheelHolder();
		    
		    //translate([wheelOriginDistance*cos(45+90*i), wheelOriginDistance*sin(45+90*i), -cylinderHeight*2]) 
		    //color("white") wheel(wheelRadius, m4ScrewRadius, wheelThickness);
            
        }
        
        // for holding the back wheel
//        translate([0,0,3.5])rotate([0,90,0])cylinder(r=6, h=15, center=true);
	    }

	}
	for (i=[0:3]){
	    translate([wheelOriginDistance*cos(45+90*i),wheelOriginDistance*sin(45+90*i),-cylinderHeight-2])
	    cylinder(r=m4ScrewRadius, h=30);
	    
	    translate([wheelOriginDistance*cos(45+90*i),wheelOriginDistance*sin(45+90*i),-0.5])
	    cylinder(r=m4ScrewHeadRadius, h=6);

        rotate([0,0,45+i*90])hull(){ translate([9,0,0])cylinder(r1=0.2, r2=4, h=6,center=true);
            translate([17,0,0])cylinder(r1=1, r2=4, h=8,center=true);}
        }
 
        // back wheel space
//        translate([0,0,3])rotate([0,90,0])scale([1.2,1.2,1.1])wheel(wheelRadius, m4ScrewRadius, wheelThickness);
//        translate([0,0,3.5])rotate([0,90,0])cylinder(r=m4ScrewRadius, h=30, center=true);    
        
        translate([0,0,101])sphere(r=100);
    }
    
}


module XcarriageBackWithWheel(){
    difference(){
        union(){
            XcarriageBack();
            translate([0,0,3])rotate([0,90,0])scale([1.2,1.2,1.1])wheel(wheelRadius, m4ScrewRadius, wheelThickness);
            translate([0,0,3.5])rotate([0,90,0])cylinder(r=m4ScrewRadius, h=30, center=true);   
        }
    }
}


module beltPlate(){
    difference(){
	union(){
	    translate([0,-extrudeWidth*.1,0])roundedBox([extrudeWidth, extrudeWidth*1.2, wingThickness], 2.5, true);
	    
	    //center cylinder for winding the belt
	    translate([-1,-extrudeWidth*.3,0])cylinder(r=beltWidth/2, h=beltWidth+wingThickness);
        difference(){
            translate([-2,-extrudeWidth*.35,0])cube([beltWidth/2+1, extrudeWidth*.8, beltWidth + wingThickness]);
	    
            //teeth
	        for (i = [-2:2:10]) translate([-beltThickness-.7, i,0 ]) cylinder(d=1.5, h=beltWidth + wingThickness+1);
            for (i = [-5:2:10]) translate([2.4*beltThickness-.7, i,0 ]) cylinder(d=1.5, h=beltWidth + wingThickness+1);    
	    }
        
        //left piece
	    translate([-beltThickness-.9,-2,0])
	    hull(){
		translate([-beltWidth/2, 0.1, wingThickness+beltWidth-1]) 
		cube([beltWidth/2-beltThickness, extrudeWidth*.75 - beltWidth+2, 1]);
		translate([-beltWidth-beltThickness, 0.1, wingThickness/2])
		cube([beltWidth , extrudeWidth*.75- beltWidth+2, 1]);
	    }
        
        //right piece
   	    translate([beltThickness-.9,-2,0])
	    hull(){
		translate([beltWidth/2, 0.1, wingThickness+beltWidth-1]) 
		cube([beltWidth/2-beltThickness, extrudeWidth*.75 - beltWidth+2, 1]);
		translate([beltWidth/2, 0.1, wingThickness/2])
		cube([beltWidth , extrudeWidth*.75- beltWidth+2, 1]);
	    }

	}
	translate([-2.7,-2,beltWidth+8.5])rotate([-90,0,0])cylinder(r=4,h=extrudeWidth,$fn=4);
	translate([2.5,-2,beltWidth+8.5])rotate([-90,0,0])cylinder(r=4,h=extrudeWidth,$fn=4);


	// Hole for insert a m2.5 nut
	// Position A
	// m2.5 nut space
	translate([-extrudeWidth*.25,-extrudeWidth*.45,-.5])
	cube([6,3,wingThickness+5],center=true);

	translate([-extrudeWidth*.25, -extrudeWidth*.45,0])
	rotate([-90,0,0])cylinder(r=m3ScrewRadius, h=60,center=true);


	// position B
	translate([extrudeWidth*.03,-extrudeWidth*.8,0])
	hull(){
	    translate([0,0,-0.5])cube([extrudeWidth*.2, extrudeWidth, 1],true);
	    translate([0,0,-2.5])cube([extrudeWidth*.17, extrudeWidth, 2],true);
	}

    }
}

module anotherEnd(){
    difference(){
	union(){
	    //base
	    translate([-extrudeWidth*0.055,0,0])
	    cube([extrudeWidth*.71, extrudeWidth, wingThickness], true);
	    
	    // base insert part
	    // you want to make the following aligned with B
	    translate([extrudeWidth*.03,extrudeWidth*.35,0])
	    hull(){
		translate([0,0,-1])cube([extrudeWidth*.15, extrudeWidth, 1],true);
		translate([0,0,-2.5])cube([extrudeWidth*.13, extrudeWidth, 1],true);
	    }

	    // right rectangular bound
	    translate([-beltThickness-.2,-extrudeWidth*.505,0])
	    mirror() hull(){
		translate([-beltWidth/2-.4, 0.1, wingThickness+beltWidth-1]) 
		cube([beltWidth/2-beltThickness, extrudeWidth, 1]);
		
		translate([-beltWidth*1.22, 0.1, wingThickness/2])
		cube([beltWidth , extrudeWidth, 1]);
	    }
	    //cube([beltWidth/2, extrudeWidth*.8, beltWidth + wingThickness]);

	    // left bound
	    difference(){
            translate([-beltThickness+0.2,-extrudeWidth*.505,0])
            hull(){
            translate([-beltWidth/2-.3, 0.1, wingThickness+beltWidth-1]) 
            cube([beltWidth/2+1.5-beltThickness, extrudeWidth, 1]);
		
            translate([-beltWidth*1.22, 0.1, wingThickness/2])
            cube([beltWidth+1.5 , extrudeWidth, 1]);
            }
	    
            for (i = [-5:2:15]) translate([-beltThickness+.3, i-extrudeWidth*.25,0 ])
            cylinder(d=1.5, h=beltWidth + wingThickness);
	    
        }
        //cube([3,1,beltWidth+wingThickness]);
	}
	// You want to make the following aligned with A
	translate([-extrudeWidth*.25, -extrudeWidth*.45,0])
	rotate([-90,0,0])cylinder(r=m3ScrewRadius+.2, h=60,center=true);

	translate([-extrudeWidth*.25, -extrudeWidth*.45,0])
	rotate([-90,0,0])cylinder(r=m3ScrewHeadRadius, h=20,center=true);

	translate([-.5,-extrudeWidth*.5,beltWidth+8.5])rotate([-90,0,0])cylinder(r=4,h=extrudeWidth,$fn=4);
	
    }
}

module wing(){
    difference(){
	union(){
	    for(i=[1,-1])
	    hull(){
		translate([i*ballSeperateDistance/2, 0, 0]) rotate([ballJointAngle, 0, 0])
		translate([0, 0, 1.2*wingThickness])
		cylinder(r=ballBaseRadius, h=5.7);
		
		translate([i*ballSeperateDistance/2, 0, 0]) 
		roundedBox([2*(ballBaseRadius+1), 2*(ballBaseRadius+1), wingThickness], 2.5, true);	
	    }

	    // horizontal arm
	    roundedBox([ballSeperateDistance, 2 * ballBaseRadius+1, wingThickness], 2.5, true);

	    // upper plate
	    //translate([-extrusionX-extrudeWidth/2,0,0]) 
        translate([+5,0,0]) beltPlate();
	    
	    // mirror it to get lower plate
	    //translate([-extrusionX-extrudeWidth/2,0,0]) mirror([0,1,0]) translate([0, 11, 0]) beltPlate();
	}
	
	for(i=[1,-1])
	translate([i*ballSeperateDistance/2 , 0, 0])
	rotate([ballJointAngle, 0, 0])
	translate([0, 0, -1.2*wingThickness])
	{
	    cylinder(h=50, r=ballScrewRadius);
	    translate([0,0,24]) sphere(r=ballJointRadius, center=true);
	    translate([0,0,0]) cylinder(h=11, r=m4ScrewHeadRadius);
	}	

	// endstop trigger screw holes
	//translate([1.5, 0.5 ,-1]) rotate([-90,0,0]) cylinder(h = 30,r=m3ScrewRadius);
    }
}


module wingWithScrewHoles(rr){
    difference(){
	
	//color([0.3,0.3,0.3])
	//translate([extrusionX+10, 0, carriageThickness-1.5]) wing();
    translate([0, 0, carriageThickness-1.5]) wing();
	
	
	for (i=[60:120:360]) translate([rr*cos(i)+1.5+6, rr*sin(i)-1,-40]) cylinder(r=m3ScrewRadius, h=100);
	for (i=[60:120:360]) translate([rr*cos(i)+1.5+6, rr*sin(i)-1, wingThickness + carriageThickness/2 - 3.0]) 
	cylinder(r=m3ScrewHeadRadius, h=3.0+0.1+beltWidth*2);
	
    }
}

	
module XcarriageWithScrewHoles(rr){
    difference(){
	color([0.3,0.3,0.3])Xcarriage();
	for (i=[60:120:360]) translate([rr*cos(i)+1.5+6, rr*sin(i)-1,-40])
	cylinder(r=m3ScrewRadius, h=100);
	for (i=[60:120:360]) translate([rr*cos(i)+1.5+6, rr*sin(i)-1,-carriageThickness/2])
	cylinder(r=m3NutRadius, h=3, $fn=6);
	translate([-8,-2.5,-4.5]) cube([20,3,.5]);	
    }
}


//color([0.2,0.2,0.2])
//wingWithScrewHoles(9);

!union(){
translate([0, 1, carriageThickness-1.5]) wing();
color([0.3,0.3,0.3])Xcarriage();
}

translate([+5,-2*extrudeWidth,carriageThickness-1.5]) anotherEnd();

//color("black")
//XcarriageWithScrewHoles(9);

//color([0.3,0.3,0.3])translate([0,0,-29])mirror([0,0,1])XcarriageBack();

/*for (i=[0:3]){
		    translate([wheelOriginDistance*cos(45+90*i), wheelOriginDistance*sin(45+90*i), -cylinderHeight*2]) 
		    color("white") wheel(wheelRadius, m4ScrewRadius, wheelThickness);
}*/

//translate([0,0,-wheelCenterExtrusionOffset-extrudeWidth-5]) color("white")rotate([0,90,0])wheel(wheelRadius, m4ScrewRadius, wheelThickness);

//% translate([-10, extrusionY, extrusionZ]) cube([20,80,20]);
