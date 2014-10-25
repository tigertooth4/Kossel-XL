//This is based on the Atom 3dp design

extrusion = 20;
err = 0.2;
channelWidth= 4;
channelWidthInside=8.5;
channelDeep = 6;

outRoundness = .5*extrusion;
innerRoundness = 0.2*extrusion;
endRoundness = 0.08* extrusion;

armLength = extrusion * 2.7;


//height = extrusion;

sqrt3 = 1.7321;

m25ScrewRadius = 1.25; 

m4ScrewRadius = 2.0; //for M4 bolt
m4ScrewHeadRadius = 4.0; 
m4NutRadius = 4.3;

m5NutRadius = 8/sqrt3+0.2;

m3ScrewRadius = 1.5; //for M3 bolt
m3ScrewHeadRadius = 3.0; 
m3NutRadius = 3.5; //










module bottomCover(height){
    // draw the basic shape

    difference(){
	hull(){
	    intersection(){
		minkowski() {
		    cylinder(r=extrusion*1.5, h=0.3*height,  center=true,$fn=6);
		    cylinder(r=outRoundness, h=0.3*height, center=true, $fn=20);
		}
		translate([0,-extrusion*1.8,0]) rotate([0,0,30]) cylinder(r=extrusion*2,h=0.3*height, center=true, $fn=6);
		translate([0,-1.2*extrusion,0]) cube([4*extrusion, 2*extrusion, 2*height],center=true);
	    }
	    translate([0,-extrusion, -height*.9]) cylinder(r=extrusion/3,h=0.5,center=true);//cube([extrusion+5, extrusion+5, 0.5],center=true);
	}
    
	// leave holes for m3 screws
	translate([0.9*extrusion, -1.4*extrusion,0]) cylinder(r=m3ScrewRadius, h=extrusion, center=true, $fn=20);
	translate([-0.9*extrusion, -1.4*extrusion,0]) cylinder(r=m3ScrewRadius, h=extrusion, center=true, $fn=20);
	translate([1.3*extrusion, -0.9*extrusion,0]) cylinder(r=m3ScrewRadius, h=extrusion, center=true, $fn=20);
	translate([-1.3*extrusion, -0.9*extrusion,0]) cylinder(r=m3ScrewRadius, h=extrusion, center=true, $fn=20);

	// Leave holes for m3 head

	translate([0.9*extrusion, -1.4*extrusion,-.3*extrusion]) cylinder(r=m3ScrewHeadRadius, h=extrusion*.3, center=true, $fn=20);
	translate([-0.9*extrusion, -1.4*extrusion,-.3*extrusion]) cylinder(r=m3ScrewHeadRadius, h=extrusion*.3, center=true, $fn=20);
	translate([1.3*extrusion, -0.9*extrusion,-.3*extrusion]) cylinder(r=m3ScrewHeadRadius, h=extrusion*.3, center=true, $fn=20);
	translate([-1.3*extrusion, -0.9*extrusion,-.3*extrusion]) cylinder(r=m3ScrewHeadRadius, h=extrusion*.3, center=true, $fn=20);

	// Leave space for wiring

	translate([0,-extrusion,0.15*extrusion])
	hull(){
	    for(i=[0:90:270])
	    rotate([0,0,i]) translate([extrusion*.4,extrusion*.4,-2])sphere(r=0.25*extrusion, center=true);

	    //translate([0, -extrusion*.5,0.17*extrusion]) scale([1,1.3,0.5])sphere(r=0.34*extrusion, center=true);
	    //	    translate([0.7*extrusion,-0.6*extrusion,channelDeep/2-1])cube([extrusion,channelWidth*2, channelDeep],center=true);
	    //	    translate([-0.7*extrusion,-0.6*extrusion,channelDeep/2-1])cube([extrusion,channelWidth*2, channelDeep],center=true);
	    
	}

	translate([0.75*extrusion,-0.8*extrusion,channelDeep/2-2]) rotate([0,0,45])
	cube([1.66*extrusion,channelWidth*3.5, channelDeep],center=true);
	
	translate([-0.75*extrusion,-0.8*extrusion,channelDeep/2-2]) rotate([0,0,-45])
	cube([1.66*extrusion,channelWidth*3.5, channelDeep],center=true);


//translate([0,0.3*extrusion,0.1*extrusion]) cube([0.5*extrusion,2*extrusion,0.2*extrusion],center=true);
	translate([0, extrusion, 0]) rotate([10,0,0])cube([0.5*extrusion, extrusion*1.5, 0.2*extrusion],center=true);

	
    }

}



