union(){
difference(){
cube([106+2*2,17,18+1.5],center=true);
translate([0,0,-1.8])cube([105,18,18],center=true);
translate([0,-3.5,0])rotate([0,90,0])cylinder(r=1.5,h=300,center=true,$fn=20);
translate([0,3.5,0])rotate([0,90,0])cylinder(r=1.5,h=300,center=true,$fn=20);
}
translate([52,0,6.5])rotate([90,0,0])cylinder(r=3,h=17, center=true,$fn=5);
translate([-52,0,6.5])rotate([90,36,0])cylinder(r=3,h=17, center=true,$fn=5);
}