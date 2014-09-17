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

module Yshape(){ //(1/2, 1.5)
	polygon([[0.5, 0.], [0.515217, 0.0450756], [0.560745, 0.0988744], [0.636645, 
  0.170589], [0.745076, 0.271185], [0.898384, 0.418923], [1.29904, 
  0.75], [1.64547, 1.15217], [1.69074, 1.4187], [1.65526, 
  1.65526], [1.56236, 1.86195], [1.42408, 2.0338], [1.25, 
  2.16506], [1.04928, 2.25019], [0.831316, 2.28402], [0.605869, 
  2.26113], [0.38326, 2.17358], [0.175073, 2.0011], [0., 
  1.5], [-0.0863938, 0.987485], [-0.137684, 0.780847], [-0.170589, 
  0.636645], [-0.194745, 0.535056], [-0.218572, 0.468729], [-0.25, 
  0.433013], [-0.296645, 0.423653], [-0.366, 0.436182], [-0.466057, 
  0.466057], [-0.607391, 0.509662], [-0.811991, 0.568562], [-1.29904, 
  0.75], [-1.82054, 0.848931], [-2.074, 0.754875], [-2.26113, 
  0.605869], [-2.39368, 0.42207], [-2.47337, 0.216392], [-2.5, 
  0.], [-2.47337, -0.216392], [-2.39368, -0.42207], [-2.26113, 
-0.605869], [-2.074, -0.754875], [-1.82054, -0.848931], [-1.29904, 
-0.75], [-0.811991, -0.568562], [-0.607391, -0.509662], [-0.466057, 
-0.466057], [-0.366, -0.436182], [-0.296645, -0.423653], [-0.25, 
-0.433013], [-0.218572, -0.468729], [-0.194745, -0.535056], 
[-0.170589, -0.636645], [-0.137684, -0.780847], [-0.0863938, 
-0.987485], [0., -1.5], [0.175073, -2.0011], [0.38326, -2.17358], 
[0.605869, -2.26113], [0.831316, -2.28402], [1.04928, -2.25019], 
[1.25, -2.16506], [1.42408, -2.0338], [1.56236, -1.86195], [1.65526, 
-1.65526], [1.69074, -1.4187], [1.64547, -1.15217], [1.29904, -0.75], 
[0.898384, -0.418923], [0.745076, -0.271185], [0.636645, -0.170589], 
[0.560745, -0.0988744], [0.515217, -0.0450756], [0.5, 0.]]);
}


module wheelHolder(){
	union(){
		translate([0,0,cylinderHeight]) cylinder(h=cylinderHeight, r=cylinderMaxRadius, center = true); 
		difference(){
			cylinder(h=cylinderHeight,r1=cylinderMinRadius,r2=cylinderMaxRadius, center=true);
			cylinder(h=cylinderHeight,r=screwRadius,center=true);
		}
	}
}


sf = (wheelOriginDistance )/2.5;

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