module topCover(height){
    // draw the basic shape

    difference(){
	union(){
	    hull(){
		intersection(){
		    minkowski() {
			cylinder(r=extrusion*1.5, h=0.3*height,  center=true,$fn=6);
			cylinder(r=outRoundness, h=0.3*height, center=true, $fn=20);
		    }
		    translate([0,-extrusion*1.8,0]) rotate([0,0,30]) cylinder(r=extrusion*2,h=0.3*height, center=true, $fn=6);
		    translate([0,-1.2*extrusion,0]) cube([4*extrusion, 2*extrusion, 2*height],center=true);
		}
		translate([0,-extrusion, height*.6]) cylinder(r=extrusion*.6,h=0.5,center=true);
	    }
	    // two wings:
	    translate([1.7*extrusion,0.35*extrusion, 0 ])
	    rotate([0,0,60])cube([extrusion*2,extrusion,0.3*height],center=true);


	    translate([-1.7*extrusion,0.35*extrusion, 0 ])
	    rotate([0,0,-60])cube([extrusion*2,extrusion,0.3*height],center=true);

	}
    
	// leave holes for m3 screws
	translate([0.9*extrusion, -1.4*extrusion,0]) cylinder(r=m3ScrewRadius, h=extrusion, center=true, $fn=20);
	translate([-0.9*extrusion, -1.4*extrusion,0]) cylinder(r=m3ScrewRadius, h=extrusion, center=true, $fn=20);
	translate([1.3*extrusion, -0.9*extrusion,0]) cylinder(r=m3ScrewRadius, h=extrusion, center=true, $fn=20);
	translate([-1.3*extrusion, -0.9*extrusion,0]) cylinder(r=m3ScrewRadius, h=extrusion, center=true, $fn=20);

	// Leave holes for m3 head

	translate([0.9*extrusion, -1.4*extrusion,-.3*extrusion]) cylinder(r=m3ScrewHeadRadius, h=extrusion*.3, center=true, $fn=20);
	translate([-0.9*extrusion, -1.4*extrusion,-.3*extrusion]) cylinder(r=m3ScrewHeadRadius, h=extrusion*.3, center=true, $fn=20);
	translate([1.3*extrusion, -0.9*extrusion,-.3*extrusion]) cylinder(r=m3ScrewHeadRadius, h=extrusion*.3, center=true, $fn=20);
	translate([-1.3*extrusion, -0.9*extrusion,-.3*extrusion]) cylinder(r=m3ScrewHeadRadius, h=extrusion*.3, center=true, $fn=20);

	// Leave space for wiring

	translate([0,-extrusion,-0.1*extrusion])
	hull(){
	    for(i=[0:90:270])
	    rotate([0,0,i]) translate([extrusion*.4,extrusion*.4,-2])sphere(r=0.25*extrusion, center=true);

	    //translate([0, -extrusion*.5,0.17*extrusion]) scale([1,1.3,0.5])sphere(r=0.34*extrusion, center=true);
	    //	    translate([0.7*extrusion,-0.6*extrusion,channelDeep/2-1])cube([extrusion,channelWidth*2, channelDeep],center=true);
	    //	    translate([-0.7*extrusion,-0.6*extrusion,channelDeep/2-1])cube([extrusion,channelWidth*2, channelDeep],center=true);
	    
	}

	translate([0.75*extrusion,-0.8*extrusion,channelDeep/2-6]) rotate([0,0,45])
	cube([1.66*extrusion,channelWidth*3.5, channelDeep],center=true);
	
	translate([-0.75*extrusion,-0.8*extrusion,channelDeep/2-6]) rotate([0,0,-45])
	cube([1.66*extrusion,channelWidth*3.5, channelDeep],center=true);


	translate([0, extrusion, 0]) rotate([10,0,0])cube([0.5*extrusion, extrusion*1.5, 0.2*extrusion],center=true);

	
    }

}



