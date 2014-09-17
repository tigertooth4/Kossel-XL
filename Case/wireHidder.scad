thick=2.25;
err=0.3;
module wireHidder(){
    union(){
	difference(){
	    minkowski(){
		cube([thick*3,20,20],center=true);
		rotate([0,90,0])cylinder(r=thick, h=1, center=true, $fn=20);
	    }
	    cube([thick*3.5,20+err,20+err],center=true);
	    translate([0,0,-17])cube([thick*5, 30, 30], center=true);
	}

	translate([0,-10,0])rotate([0,90,0])cylinder(r=2,h=thick*3+1,center=true,$fn=4);
	translate([0,10,0])rotate([0,90,0])cylinder(r=2,h=thick*3+1,center=true,$fn=4);
	translate([0,0,10.5])rotate([0,90,0])cylinder(r=1.5,h=thick*3+1,center=true,$fn=4);
    }
    
}

wireHidder();