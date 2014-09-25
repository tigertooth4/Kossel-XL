ramps_x = 120;
ramps_y = 70;
ramps_z = 60;

lcd_x = 160;
lcd_y = 80;//70
lcd_z = 25;

m4ScrewRadius=2.0;
m3ScrewRadius=1.5;
m3ScrewHeadRadius=3;

thickSkeleton = 4;
thick=3;

err=.3;

module rampsSideShape(){
    minkowski(){
	hull(){
	    translate([0,-28])square([ramps_y,ramps_z],center=true);
	    translate([-50,10])rotate(60)square([lcd_y,lcd_z],center=true);
	}
	circle(r=5,center=true, $fn=20);
    }
}

//rampsSideShape();

module skeletonSide(){
    union(){
	difference(){
	    rotate([90,0,90])linear_extrude(height=thickSkeleton*3.5, center=true) scale(0.99) rampsSideShape();
	    translate([thickSkeleton-2,0,0])rotate([90,0,90])linear_extrude(height=thickSkeleton*3+1, center=true)
	    scale(0.90) rampsSideShape();
	    // make a slot
	    hull(){
		translate([0,-15,20])cube([thickSkeleton*4, 20+.5,20+.5],center=true);
		translate([0,-15,50])cube([thickSkeleton*4, 20+.5,20+.5],center=true);
	    }

	    // dig some nonstructural holes
	    for(y=[-30,-5,20]) for(z=[-40,-10])
	    translate([0,y,z])rotate([0,90,0])cylinder(r=10,h=thickSkeleton*4,center=true,$fn=20);


	    // dig a long unstructural hole 
	    hull(){
		translate([0,-38,35])rotate([0,90,0])cylinder(r=8,h=thickSkeleton*4,center=true,$fn=20);
		translate([0,-63,-10])rotate([0,90,0])cylinder(r=8,h=thickSkeleton*4,center=true,$fn=20);
	    }

	    // m3 Screw Head, for mounting the ramps board
	    for(i=[-20:20:20])
	    translate([6,i, -60])
	    hull(){
		cylinder(r=m3ScrewHeadRadius,h=thickSkeleton*2, center=true, $fn=20);
		translate([-8,0,0])cylinder(r=m3ScrewHeadRadius, h=thickSkeleton*2, center=true,$fn=20);
	    }

	    // m3 screw to mount lcd pannel
	    rotate([60,0,0])translate([6,-41,60])
	    hull(){
		cylinder(r=m3ScrewRadius-err/2,h=thickSkeleton*14,center=true,$fn=20);
		translate([-8,0,0])cylinder(r=m3ScrewRadius-err/2,h=thickSkeleton*14,center=true,$fn=20);
	    }

	    rotate([60,0,0])translate([6,9,60])
	    hull(){
		cylinder(r=m3ScrewRadius-err/2,h=thickSkeleton*14,center=true,$fn=20);
		translate([-8,0,0])cylinder(r=m3ScrewRadius-err/2,h=thickSkeleton*14,center=true,$fn=20);
	    }

	    // this is for mount the lcd, lcd back has some bumps, therefore to avoid this
	    rotate([60,0,0])translate([2.5,-16,60])
	    cube([10,42,30],center=true);

	    // a lot of m3 screw holes
	    
	    // upper face screw holes
	    rotate([-30,0,0])
	    for(j=[20,-20])
	    translate([1.5,j*2-15,14-j/10])
	    hull(){
		translate([-4,0,0])cylinder(r=m3ScrewRadius-err/2, h= 40,$fn=20);
		translate([3,0,0])cylinder(r=m3ScrewRadius-err/2, h= 40,$fn=20);
	    }
	    
	    // back face screw holes
	    rotate([-90,0,0])
	    for(j=[25,-25])
	    translate([1.5,j+30,22])
	    hull(){
		translate([-4,0,0])cylinder(r=m3ScrewRadius-err/2, h= 40,$fn=20);
		translate([3,0,0])cylinder(r=m3ScrewRadius-err/2, h= 40,$fn=20);

	    }

	    // bottom faces screw holes
	    rotate([180,0,0])
	    for(j=[30,-30])
	    translate([1.5,j,40])
	    hull(){
		translate([-4,0,0])cylinder(r=m3ScrewRadius-err/2, h= 40,$fn=20);
		translate([3,0,0])cylinder(r=m3ScrewRadius-err/2, h= 40,$fn=20);

	    }

	    rotate([145,0,0])
	    for(j=[20])
	    translate([1.5,j+25,52])
	    hull(){
		translate([-4,0,0])cylinder(r=m3ScrewRadius-err/2, h= 40,$fn=20);
		translate([3,0,0])cylinder(r=m3ScrewRadius-err/2, h= 40,$fn=20);

	    }

	}
	