/*
module topCover(height){
    // draw the basic shape
    intersection(){
	// to give a nicer cover
	translate([0,-extrusion,0])
	union(){
	    //translate([0,1,0])cylinder(r=0.9*extrusion, h=extrusion,center=true,$fn=30);
	    translate([0,-0.25*extrusion,0])cube([4*extrusion,2*extrusion,extrusion],center=true);
	}

	// real main shape
	difference(){
	    hull(){
		intersection(){
		    minkowski() {
			cylinder(r=extrusion*1.5, h=0.3*height,  center=true,$fn=6);
			cylinder(r=outRoundness, h=0.3*height, center=true, $fn=20);
		    }
		    translate([0,-extrusion*1.8,0]) rotate([0,0,30]) cylinder(r=extrusion*2,h=0.3*height, center=true, $fn=6);
		}
		translate([0,-extrusion, height*.6]) cylinder(r=extrusion*.6,h=0.5,center=true);//cube([extrusion+5, extrusion+5, 0.5],center=true);
		
	    }
	    // leave holes for m3 screws
	    translate([0.9*extrusion, -1.4*extrusion,0]) cylinder(r=m3ScrewRadius, h=extrusion, center=true, $fn=20);
	    translate([-0.9*extrusion, -1.4*extrusion,0]) cylinder(r=m3ScrewRadius, h=extrusion, center=true, $fn=20);
	    translate([1.3*extrusion, -0.9*extrusion,0]) cylinder(r=m3ScrewRadius, h=extrusion, center=true, $fn=20);
	    translate([-1.3*extrusion, -0.9*extrusion,0]) cylinder(r=m3ScrewRadius, h=extrusion, center=true, $fn=20);
	    
	    // Leave holes for m3 head
	    
	    translate([0.9*extrusion, -1.4*extrusion,.7*height]) cylinder(r=m3ScrewHeadRadius, h=extrusion*.3, center=true, $fn=20);
	    translate([-0.9*extrusion, -1.4*extrusion,.7*height]) cylinder(r=m3ScrewHeadRadius, h=extrusion*.3, center=true, $fn=20);
	    translate([1.3*extrusion, -0.9*extrusion,.7*height]) cylinder(r=m3ScrewHeadRadius, h=extrusion*.3, center=true, $fn=20);
	    translate([-1.3*extrusion, -0.9*extrusion,.7*height]) cylinder(r=m3ScrewHeadRadius, h=extrusion*.3, center=true, $fn=20);
	    
	    // Leave space for wiring
	    
	    translate([0,-extrusion,0])
	    for(i=[0:90:270])
	    rotate([0,0,i]) translate([extrusion*.45,extrusion*.45,-.7*height])sphere(r=0.27*extrusion, center=true);

	    translate([0, -extrusion*.5, -.5*height]) sphere(r=0.3*extrusion, center=true);
	    
	}
    }
}
*/

module frameShape(height){
    union(){
	// vertex side
	intersection(){
	    minkowski() {
		cylinder(r=extrusion*1.5, h=height, center=true,$fn=6);
		cylinder(r=outRoundness, h=height, center=true, $fn=20);
	    }
	    translate([0,-extrusion*1.8,0]) rotate([0,0,30]) cylinder(r=extrusion*2, h=height,center=true, $fn=6);
	}

	// V part
	translate([0,armLength-1.6*extrusion,0]) rotate([0,0,30])
	minkowski(){
	    cylinder(r=armLength-endRoundness*2, h=height-1, center=true, $fn=3);
	    cylinder(r=endRoundness, h=1, center=true, $fn=20);
	}

	// bump
//	bump(height);
    }
}

module extrusion(length){
    difference(){
	cube([extrusion+0.2,extrusion+0.2, length], center=true);
	for(i=[0:90:270]) 
	rotate([0,0,i]) translate([extrusion/2,0,0]) cube([channelWidth-err,channelWidth-err, length], center=true);
    }
    for (i=[0:90:270])
    rotate([0,0,i])translate([extrusion/2,extrusion/2,0])cylinder(r=1,h=length,center=true);

}

module frameGeneral(height){
//    union(){
	difference(){
	    frameShape(height);
	    
	    // vertical extrusion place
	    translate([0,-extrusion,0]) extrusion(height+100);
	    // dig hole for belt or gear
	    
	    translate([0, .5*extrusion,0])
	    minkowski(){
		intersection(){
		    rotate([0,0,30]) cylinder(r=1.1*extrusion, h=height*2,center=true, $fn=3);
		    cube([extrusion*2,  extrusion, height*2],center=true);
		}
		cylinder(r=innerRoundness, h=height, center=true, $fn=20);
		
	    }
	    
	    // make V shape branches
	    translate([0, 2.2*extrusion,0])
	    minkowski(){
		intersection(){
		    rotate([0,0,30]) cylinder(r=extrusion*2.8, h=height,center=true, $fn=3);
		    cube([extrusion*5,  extrusion, height],center=true);
		}
		cylinder(r=innerRoundness, h=height, center=true, $fn=20);
	    }
	}
	
