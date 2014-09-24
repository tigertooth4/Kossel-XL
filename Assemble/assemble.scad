use <../Frame/frame.scad>
use <../Carriage/Y-carriage.scad>
use <../Case/RampsCase.scad>
use <../Effector/effector.scad>
use <../PowerBox/powerBox.scad>

expose = 0;
l = 330 +expose;
r = l/2+110 + expose;
h = 700 + expose;
extrusion = 20;

translate([0,0,-h/2]){

// draw the motor frame
color("red")
for(i=[0,120,240])
rotate([0,0,i])
translate([-r*cos(30),-r*sin(30),0])rotate([0,0, -60])
translate([0,80,0])
frame_motor();

// draw the top frame
color("red")
for(i=[0,120,240])
rotate([0,0,i])
translate([-r*cos(30),-r*sin(30),0])rotate([0,0, -60])
translate([0,80,h-10])
frame_top();

// draw the bottom aluminum
color("silver")
for(i=[0,120,240])
rotate([0,0,i])
for(z=[extrusion/2+5,-extrusion/2-5])
translate([0,-(l/2+80)*cos(60),z])rotate([0,90,0])extrusion(l);

// draw the top aluminum
color("silver")
for(i=[0,120,240])
rotate([0,0,i])
translate([0,-(l/2+80)*cos(60),h-10])rotate([0,90,0])extrusion(l);

// draw the vertical aluminum
color("silver")
for(i=[0,120,240])
rotate([0,0,i+30])
translate([-r+60, 0,h/2-10]) extrusion(h+20);

// draw the y-carriage
for(i=[0,120,240])
rotate([0,0,i])
translate([0,r-75,h/3*2])rotate([90,0,0]){
    wingWithScrewHoles(9);
    YCarriageWithScrewHoles(9);
}

// draw the cases
translate([0,-l*cos(60)+55,h-30]){
    color("red") {rampsLcdFace();
     rampsTopFace();}

    color("grey"){
	lsCover();
	rsCover();
	rampsBottomFace();
	rampsBackFace();
    }
}


// draw the effector
translate([0,0, h/2])
color([0.3,0.3,0.3])
rotate([0,0,30])
{
    baseShape();
    translate([0,0, 8]) lid();
}

// draw the power box
color("blue")translate([l*cos(60)-50,-l*cos(60),0]){
powerBoxRight();
powerBoxLeft();}
}

