use <wheel.scad>

extrudeWidth = 20.0 ;
wheelCenterExtrusionOffset = 9.0 ;   // Distance from wheel center to side of extrusion
wheelCentersDistance = (wheelCenterExtrusionOffset * 2 + extrudeWidth)/cos(30);
wheelOriginDistance = wheelCentersDistance/2/cos(30);

centerCircleRadius = 5.0;
wheelRadius = 9.5;

screwRadius = 2.0; //for M4 bolt
cylinderMaxRadius = 6; // enough
cylinderMinRadius = 4;
cylinderHeight = 7.0;

module Yshape(){ //(1/2, 2)
	polygon([[1., 0.], [1.01331, 0.0886535], [1.05315, 0.185699], [1.11961, 
  0.299998], [1.21492, 0.442196], [1.35154, 0.630233], [1.73205, 
  1.], [2.05504, 1.43896], [2.07376, 1.74009], [2.00882, 
  2.00882], [1.88376, 2.24497], [1.71087, 2.44338], [1.5, 
  2.59808], [1.26059, 2.70335], [1.00233, 2.75387], [0.735278, 
  2.7441], [0.470084, 2.66598], [0.218651, 2.4992], [0., 
  2.], [-0.129972, 1.48558], [-0.224509, 1.27325], [-0.299998, 
  1.11961], [-0.365755, 1.0049], [-0.429881, 0.921882], [-0.5, 
  0.866025], [-0.583433, 0.833229], [-0.687394, 0.819204], [-0.81961, 
  0.81961], [-0.990414, 0.831056], [-1.22157, 0.85535], [-1.73205, 
  1.], [-2.27369, 1.06024], [-2.54385, 0.925885], [-2.7441, 
  0.735278], [-2.88608, 0.508894], [-2.97146, 0.259969], [-3., 
  0.], [-2.97146, -0.259969], [-2.88608, -0.508894], [-2.7441, 
-0.735278], [-2.54385, -0.925885], [-2.27369, -1.06024], [-1.73205, 
-1.], [-1.22157, -0.85535], [-0.990414, -0.831056], [-0.81961, 
-0.81961], [-0.687394, -0.819204], [-0.583433, -0.833229], [-0.5, 
-0.866025], [-0.429881, -0.921882], [-0.365755, -1.0049], [-0.299998, 
-1.11961], [-0.224509, -1.27325], [-0.129972, -1.48558], [0., -2.], 
[0.218651, -2.4992], [0.470084, -2.66598], [0.735278, -2.7441], 
[1.00233, -2.75387], [1.26059, -2.70335], [1.5, -2.59808], [1.71087, 
-2.44338], [1.88376, -2.24497], [2.00882, -2.00882], [2.07376, 
-1.74009], [2.05504, -1.43896], [1.73205, -1.], [1.35154, -0.630233], 
[1.21492, -0.442196], [1.11961, -0.299998], [1.05315, -0.185699], 
[1.01331, -0.0886535], [1., 0.]]);
}


module wheelHolder(){
	union(){
		translate([0,0,cylinderHeight]) cylinder(h=cylinderHeight+2, r=cylinderMaxRadius, center = true); 
		difference(){
			cylinder(h=cylinderHeight,r1=cylinderMinRadius,r2=cylinderMaxRadius, center=true);
			cylinder(h=cylinderHeight,r=screwRadius,center=true);
		}
	}
}


sf = (wheelOriginDistance  )/3;

echo(sf);

$fn=60;


intersection(){

	union() {
		//hull() 
			scale([sf,sf,1]) linear_extrude(height = 12, center = true, convexity = 10, scale =1)  Yshape();
		for (i=[0:2]){
			translate([wheelOriginDistance*cos(60+120*i),wheelOriginDistance*sin(60+120*i),-cylinderHeight-2]) 
				wheelHolder();
		}
	}

	translate([0,0,-50]) sphere (r=58,center=true);
}




% translate([-wheelOriginDistance+wheelCenterExtrusionOffset,-40,-26]) cube([20,80,20]);