	// m3 screw  support to mount ramps board
	for(i=[-20:20:20])
	translate([5,i,-58])
	difference(){
	    hull(){
		cylinder(r=6, h=thickSkeleton-1, $fn=20);
		translate([-7,0,0])cylinder(r=5,h=thickSkeleton-1,$fn=20);
	    }
	    
	    hull(){
		cylinder(r=m3ScrewRadius,h=thickSkeleton*10,center=true,$fn=20);
		translate([-8,0,0])cylinder(r=m3ScrewRadius,h=thickSkeleton*10,center=true,$fn=20);
	    }
	}
	
	// mount to aluminum
	difference(){
	    translate([13,-15,19]) cube([40, 20+10, 20+5],center=true);

	    hull(){
		translate([13,-15,20]) cube([42, 21, 21],center=true);
		translate([13,-15,50]) cube([42, 21, 21],center=true);
	    }

	    // dig some m4 holes to mount to the aluminum
	    for(x=[10,25])translate([x, -15,20])cylinder(r=m4ScrewRadius, h=60,center=true,$fn=20);
	    for(x=[10,25])translate([x, 0, 20]) rotate([90,0,0])cylinder(r=m4ScrewRadius, h=70, center=true, $fn=20);
	    
	}

	//support materials
	//translate([-4,-25,36])cube([thickSkeleton*6,thickSkeleton*2,thickSkeleton*3.3]);
	//translate([-4,1,20])cube([thickSkeleton*2.5, thickSkeleton*5.6, thickSkeleton]);
	//translate([-4,1,25])cube([thickSkeleton*2.5, thickSkeleton*3.3, thickSkeleton]);
	//translate([-4,1,10])cube([thickSkeleton*6, thickSkeleton*2, thickSkeleton]);

    }


}


module skeleton_ramps(){
    difference(){
	minkowski(){
	    cube([lcd_x-10-thickSkeleton/1.5*2,ramps_y-thickSkeleton*3, thickSkeleton/3],center=true);
	    cylinder(r=thickSkeleton/1.5,h=thickSkeleton/3,center=true);
	}

	// leave holes to save filament
	for(i=[-50,-25,0,25,50])translate([i,0,0])cylinder(r=10,h=thickSkeleton, center=true,$fn=20);
	
	// Ramps mount slot
	translate([0,-24,0])cube([lcd_x-thickSkeleton*7, m3ScrewRadius*2,thickSkeleton],center=true);
	translate([0,24,0])cube([lcd_x-thickSkeleton*7, m3ScrewRadius*2,thickSkeleton],center=true);

	// m3 screw holes on two sides
	translate([-lcd_x/2+8,0,0])cylinder(r=m3ScrewRadius,h=thickSkeleton*10,center=true,$fn=20);
	translate([-lcd_x/2+8,20,0])cylinder(r=m3ScrewRadius,h=thickSkeleton*10,center=true,$fn=20);
	translate([-lcd_x/2+8,-20,0])cylinder(r=m3ScrewRadius,h=thickSkeleton*10,center=true,$fn=20);


	translate([lcd_x/2-8,0,0])cylinder(r=m3ScrewRadius,h=thickSkeleton*10,center=true,$fn=20);
	translate([lcd_x/2-8,20,0])cylinder(r=m3ScrewRadius,h=thickSkeleton*10,center=true,$fn=20);
	translate([lcd_x/2-8,-20,0])cylinder(r=m3ScrewRadius,h=thickSkeleton*10,center=true,$fn=20);
	
    }

}