   // }

}

//%rotate([0,0, -30]) translate([1.3*extrusion,2.7*extrusion,0]) rotate([90,0,0]) extrusion(100);//cube([extrusion, 100, extrusion]);
//%rotate([0,0, 30]) translate([-1.3*extrusion,2.7*extrusion,0]) rotate([90,0,0]) extrusion(100);


module frame_top(){
    difference(){
	union(){
	    frameGeneral(extrusion);
	    
	    // add bumps for bearing
	    intersection(){
		rotate([-90,0,0]) cylinder(r1 = extrusion*.8, r2=0.1*extrusion, h= 0.6*extrusion,center=true);
		cube([2*extrusion, 2* extrusion, extrusion],center=true);
	    }
	    translate([0,extrusion*1.15,0]) intersection(){
		rotate([90,0,0]) cylinder(r1 = extrusion*.6, r2=0.1*extrusion, h= 0.4*extrusion,center=true);
		cube([2*extrusion, 2* extrusion, extrusion],center=true);
	    }
	    
	    // add horizontal bumps strips
	    rotate([0,0,-30])translate([extrusion*.75,0,0])rotate([-90,0,0])cylinder(r=channelWidth/2+err, h=3.2*extrusion,$fn=20);
	    rotate([0,0,30])translate([-extrusion*.75,0,0])rotate([-90,0,0])cylinder(r=channelWidth/2+err, h=3.2*extrusion,$fn=20);
	}

	// leave m3 screw
	rotate([-90,0,0]) cylinder(r=m3ScrewRadius, h=3*extrusion, $fn=20);
	rotate([-90,0,0]) translate([0,0, 1.5*extrusion-3.5]) cylinder(r=m3ScrewHeadRadius, h=3.6,$fn=20);

	// Vertical extrusion mounting M4 screws
	translate([0, -extrusion,0])rotate([90,0,0]) cylinder(r=m4ScrewRadius, h= extrusion, $fn=20);
	translate([0, -1.6*extrusion,0])rotate([90,0,0]) cylinder(r=m4ScrewHeadRadius, h= 4, $fn=20);
	translate([0, -1.3*extrusion,0])rotate([90,0,0]) cylinder(r=m4NutRadius+0.5, h= 4, $fn=6);

	// Aluminum mount screws
	rotate([0,0,30]){
	    translate([-extrusion,0.7*extrusion,0])rotate([0,90,0]) cylinder(r=m4ScrewRadius, h = extrusion, $fn=20);
	    translate([-0.65*extrusion,0.7*extrusion,0])rotate([0,90,0]) cylinder(r=m4ScrewHeadRadius, h = 4, $fn=20);
	    translate([-1.02*extrusion,0.7*extrusion,0])rotate([0,90,0]) cylinder(r=m4NutRadius, h = 4, $fn=6);
	    
	    translate([-extrusion,2.8*extrusion,0])rotate([0,90,0]) cylinder(r=m4ScrewRadius, h = extrusion, $fn=20);
	    translate([-0.65*extrusion,2.8*extrusion,0])rotate([0,90,0]) cylinder(r=m4ScrewHeadRadius, h = 4, $fn=20);
	    translate([-1.02*extrusion,2.8*extrusion,0])rotate([0,90,0]) cylinder(r=m4NutRadius, h = 4, $fn=6);
	}


	rotate([0,0,-30]){
	    translate([extrusion,0.7*extrusion,0])rotate([0,-90,0]) cylinder(r=m4ScrewRadius, h = extrusion, $fn=20);
	    translate([0.65*extrusion,0.7*extrusion,0])rotate([0,-90,0]) cylinder(r=m4ScrewHeadRadius, h = 4, $fn=20);
	    translate([1.02*extrusion,0.7*extrusion,0])rotate([0,-90,0]) cylinder(r=m4NutRadius, h = 4, $fn=6);
	    
	    translate([extrusion,2.8*extrusion,0])rotate([0,-90,0]) cylinder(r=m4ScrewRadius, h = extrusion, $fn=20);
	    translate([0.65*extrusion,2.8*extrusion,0])rotate([0,-90,0]) cylinder(r=m4ScrewHeadRadius, h = 4, $fn=20);
	    translate([1.02*extrusion,2.8*extrusion,0])rotate([0,-90,0]) cylinder(r=m4NutRadius, h = 4, $fn=6);
	}

	// long m3 screw
	translate([0,-0.4*extrusion,0])rotate([13,0,0]){
	    cylinder(r=m3ScrewRadius, h= 2*extrusion, center=true,$fn=20);
	    translate([0,0,0.5*extrusion])cylinder(r=m3ScrewHeadRadius, h=5, center=true, $fn=20);
	    translate([0,0,-0.45*extrusion])cylinder(r=m3NutRadius+err, h=0.5*extrusion, center=true, $fn=6);
	}

	// slots for putting nuts

	rotate([0,0,-30])translate([1.3*extrusion,extrusion*.5,extrusion/2-channelDeep/2+1]){
	    translate([0,-extrusion/2,0])cylinder(r=channelWidthInside/2, h= channelDeep,center=true);
	    cube([channelWidthInside, extrusion,channelDeep],center=true);
	}

    	rotate([0,0,-30])translate([1.3*extrusion,extrusion*.5,-extrusion/2+channelDeep/2-1]){
	    translate([0,-extrusion/2,0])cylinder(r=channelWidthInside/2, h= channelDeep,center=true);
	    cube([channelWidthInside, extrusion,channelDeep],center=true);
	}

	rotate([0,0,30])translate([-1.3*extrusion,extrusion*.5,extrusion/2-channelDeep/2+1]){
	    translate([0,-extrusion/2,0])cylinder(r=channelWidthInside/2, h= channelDeep,center=true);
	    cube([channelWidthInside, extrusion,channelDeep],center=true);
	}

    	rotate([0,0,30])translate([-1.3*extrusion,extrusion*.5,-extrusion/2+channelDeep/2-1]){
	    translate([0,-extrusion/2,0])cylinder(r=channelWidthInside/2, h= channelDeep,center=true);
	    cube([channelWidthInside, extrusion,channelDeep],center=true);
	}

	//slots for wires
	translate([0.7*extrusion,-0.63*extrusion,0.5*extrusion-channelDeep/2+1])cube([extrusion,channelWidth, channelDeep],center=true);
	translate([-0.7*extrusion,-0.63*extrusion,0.5*extrusion-channelDeep/2+1])cube([extrusion,channelWidth, channelDeep],center=true);


	translate([0.7*extrusion,-1.07*extrusion,0.5*extrusion-channelDeep/2+1]) rotate([0,0,45]) cube([extrusion,channelWidth, channelDeep],center=true);
	translate([-0.7*extrusion,-1.07*extrusion,0.5*extrusion-channelDeep/2+1]) rotate([0,0,-45]) cube([extrusion,channelWidth, channelDeep],center=true);


	// screw holes for cover the top
	translate([0.9*extrusion, -1.4*extrusion,extrusion/2]) cylinder(r=m3ScrewRadius, h=1.8*extrusion, center=true, $fn=20);
	translate([-0.9*extrusion, -1.4*extrusion,extrusion/2]) cylinder(r=m3ScrewRadius, h=1.8*extrusion, center=true, $fn=20);


	translate([1.3*extrusion, -0.9*extrusion,extrusion/2]) cylinder(r=m3ScrewRadius, h=1.8*extrusion, center=true, $fn=20);
	translate([-1.3*extrusion, -0.9*extrusion,extrusion/2]) cylinder(r=m3ScrewRadius, h=1.8*extrusion, center=true, $fn=20);

    }
}



