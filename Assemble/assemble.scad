use <../Frame/frame.scad>
use <../Carriage/Y-carriage.scad>
use <../Case/RampsCase.scad>
use <../Effector/effector.scad>
use <../PowerBox/powerBox.scad>
use <../Rods/rod_connector.scad>
use <../Fans/fans.scad>
use <../HeatbedSupport/heatbedSupport.scad>
use <../PowerBrickMount/powerBrickMount.scad>

expose = 100;
l = 330 +expose;
r = l/2+110 + expose;
h = 700;
extrusion = 20;

translate([0,0,-h/2]){

// draw the motor frame
for(i=[0,120,240])
rotate([0,0,i])
translate([-r*cos(30),-r*sin(30),0])rotate([0,0, -60])
translate([0,80,-expose])
{
    color("red") import("../Frame/frameMotor.stl");
    color("black")translate([0,0,22-expose/2]) import("../Frame/bottomCover.stl");
}

// draw the top frame

for(i=[0,120,240])
rotate([0,0,i])
translate([-r*cos(30),-r*sin(30),0])rotate([0,0, -60])
translate([0,80,h-10+expose])
{
    color("red")import("../Frame/frameTop.stl");
    color("red")translate([0,0,-1+expose]) import("../Frame/topCover.stl");
}

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
    color([0.3,0.3,0.3])translate([6,0,expose/2])import("../Carriage/wing.stl");
    color([0.3,0.3,0.3])import("../Carriage/Ycarriage.stl");

    color("white")translate([5,0,0])for(i=[0,120,240])rotate([0,0,i])translate([-25,0,-16 + expose/3])
    import("../Carriage/wheel.stl");
}

// draw the belts
color("grey")
for(i=[0,120,240])
rotate([0,0,i+30])
translate([-r+90, 0,h/2-10]) {
    for(y=[-4,4])
    translate([0,y,0])
    cube([6,1.5,h],center=true);
}

// draw the cases
translate([0,-l*cos(60)+55,h-30]){
    color("black"){
	translate([0,-expose/2,expose/2])import("../Case/skeletonSideR.stl");
	translate([0,-expose/2,expose/2])import("../Case/skeletonSideL.stl");
	for(x=[-40,40])
	translate([x,45-expose/2,expose/2-30])rotate([-90,0,0])import("../Case/rampsFan.stl");
    }
    
    color("red") {
	translate([0,-expose,expose])import("../Case/rampsLcdFace.stl");
	translate([0,expose,expose])import("../Case/rampsTopFace.stl");
    }

    color("grey"){
	import("../Case/rampsLeftFace.stl");
	import("../Case/rampsRightFace.stl");
	
	translate([0,expose,0])import("../Case/rampsBackFace.stl");
	translate([0,0,-expose])import("../Case/rampsBottomFace.stl");


    }
}


// draw the effector
translate([0,0, h/3])
rotate([0,0,30])
{
    color([0.3,0.3,0.3])rotate([0,0,-120]) import("../Effector/base.stl");
    color([0.3,0.3,0.3])rotate([0,0,-120]) translate([0,0,  expose/2]) import("../Effector/lid.stl");
    rotate([0,0,60]){
	//color("silver") translate([0,0,expose/2])import("../Fans/hotend.stl"); color("silver")
	color("silver")translate([0,0,expose/2+2]) rotate([0,0,-90])import("../E3D_v4_Hot_end_Model/E3Dhotend.stl");
	//color("black") translate([0,0,expose/2])rotate([0,0,-110])import("../Fans/hotendFan.stl");
	color("black") translate([0,0,expose/2])rotate([0,0,-120])translate([7,0,0])import("../Fans/printFan.stl");
    }
}

//draw the rod

translate([0,0,h/3+30+expose/2])
for(i=[0,120,240])
rotate([0,34,-30+i])
for(y=[-23,23])
translate([38,y+expose/2,0])
{
    color([0.2,0.2,0.2])
    {
	translate([0,0,255+expose/4])import("../Rods/rod_connector.stl");
	translate([0,0,expose/4])cylinder(r=2,h=260);
	translate([0,0,5])rotate([180,0,0])import("../Rods/rod_connector.stl");
    }
    translate([0,0,262]) color("silver") sphere(r=4, $fn=30, center=true);
    translate([0,0,-2])color("silver") sphere(r=4,$fn=30,center=true);

}

// draw the power box
color("black")translate([l*cos(60)-100,l*sin(60)-90,0])
rotate([0,0,120])
{
    import("../PowerBox/powerBoxRight.stl");
    import("../PowerBox/powerBoxLeft.stl");
}

// draw the heatbed support
translate([0,0,30+expose/3]){
    color("grey") translate([0,0,-5])rotate([0,0,30])import("../HeatbedSupport/centerSupport.stl");
    color("blue") for(i=[0,120,240])rotate([0,0,60+i])translate([0,-130-expose/3,0])
    import("../HeatbedSupport/hbsupport.stl");
}


// draw the plate
color([0.65,0.55,0]) translate([0,0,35+expose/3])
cylinder(r=114.3 , h=10, $fn=60);
color([0.98,0.98,0.98]) translate([0,0, 50+expose/2])
union(){
    cylinder(r=130, h =3, $fn=60);
    for(i=[0,120,240]) rotate([0,0,-30+i])
    translate([125,0,0])minkowski(){
	cube([13,100,2],center=true);
	cylinder(r=1,h=1,center=true,$fn=20);}
}

// draw the power brick and mounts
//color("silver") cube([113,215,45],center=true);
//color("black") {
//translate([-113/2+32,215/2-32,-30-expose/2])rotate([0,0,-30])mount(68);
//translate([-113/2+32,-215/2+32,-30-expose/2]) rotate([0,0,90]) mount(45);

//translate([113/2-32,215/2-32,-30-expose/2])rotate([0,0,-150])mount(68);
//translate([113/2-32,-215/2+32,-30-expose/2]) rotate([0,0,90]) mount(45);

//}
}