//skeleton_ramps();

module rampsCase(){
    difference(){
	union(){
	    rotate([90,0,90])
	    difference(){
		translate([2,1,0]) linear_extrude(height=lcd_x+thick*2,center=true)  scale([1.1,1.1]) rampsSideShape();
		linear_extrude(height=lcd_x+thick*2+10,center=true) rampsSideShape();
		
	    }
	    // a tail like hole for extrutor wires
	    translate([0,38,-20])
	    intersection(){
		rotate([60,0,0])cylinder(r=10, h=10,center=true, $fn=20);
		translate([0,0,4])cube([25,15,20],center=true);
	    }
	
	}

	// 30x30 fans mounting hole
	for(i=[-40,40])translate([i,42,-30])rotate([-90,0,0])union(){
	    //cube([36,36,8],center=true);
	    for(i=[-11.75,11.75])for(j=[-11.75,11.75])translate([i,j,0])
	    cylinder(r=m3ScrewRadius, h=20, center=true, $fn=20);
	    cylinder(r=14,h=10,center=true,$fn=20);
	    translate([0,0,-0.5])minkowski(){
		cube([30,30,4],center=true);
		cylinder(r=2,h=1,center=true,$fn=20);
	    }
	}
	

	//wind holes at the bottom
	for(i=[-60:20:60])translate([i,-60,-40])rotate([50,0,0])hull(){
	    translate([0,0,10])rotate([90,0,0])cylinder(r=thick*2, h=20, center=true, $fn=20);
	    translate([0,0,-10])rotate([90,0,0])cylinder(r=thick*2, h=20, center=true, $fn=20);
	}

	//wind holes at the top
	for(i=[-40:20:40]) translate([i,0,40])rotate([55,0,0]) hull(){
	    translate([0,0,20])rotate([90,0,0])cylinder(r=thick*2, h=20, center=true, $fn=20);
	    translate([0,0,-20])rotate([90,0,0])cylinder(r=thick*2, h=20, center=true, $fn=20);
	}

	// a hole for extrutor wires
	translate([0,35,-16])rotate([60,0,0])cylinder(r=6, h=40,center=true, $fn=20);
    }
}


module rampsCaseSide(){
    union(){
	difference(){
	    union(){
		rotate([90,0,90])
		translate([2,1,0])linear_extrude(height=thick, center=true) scale([1.1,1.1]) rampsSideShape();
		translate([-thick/2,-15,20]) cube([thick*2, 20+thick,20+thick],center=true);
	    }
	    
	    // make an aluminum mounting hole
	    translate([0,-15,20])cube([thick*4, 20+.5,20+.5],center=true);
	    // make some extra space for wires
	    translate([0,-15,30])rotate([0,90,0])cube([6,6,20],center=true);
	    
	    // make some heat holes
	    for(i=[-40:20:20]) translate([0,i,-30])
	    hull(){
	        translate([0,0,15])rotate([0,90,0]) cylinder(r=thick*2, h=20, center=true, $fn=20);
	        translate([0,0,-15])rotate([0,90,0]) cylinder(r=thick*2, h=20, center=true, $fn=20);
	    }
	    
	    // m3 screw holes at corners
	    translate([0,-88,-20])rotate([0,90,0]){
		cylinder(r=m3ScrewRadius, h= 20, center=true, $fn=20);
		translate([0,0,-10])cylinder(r=m3ScrewHeadRadius, h=20, center=true, $fn=20);}
	    
	    translate([0,-43,58])rotate([0,90,0]){
		cylinder(r=m3ScrewRadius, h= 20, center=true, $fn=20);
		translate([0,0,-10])cylinder(r=m3ScrewHeadRadius, h=20, center=true, $fn=20);}
	    
	    translate([0,41,4])rotate([0,90,0]){
		cylinder(r=m3ScrewRadius, h= 20, center=true, $fn=20);
		translate([0,0,-10])cylinder(r=m3ScrewHeadRadius, h=20, center=true, $fn=20);}
	    
	    translate([0,41,-63])rotate([0,90,0]){
		cylinder(r=m3ScrewRadius, h= 20, center=true, $fn=20);
		translate([0,0,-10])cylinder(r=m3ScrewHeadRadius, h=20, center=true, $fn=20);}
	    
	    translate([0,-37,-63])rotate([0,90,0])
	    {
		cylinder(r=m3ScrewRadius, h= 20, center=true, $fn=20);
		translate([0,0,-10])cylinder(r=m3ScrewHeadRadius, h=20, center=true, $fn=20);
	    }
	    
	}
    }