module frame_motor(){
        difference(){
	union(){
	    frameGeneral(extrusion*2.5);
	    
	    // add horizontal bumps strips
	    rotate([0,0,-30])translate([extrusion*.75,0,.75*extrusion])rotate([-90,0,0])cylinder(r=channelWidth/2+err, h=3.2*extrusion,$fn=20);
	    rotate([0,0,30])translate([-extrusion*.75,0,.75*extrusion])rotate([-90,0,0])cylinder(r=channelWidth/2+err, h=3.2*extrusion,$fn=20);

	    rotate([0,0,-30])translate([extrusion*.75,0,-.75*extrusion])rotate([-90,0,0])cylinder(r=channelWidth/2+err, h=3.2*extrusion,$fn=20);
	    rotate([0,0,30])translate([-extrusion*.75,0,-.75*extrusion])rotate([-90,0,0])cylinder(r=channelWidth/2+err, h=3.2*extrusion,$fn=20);
	}

	// Motor hole
	translate([0,extrusion,0])rotate([90,0,0]) cylinder(r=12, h=extrusion*2, center=true,$fn=20);
	for(i=[0:90:270])
	rotate([0,i,0])
	translate([31/2,extrusion*1.5,31/2])
	rotate([90,0,0]){
	    cylinder(r=m3ScrewRadius, h= extrusion, center=true, $fn=20);
	    translate([0,0,4])cylinder(r=m3ScrewHeadRadius,h=1.1*extrusion,  $fn=20);
	}
	// for easier assembling
	translate([31/2,extrusion,31/2]) rotate([0,-35,0])rotate([-15,0,0])rotate([90,0,0])cylinder(r=m3ScrewRadius+1, h =5*extrusion, $fn=20);
	translate([31/2,extrusion,-31/2]) rotate([0,35,0])rotate([15,0,0])rotate([90,0,0])cylinder(r=m3ScrewRadius+1, h =5*extrusion, $fn=20);
	translate([-31/2,extrusion,-31/2]) rotate([0,-35,0])rotate([15,0,0])rotate([90,0,0])cylinder(r=m3ScrewRadius+1, h =5*extrusion, $fn=20);
	translate([-31/2,extrusion,31/2]) rotate([0,35,0])rotate([-15,0,0])rotate([90,0,0])cylinder(r=m3ScrewRadius+1, h =5*extrusion, $fn=20);


	%translate([31/2,extrusion,31/2]) rotate([0,-35,0])rotate([-15,0,0])rotate([90,0,0])cylinder(r=m3ScrewRadius, h =5*extrusion, $fn=20);
	%translate([31/2,extrusion,-31/2]) rotate([0,35,0])rotate([15,0,0])rotate([90,0,0])cylinder(r=m3ScrewRadius, h =5*extrusion, $fn=20);
	%translate([-31/2,extrusion,-31/2]) rotate([0,-35,0])rotate([15,0,0])rotate([90,0,0])cylinder(r=m3ScrewRadius, h =5*extrusion, $fn=20);
	%translate([-31/2,extrusion,31/2]) rotate([0,35,0])rotate([-15,0,0])rotate([90,0,0])cylinder(r=m3ScrewRadius, h =5*extrusion, $fn=20);

	
	// Vertical extrusion mounting M4 screws
	translate([0, -extrusion,.75*extrusion])rotate([90,0,0]) cylinder(r=m4ScrewRadius, h= extrusion, $fn=20);
	translate([0, -1.6*extrusion,.75*extrusion])rotate([90,0,0]) cylinder(r=m4ScrewHeadRadius, h= 4, $fn=20);
	translate([0, -1.3*extrusion,.75*extrusion])rotate([90,0,0]) cylinder(r=m4NutRadius+0.5, h= 4, $fn=6);


	translate([0, -extrusion,-.75*extrusion])rotate([90,0,0]) cylinder(r=m4ScrewRadius, h= extrusion, $fn=20);
	translate([0, -1.6*extrusion,-.75*extrusion])rotate([90,0,0]) cylinder(r=m4ScrewHeadRadius, h= 4, $fn=20);
	translate([0, -1.3*extrusion,-.75*extrusion])rotate([90,0,0]) cylinder(r=m4NutRadius+0.5, h= 4, $fn=6);

	
	// Aluminum mounting screws
	rotate([0,0,30]){
	    translate([-extrusion,0.7*extrusion,.75*extrusion])rotate([0,90,0]) cylinder(r=m4ScrewRadius, h = extrusion, $fn=20);
	    translate([-0.65*extrusion,0.7*extrusion,.75*extrusion])rotate([0,90,0]) cylinder(r=m4ScrewHeadRadius, h = 4, $fn=20);
	    translate([-1.02*extrusion,0.7*extrusion,.75*extrusion])rotate([0,90,0]) cylinder(r=m4NutRadius, h = 4, $fn=6);
	    
	    translate([-extrusion,2.8*extrusion,.75*extrusion])rotate([0,90,0]) cylinder(r=m4ScrewRadius, h = extrusion, $fn=20);
	    translate([-0.65*extrusion,2.8*extrusion,.75*extrusion])rotate([0,90,0]) cylinder(r=m4ScrewHeadRadius, h = 4, $fn=20);
	    translate([-1.02*extrusion,2.8*extrusion,.75*extrusion])rotate([0,90,0]) cylinder(r=m4NutRadius, h = 4, $fn=6);
	}

	rotate([0,0,30]){
	    translate([-extrusion,0.7*extrusion,-.75*extrusion])rotate([0,90,0]) cylinder(r=m4ScrewRadius, h = extrusion, $fn=20);
	    translate([-0.65*extrusion,0.7*extrusion,-.75*extrusion])rotate([0,90,0]) cylinder(r=m4ScrewHeadRadius, h = 4, $fn=20);
	    translate([-1.02*extrusion,0.7*extrusion,-.75*extrusion])rotate([0,90,0]) cylinder(r=m4NutRadius, h = 4, $fn=6);
	    
	    translate([-extrusion,2.8*extrusion,-.75*extrusion])rotate([0,90,0]) cylinder(r=m4ScrewRadius, h = extrusion, $fn=20);
	    translate([-0.65*extrusion,2.8*extrusion,-.75*extrusion])rotate([0,90,0]) cylinder(r=m4ScrewHeadRadius, h = 4, $fn=20);
	    translate([-1.02*extrusion,2.8*extrusion,-.75*extrusion])rotate([0,90,0]) cylinder(r=m4NutRadius, h = 4, $fn=6);
	}

	
	rotate([0,0,-30]){
	    translate([extrusion,0.7*extrusion,.75*extrusion])rotate([0,-90,0]) cylinder(r=m4ScrewRadius, h = extrusion, $fn=20);
	    translate([0.65*extrusion,0.7*extrusion,.75*extrusion])rotate([0,-90,0]) cylinder(r=m4ScrewHeadRadius, h = 4, $fn=20);
	    translate([1.02*extrusion,0.7*extrusion,.75*extrusion])rotate([0,-90,0]) cylinder(r=m4NutRadius, h = 4, $fn=6);
	    
	    translate([extrusion,2.8*extrusion,.75*extrusion])rotate([0,-90,0]) cylinder(r=m4ScrewRadius, h = extrusion, $fn=20);
	    translate([0.65*extrusion,2.8*extrusion,.75*extrusion])rotate([0,-90,0]) cylinder(r=m4ScrewHeadRadius, h = 4, $fn=20);
	    translate([1.02*extrusion,2.8*extrusion,.75*extrusion])rotate([0,-90,0]) cylinder(r=m4NutRadius, h = 4, $fn=6);
	}


	rotate([0,0,-30]){
	    translate([extrusion,0.7*extrusion,-.75*extrusion])rotate([0,-90,0]) cylinder(r=m4ScrewRadius, h = extrusion, $fn=20);
	    translate([0.65*extrusion,0.7*extrusion,-.75*extrusion])rotate([0,-90,0]) cylinder(r=m4ScrewHeadRadius, h = 4, $fn=20);
	    translate([1.02*extrusion,0.7*extrusion,-.75*extrusion])rotate([0,-90,0]) cylinder(r=m4NutRadius, h = 4, $fn=6);
	    
	    translate([extrusion,2.8*extrusion,-.75*extrusion])rotate([0,-90,0]) cylinder(r=m4ScrewRadius, h = extrusion, $fn=20);
	    translate([0.65*extrusion,2.8*extrusion,-.75*extrusion])rotate([0,-90,0]) cylinder(r=m4ScrewHeadRadius, h = 4, $fn=20);
	    translate([1.02*extrusion,2.8*extrusion,-.75*extrusion])rotate([0,-90,0]) cylinder(r=m4NutRadius, h = 4, $fn=6);
	}

	
	// sluts for putting nuts

	rotate([0,0,-30])translate([1.3*extrusion,extrusion*.5,extrusion*1.25-channelDeep/2+1]){
	    translate([0,-extrusion/2,0])cylinder(r=channelWidthInside/2, h= channelDeep,center=true);
	    cube([channelWidthInside, extrusion,channelDeep],center=true);
	}

    	rotate([0,0,-30])translate([1.3*extrusion,extrusion*.5,-extrusion*1.25+channelDeep/2-1]){
	    translate([0,-extrusion/2,0])cylinder(r=channelWidthInside/2, h= channelDeep,center=true);
	    cube([channelWidthInside, extrusion,channelDeep],center=true);
	}

	rotate([0,0,30])translate([-1.3*extrusion,extrusion*.5,extrusion*1.25-channelDeep/2+1]){
	    translate([0,-extrusion/2,0])cylinder(r=channelWidthInside/2, h= channelDeep,center=true);
	    cube([channelWidthInside, extrusion,channelDeep],center=true);
	}

    	rotate([0,0,30])translate([-1.3*extrusion,extrusion*.5,-extrusion*1.25+channelDeep/2-1]){
	    translate([0,-extrusion/2,0])cylinder(r=channelWidthInside/2, h= channelDeep,center=true);
	    cube([channelWidthInside, extrusion,channelDeep],center=true);
	}

	// screw holes for cover the bottom
	translate([0.9*extrusion, -1.4*extrusion,-extrusion*1.25]) cylinder(r=m3ScrewRadius, h=2*extrusion, center=true, $fn=20);
	translate([-0.9*extrusion, -1.4*extrusion,-extrusion*1.25]) cylinder(r=m3ScrewRadius, h=2*extrusion, center=true, $fn=20);


	translate([1.3*extrusion, -0.9*extrusion,-extrusion*1.25]) cylinder(r=m3ScrewRadius, h=2*extrusion, center=true, $fn=20);
	translate([-1.3*extrusion, -0.9*extrusion,-extrusion*1.25]) cylinder(r=m3ScrewRadius, h=2*extrusion, center=true, $fn=20);

	//sl0ts for wires
	translate([0.7*extrusion,-0.63*extrusion,-1.25*extrusion+channelDeep/2-1])cube([extrusion,channelWidth, channelDeep],center=true);
	translate([-0.7*extrusion,-0.63*extrusion,-1.25*extrusion+channelDeep/2-1])cube([extrusion,channelWidth, channelDeep],center=true);


	translate([0.7*extrusion,-1.07*extrusion,-1.25*extrusion+channelDeep/2-1]) rotate([0,0,45])
	cube([extrusion,channelWidth, channelDeep],center=true);
	
	translate([-0.7*extrusion,-1.07*extrusion,-1.25*extrusion+channelDeep/2-1]) rotate([0,0,-45])
	cube([extrusion,channelWidth, channelDeep],center=true);

	translate([0,0,-1.2*extrusion]) rotate([5,0,0])cube([0.5*extrusion,2*extrusion,0.2*extrusion],center=true);
	translate([0, extrusion, -1.1*extrusion]) rotate([10,0,0])cube([0.5*extrusion, extrusion*1.5, 0.2*extrusion],center=true);

	// side holes for wiring
	translate([-1.1*extrusion,extrusion,0]) cube([0.2*extrusion,2*extrusion,0.5*extrusion],center=true);
	translate([1.1*extrusion,extrusion,0]) cube([0.2*extrusion,2*extrusion,0.5*extrusion],center=true);

	translate([-1.7*extrusion,extrusion,0]) cube([0.2*extrusion,2*extrusion,0.5*extrusion],center=true);
	translate([1.7*extrusion,extrusion,0]) cube([0.2*extrusion,2*extrusion,0.5*extrusion],center=true);

	translate([-1.5*extrusion,1.7*extrusion,0.75*extrusion])rotate([0,0,-60]) cube([0.35*extrusion,2*extrusion,0.2*extrusion],center=true);
	translate([-1.5*extrusion,1.7*extrusion,-0.75*extrusion])rotate([0,0,-60]) cube([0.35*extrusion,2*extrusion,0.2*extrusion],center=true);

	translate([1.5*extrusion,1.7*extrusion,0.75*extrusion])rotate([0,0,60]) cube([0.35*extrusion,2*extrusion,0.2*extrusion],center=true);
	translate([1.5*extrusion,1.7*extrusion,-0.75*extrusion])rotate([0,0,60]) cube([0.35*extrusion,2*extrusion,0.2*extrusion],center=true);


	
	// Kossel XL logo
	translate([1.56*extrusion, -1.1*extrusion, 0])
	rotate([90, -90, 60])
	scale([0.09*extrusion/20, 0.15*extrusion/20, 0.8*extrusion/20]) import("logotype.stl");

	//structural holes
	rotate([0,0,-30])translate([1.3*extrusion,0,0.5*extrusion]){
	    cube([channelWidthInside, extrusion,0.5*extrusion],center=true);
	}

	rotate([0,0,-30])translate([1.3*extrusion,0,-0.5*extrusion]){
	    cube([channelWidthInside, extrusion,0.5*extrusion],center=true);
	}
	

	rotate([0,0,30])translate([-1.3*extrusion,0,0.5*extrusion]){
	    cube([channelWidthInside, extrusion,0.5*extrusion],center=true);
	}

	rotate([0,0,30])translate([-1.3*extrusion,0,-0.5*extrusion]){
	    cube([channelWidthInside, extrusion,0.5*extrusion],center=true);
	}


    }
}

//color("red") frame_motor();
//color("grey")translate([0,0,-2.5*extrusion])bottomCover(extrusion);

color("red")frame_top();
color("grey")translate([0,0,2*extrusion])topCover(extrusion);




