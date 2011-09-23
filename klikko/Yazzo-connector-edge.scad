module connector(length, radius, gap)
{
	halfgap = gap / 2;

	difference()
	{
		// Lay down the basic connector
		union()
		{
			// lay down cylinders
			rotate([0,90,0]) translate([0,radius+halfgap]) 
				cylinder(h=length, r=radius, $fn=10);
			rotate([0,90,0]) translate([0,-radius-halfgap]) 
				cylinder(h=length, r=radius, $fn=10);
	
			// lay down connecting block
			translate([length/2,0,0]) 
				cube(size=[length, 2,2], center=true);
		}
	
		// Remove end dimples
		// +x end
		translate([length, radius+halfgap, 0])
			sphere(r=1, $fn=10);
		translate([length, -radius-halfgap, 0])
			sphere(r=1, $fn=10);

		// -x end
		translate([0, radius+halfgap, 0])
			sphere(r=1, $fn=10);
		translate([0, -radius-halfgap, 0])
			sphere(r=1, $fn=10);

		// Remove a little from the top and bottom
//		rotate([0,90,0]) translate([0,radius]) 
//				cylinder(h=length, r=radius, $fn=10);
	}
}

connector(33.5, 3.85/2, 0.5);