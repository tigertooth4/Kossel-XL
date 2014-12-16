CarbonOD = 6.0+0.20;
MagneticOD_big = 12.0 +0.2;
MagneticThick_big = 4.0+0.3;
length1_big = 8.0;
length2_big = 17.0;
wallThickness = 2;
err = 0.1;
$fn = 50;
m4Radius = 2.0;


MagneticOD_sml = 10 +0.2;
MagneticThick_sml = 2.76+1.5;
length1_sml = 8.0; //was 10.0
length2_sml = 17.0; // was 17.0


module connector_big(){
    difference(){
	hull(){
	    cylinder(h=length1_big, r1= MagneticOD_big/2 + wallThickness/1.3, r2 =  MagneticOD_big/2 + wallThickness/2);
	    translate([0,0,-length2_big]) cylinder(h=1, r= CarbonOD/2 + wallThickness/1.7);
	}
	translate([0,0,length1_big-MagneticThick_big]) cylinder(h=MagneticThick_big+err, r = MagneticOD_big/2 + err);
	translate([0,0,-length2_big-err])cylinder(h=length2_big + length1_big, r= m4Radius + err);
	translate([0,0, -length2_big-err-8]) cylinder(h=length2_big + length1_big, r=CarbonOD/2 + err);
    }
}


module connector_sml(){
    difference(){
	hull(){
	    cylinder(h=length1_sml, r1= MagneticOD_sml/2 + wallThickness, r2 =  MagneticOD_sml/2 + wallThickness/1.4); //remove r2 if you want to change to old style~
	    translate([0,0,-length2_sml]) cylinder(h=0.1, r= CarbonOD/2 + wallThickness/1.7);
	}
	translate([0,0,length1_sml-MagneticThick_sml]) cylinder(h=MagneticThick_sml+err, r = MagneticOD_sml/2 + err);
	translate([0,0,-length2_sml-err])cylinder(h=length2_big + length1_big, r= m4Radius-err);
	translate([0,0, -length2_sml-err-8]) cylinder(h=length2_sml + length1_sml, r=CarbonOD/2 + err*2);
    }
}

//translate([0,20,0 ])connector_big();

connector_sml();