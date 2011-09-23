// You could simply do it this way if you have the boxes.scad
// file in your library
//use <boxes.scad>
//roundedBox([20, 30, 40], 5, true); 

// Or, you could do it this way if you want to roll your own
//roundedRect([20, 30, 40], 5, $fn=12);

//roundedPolygon([[-10,-10], [10,-10], [10,10], [-10,10]], 
//	polypaths=[[0,1,2]],
//	height = 10, 
//	radius=2);

miniround([20,30,40], 5);

// size - [x,y,z]
// radius - radius of corners
module roundedRect(size, radius)
{
	x = size[0];
	y = size[1];
	z = size[2];

	linear_extrude(height=z)
	hull()
	{
		// place 4 circles in the corners, with the given radius
		translate([(-x/2)+(radius/2), (-y/2)+(radius/2), 0])
		circle(r=radius);
	
		translate([(x/2)-(radius/2), (-y/2)+(radius/2), 0])
		circle(r=radius);
	
		translate([(-x/2)+(radius/2), (y/2)-(radius/2), 0])
		circle(r=radius);
	
		translate([(x/2)-(radius/2), (y/2)-(radius/2), 0])
		circle(r=radius);
	}
}


module roundedPolygon(polypoints, paths, height, radius)
{
	linear_extrude(height=height, convexity=3)
	hull()
	for(pt = polypoints)
	{
		translate([pt[0], pt[1], 0])
		circle(r=radius);
	}
}

module miniround(size, radius)
{
	$fn=20;	// This will affect the roundness of the sphere
			// A larger number will be more smooth, but kill
			// your performance

	x = size[0]-radius/2;
	y = size[1]-radius/2;

	minkowski()
	{
		cube(size=[x,y,size[2]]);
		//cylinder(r=radius);
		// Using a sphere is possible, but will kill performance
		sphere(r=radius);
	}
}