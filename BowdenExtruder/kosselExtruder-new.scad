// Based on "Makergear Filament drive goes Bowden" by Luke321
// http://www.thingiverse.com/thing:63674

include <configuration.scad>;

filament = 1.75;
pulleyRadius = 6;
filament_offset = pulleyRadius+filament/2;
filament_z = 7;

bearRadius = 8;
bearOffset = bearRadius + pulleyRadius + filament;
screwDistance = 20; // or 21.5 

module extruderNew(){

    difference() {
	//main shape
	union() {
	    hull() {
		// main cylinder
		cylinder(h=20, r=17.5);
		
		// bearing mount
		translate([bearOffset,0,0]) cylinder (h=20, r=8);
		
		// Pivot
		translate([10.75,12,0])cylinder(h=20, r=4.5, $fn=40);
		
	    }
            
            translate([-screwDistance/2 , screwDistance/2 , 0])cylinder(h=20, r=3);
            translate([-screwDistance/2 ,-screwDistance/2 , 0])cylinder(h=20, r=3);

	    //clamp
	    translate([filament_offset,-5,filament_z])
            intersection(){
                //translate([0,-4,0])sphere(r=20, $fn=40);
                //rotate([90,0,0])cylinder(r1=20,r2=14,h=20, $fn=40);
                translate([-5,-15,-filament_z])cube([16,20,20]);
            }
	    
	    
	    //pushfit/pneufit mount
            translate([filament_offset, 3, filament_z])
            
            intersection(){
                rotate([-90,0,0])cylinder(r1=12,r2=8, h=20,$fn=40);
                translate([0,10,0])sphere(r=12,$fn=40);
            }
 	    
	    

	}
        
       // clean up unused part
        translate([-40,-40,-20])cube([80,80,20]);


    	//gearhead indentation
	translate([0,0,17])cylinder (h=3.35, r=11.25);
	
	//pulley hub indentation
	translate([0,0,12])cylinder (h=5.6, r=7);
	translate([0,0,-1])cylinder (h=20, r=7);
	
	//bearing screws
	translate([bearOffset,0,-1]) cylinder (h=22, r=2.6, $fn=12);
	#translate([bearOffset,0,12])  rotate([0,0,30])cylinder (h=8.01, r=4.7, $fn=6);

	//bearing 
	difference() {
	    union() {
		translate([bearOffset,0,filament_z]) #cylinder (h=6, r=bearRadius, center=true);
		translate([bearOffset,0,filament_z]) cube([20, 18.5, 5.25],center=true);
		//opening between bearing and pulley
		//translate([5,0,filament_z+1]) cube([10, 5.25, 8],center=true);
	    }
	    //removable supports
            translate([18,21,10])rotate([90,0,0])
	    for (z = [15:3:27]) {
		translate([0, 0, z]) # cube([20, 20, 0.5], center=true);
	    }
	}
        
        //mounting screws

        translate([-screwDistance/2, screwDistance/2,-1])cylinder(r=1.6, h=22, $fn=20);
        translate([-screwDistance/2, -screwDistance/2,-1])cylinder(r=1.6, h=22, $fn=20);
        
        // filament pass
        translate([filament_offset,50,filament_z])rotate([90,0,0])#cylinder(r=1.0, h= 120, $fn=40);
	
        // gap
        translate([10.75,12,-1])cylinder(r=2, h=22, $fn=20);
        difference(){
            union(){
                translate([bearOffset,0,-1])
                difference(){   
                    cylinder(r=11, h=22, $fn= 30);
                    cylinder(r=7, h=22, $fn= 30);
                }
                translate([10.75,9,10])cube([2,5,22],center=true);
                translate([10.75,-17,10])cube([4,20,22],center=true);
            }
            translate([11.75,-20,-1])cube([20,40,22]);
        }       
        
        // tightening screw
        translate([-1,-16,filament_z + 5])rotate([0,90,0])cylinder(r=1.6, h=20, $fn=20);
        translate([-5,-16,filament_z + 5])rotate([0,90,0])cylinder(r=3.4, h=10, $fn=6);
        
        // pushfit nut mount
        translate([filament_offset,24,filament_z])rotate([90,0,0])cylinder(r=4.65, h=6, $fn=6);
        
        // inner smooth
        translate([filament_offset,-4, filament_z])rotate([90,0,0])#cylinder(r1=4,r2=1, h=7,$fn=20);
        translate([filament_offset,2, filament_z])rotate([-90,0,0])#cylinder(r1=4,r2=1, h=7,$fn=20);
        translate([filament_offset,-22, filament_z])rotate([-90,0,0])cylinder(r1=4,r2=1, h=3,$fn=20);
        translate([filament_offset,20, filament_z])rotate([90,0,0])cylinder(r1=4,r2=1, h=4,$fn=20);
        
    }

    
    
}

extruderNew();