module yquadrant(xquad, yquad)
{
	// Big cutout
	translate([0,29.5*yquad,0]) 
		cube(size=[32,5,5], center=true);
	translate([29.5*xquad,0,0]) 
		cube(size=[5,32,5], center=true);

	// edge slots
	translate([20*xquad, 28*yquad,0]) 
		cube(size=[1.5,8,5], center=true);
	translate([28*xquad, 20*yquad,0]) 
		cube(size=[8,1.5,5], center=true);

	translate([16*xquad, 28*yquad,0]) 
		cube(size=[1.5,8,5], center=true);
	translate([28*xquad, 16*yquad,0]) 
		cube(size=[8,1.5,5], center=true);
	
	// middle slot
	translate([0,22*yquad,0])
		cube(size=[4, 12, 5], center=true);
	translate([22*xquad,0,0])
		cube(size=[12, 4, 5], center=true);

	// little hole for quadrant
	translate([25.5*xquad, 25.5*yquad, 0]) 
		cylinder(h=5, r=3.0/2, center=true, $fn=10);

	// big hole for quadrant
	translate([15*xquad, 15*yquad, 0]) 
		cylinder(h=5, r=7.3/2, center=true, $fn=10);
}


module cutouts()
{
	difference()
	{
		cube(size=[63,63,4], center=true);	
		
		// Y Axis quadrants
		yquadrant(1,1);
		yquadrant(1,-1);
		yquadrant(-1,-1);
		yquadrant(-1,1);
		
		// Center hole
		cylinder(h=5, r=7.3/2, center=true, $fn=10);
	}
}

module yquaddimple(xquad, yquad)
{
	union()
	{	
		translate([17*xquad, 30*yquad,0])
			sphere(r=1, $fn=10);
		translate([30*xquad, 17*yquad,0])
			sphere(r=1, $fn=10);
	}

}

module dimples()
{
	yquaddimple(1,1);
	yquaddimple(1,-1);
	yquaddimple(-1,-1);
	yquaddimple(-1,1);
}



cutouts();
//dimples();