    // Pattern
    translate([0,-4,-20])
    intersection(){
	union(){
	    for(i=[-16:5:80])translate([0,i-42.5,-10])
	    cube([thick,1,40],center=true);
	    
	    rotate([60,0,0])for(i=[-12:5:90])translate([0,i-50,0])
	    cube([thick,1,100],center=true);

	    rotate([120,0,0])for(i=[-6:5:90])translate([0,i-50,0])
	    cube([thick,1,100],center=true);

	}

	translate([2,-5,-10])cube([thick, 80, 60],center=true);
	
    }


}



module lcdPanel(){
    difference(){
	minkowski(){
	    cube([lcd_x-10-thick/1.5*2,lcd_y-thick*3,thick/3],center=true);
	    cylinder(r=thick/1.5, h=thick/3, center=true);
	}

	// leave holes for m3 screw to mount the lcd module
	for(i=[-72.5,72.5]) for(j=[-25,25])
	translate([i,j,0])cylinder(r=m3ScrewRadius, h=20, center=true, $fn=20);
	
    }
    // draw some actual m3 screws
    for(i=[-72.5,72.5]) for(j=[-25,25])
    translate([i,j-1,15])cylinder(r=m3ScrewRadius, h=20, center=true, $fn=20);

    // m3 screw heads
    for(i=[-72.5,72.5]) for(j=[-25,25])
    translate([i,j-1,20])
	cylinder(r=m3ScrewHeadRadius, h=20, center=true, $fn=20);

    // lcd module place
    translate([-12.5,-7,7])cube([98,40,14],center=true);

    // tunner place
    translate([60.5,15,10]) cylinder(r=8,h=5,center=true,$fn=20);
    translate([62.5,-4,10]) cylinder(r=5, h=20, center=true,$fn=20);
    translate([61.5,-21,10]) cylinder(r=3, h=20, center=true,$fn=20);

    //sd card slot
    translate([-60,-4,-2])cube([60,35,8],center=true);
}



module rampsCaseWithAssemblyHoles(){
  
