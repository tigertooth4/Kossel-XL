ScrewRadius = 1.27;
radius = 4.5;
nut = 2.7;
screwHeadRadius=2.5;
ht = 10;
deep=7;


module tensioner(){
    union(){
	difference(){
	    hull(){
		cylinder(r=radius, h= ht, center=true, $fn=20);
		translate([0,radius+1,0])cube([radius*2+2,deep,ht],center=true);
	    }
	    
	    translate([0,radius+2,0])cube([1,deep,ht+1],center=true);

	    translate([0,-1,0])cylinder(r=screwRadius, h =ht+1,center=true, $fn=10);

	    for(z=[-ht/2-1:2:ht/2]) translate([-2,radius/2+1,z])cube([2,deep,1]);
		
	    translate([0,9,0])cylinder(r=screwRadius+1, h =ht+1,center=true, $fn=4);
	}


	
    }
}

module tensionerA(){
    difference(){
	mirror([1,0,0])tensioner();
	translate([0,-1,ht*.3])cylinder(r=nut,h=ht,center=true,$fn=6);
//	translate([3,radius,-ht/2])cube([radius+1,deep*2,2],center=true);
    }

}



module tensionerB(){
    difference(){
	mirror([1,0,0])tensioner();
	translate([0,-1,-ht*.3])cylinder(r=screwHeadRadius,h=ht,center=true,$fn=20);
//	translate([3,radius,-ht/2])cube([radius+1,deep*2,2],center=true);
    }

}

tensionerA();

translate([0,0,-ht*2])tensionerB();