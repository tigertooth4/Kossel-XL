// circuit cover

$fn=20;
module circuitCover(){
    difference(){
        cube([50, 25, 3]);
        translate([10,4, -1]) cube([26,14, 5]);
        translate([10-1.5, 4+1.5, -1]) cylinder(d=2, h=5);
        translate([10-1.5, 4+13.5 + 4.5, -1]) cylinder(d=2, h=5);
        translate([10+25.5+2.5, 4+1.5, -1]) cylinder(d=2, h=5);
        translate([10+25.5+2.5, 4+13.5+4.5, -1]) cylinder(d=2, h=5);
        
        translate([4,3,-1]) cylinder(d=3,h=5);
        translate([4, 3+18.5, -1]) cylinder(d=3, h=5);
        translate([4 + 42,3,-1]) cylinder(d=3,h=5);
        translate([4 + 42, 3+18.5, -1]) cylinder(d=3, h=5);

    }   
}

circuitCover();