    difference(){
	//lcd panel face
	union(){
	    //color([1,0.3,0.3])
	    rampsCase();

	    // m3 screw holes at corners
	    for(i=[-lcd_x/2,lcd_x/2])translate([i,0,0]){
		translate([0,-87,-19])rotate([0,90,0])
		hull(){
		    cylinder(r=m3ScrewHeadRadius, h=thick*2, center=true, $fn=20);
		    translate([0,thick/2,0])cylinder(r=m3ScrewHeadRadius, h=thick*2, center=true, $fn=20);
		}
		    
		translate([0,-43,56])rotate([0,90,0])
		hull(){
		    cylinder(r=m3ScrewHeadRadius, h=thick*2, center=true, $fn=20);
		    translate([0,thick/2,0])cylinder(r=m3ScrewHeadRadius, h=thick*2, center=true, $fn=20);
		}
		
		translate([0,40,4])rotate([0,90,0])
		hull(){
		    translate([thick/2,0,0])cylinder(r=m3ScrewHeadRadius, h=thick*2, center=true, $fn=20);
		    translate([-thick/2,0,0])cylinder(r=m3ScrewHeadRadius, h=thick*2, center=true, $fn=20);
		}
		
		translate([0,40,-62])rotate([0,90,0]) hull(){
		    translate([thick/2,0,0])cylinder(r=m3ScrewHeadRadius, h=thick*2, center=true, $fn=20);
		    translate([-thick/2,0,0])cylinder(r=m3ScrewHeadRadius, h=thick*2, center=true, $fn=20);
		}

		translate([0,-37,-62])rotate([0,90,0]) hull(){
		    translate([0,-thick/2,0])cylinder(r=m3ScrewHeadRadius, h=thick*2, center=true, $fn=20);
		    translate([0,thick/2,0])cylinder(r=m3ScrewHeadRadius, h=thick*2, center=true, $fn=20);
		}

	    }


	}

	// leave m3 holes for side panel mount

	// m3 screw holes at corners
	for(i=[-lcd_x/2-thick/2,lcd_x/2+thick/2])translate([i,0,0]){
	    translate([0,-88,-20])rotate([0,90,0])cylinder(r=m3ScrewRadius, h=thick*10, center=true, $fn=20);
	    translate([0,-43,58])rotate([0,90,0])cylinder(r=m3ScrewRadius, h=thick*10, center=true, $fn=20);
	    translate([0,41,4])rotate([0,90,0])cylinder(r=m3ScrewRadius, h=thick*10, center=true, $fn=20);
	    translate([0,41,-63])rotate([0,90,0])cylinder(r=m3ScrewRadius, h=thick*10, center=true, $fn=20);
	    translate([0,-37,-63])rotate([0,90,0])cylinder(r=m3ScrewRadius, h=thick*10, center=true, $fn=20);
	}

	translate([0,-58,16])rotate([60,0,0])lcdPanel();

	// top face screw holes
	rotate([-30,0,0])
	for(i=[-72.5,72.5]) for(j=[20,-20])
	translate([i,j*2-15,14-j/10]){
	    translate([0,0,25])cylinder(r=m3ScrewHeadRadius, h= 20, center=true, $fn=20);
	    cylinder(r=m3ScrewRadius, h= 40,$fn=20);
	}

	// back face screw holes
	rotate([-90,0,0])
	for(i=[-72.5,72.5]) for(j=[25,-25])
	translate([i,j+30,22]){
	    translate([0,0,31])cylinder(r=m3ScrewHeadRadius, h= 20, center=true, $fn=20);
	    cylinder(r=m3ScrewRadius, h= 40,$fn=20);
	}

	// bottom faces screw holes
	rotate([180,0,0])
	for(i=[-72.5,72.5]) for(j=[30,-30])
	translate([i,j,51]){
	    translate([0,0,25])cylinder(r=m3ScrewHeadRadius, h= 20, center=true, $fn=20);
	    cylinder(r=m3ScrewRadius, h= 40,$fn=20);
	}

	// bottom front faces screw holes
	rotate([145,0,0])
	for(i=[-72.5,72.5]) for(j=[20])
	translate([i,j+25,52]){
	    translate([0,0,27])cylinder(r=m3ScrewHeadRadius, h= 20, center=true, $fn=20);
	    cylinder(r=m3ScrewRadius, h= 40,$fn=20);
	}

    }

    
}










module rampsLcdFace(){
    union(){
	intersection(){
	    rampsCaseWithAssemblyHoles();
	    // cut piece
	    rotate([60,0,0])translate([0,-25,65])cube([lcd_x*2,lcd_y+thick*2, thick*5.3],center=true);
	    
	}
    	translate([-12, -88, -10])
	rotate([60,0,0])scale([0.15, 0.15, 0.2]) import("logotype.stl");
    }
}






module rampsTopFace(){
    union(){
	intersection(){
	    rampsCaseWithAssemblyHoles();
	    ////////
	    union(){
		rotate([60,0,0])translate([0,27+err,25])cube([lcd_x*2,thick*6,100],center=true);
		translate([0,35,12])cube([lcd_x*2,thick,thick*4],center=true);
	    }

	}
	
	// Pattern
	translate([-1,-4,35])rotate([57.5,0,0])rotate([0,0,90])intersection(){
	    union(){
		for(i=[-16:5:90])translate([0,i-42.5,-10])
		cube([thick,1,100],center=true);
		
		rotate([60,0,0])for(i=[-12:5:90])translate([0,i-50,0])
		cube([thick,1,100],center=true);
		
		rotate([120,0,0])for(i=[-6:5:90])translate([0,i-50,0])
		cube([thick,1,100],center=true);
		
	    }
	    cube([thick/2, 100, 60],center=true);
	    
	}
    }
}


module rampsBackFace(){
    intersection(){
	rampsCaseWithAssemblyHoles();

	union(){
	    translate([0,45+err,-30])rotate([90,0,0])cube([lcd_x*2,85,thick*5.7],center=true);
	    translate([0,37,-60])cube([lcd_x*2,10, 20],center=true);
	}
    }
}

module rampsBottomFace(){
    union(){
	intersection(){
	    rampsCaseWithAssemblyHoles();
	    ////////
	    union(){
		translate([0,-43-err,-65])cube([lcd_x*2,150,thick*4],center=true);
		translate([0,-62.5-err/2,-45])rotate([-30,0,0])cube([lcd_x*2,50,thick*7],center=true);
	    }
	}

	// Pattern
	translate([0,-57,-47])rotate([49,0,0])rotate([0,0,90])intersection(){
	    union(){
		for(i=[-50:5:120])translate([0,i-42.5,-10])
		cube([thick,1,100],center=true);
		
		rotate([60,0,0])for(i=[-10:5:120])translate([0,i-50,0])
		cube([thick,1,150],center=true);
		
		rotate([120,0,0])for(i=[-10:5:120])translate([0,i-50,0])
		cube([thick,1,150],center=true);
		
	    }
	    cube([thick/2, 150, 47],center=true);
	    
	}

    }
}


/////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////
// extrusion
////////////////////
%color([0.8,0.8,0.8])translate([0,-15,20])cube([2*lcd_x, 20,20],center=true);


/////////////////////
// ramps board skeleton
/////////////////////
//%color([0.3,0.3,0.3])translate([0,0,-20])skeleton_ramps();

/////////////////////
// Left side skeleton:
// in order to avoid some incompatability, we need to minus possible assembly difficulties
/////////////////////
module skeletonSideL(){
    difference(){
	color([0.5,0.5,0.5])translate([-74,0,0])skeletonSide();
	    union(){
		translate([0,distance,distance])rampsTopFace();
		translate([0,distance,0])rampsBackFace();
		translate([0,-distance,distance])rampsLcdFace();
		translate([0,0,-distance])rampsBottomFace();
	    }
    }
}

/////////////////////
// Right side skeleton
/////////////////////
module skeletonSideR(){
    difference(){
        translate([74,0,0])mirror([1,0,0]) skeletonSide();
	rampsCaseWithAssemblyHoles();
        //union()
	//{
    	//    translate([0,distance,distance])rampsTopFace();
    	//    translate([0,distance,0])rampsBackFace();
    	//    translate([0,-distance,distance])rampsLcdFace();
    	//    translate([0,0,-distance])rampsBottomFace();
        //}
    }
}



//translate([-74,0,0])skeletonSide();
//skeletonSideL();
//skeletonSideR();

//color([0.5,0.1,0.1,0.2])
//rampsCaseWithAssemblyHoles();







	   

//%color("green")translate([0,-58,16])rotate([60,0,0])lcdPanel();

//// expose
distance=0;
translate([0,-distance,distance])rampsLcdFace();
translate([0,distance,distance])rampsTopFace();
translate([0,distance,0])rampsBackFace();
translate([0,0,-distance])rampsBottomFace();

// left side cover
module lsCover(){
    translate([-lcd_x/2-thick*1.5-distance,0,0])
    difference(){
	rampsCaseSide();
	// leave a slot for sc card, one side only
	translate([80,-58,16])rotate([60,0,0])lcdPanel();
	
    }
}


// right side cover
module rsCover(){
    translate([lcd_x/2+thick*1.5+distance,0,0])mirror([1,0,0]) rampsCaseSide();
}

//lsCover();
//rsCover();
