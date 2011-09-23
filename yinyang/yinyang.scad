joinfactor = 0.005;

yinyang(10, 2);

module halfyinyang(largeradius, focalradius, thickness = 2)
{
	smallradius = largeradius / 2;
	
	difference()
	{
		union()
		{
			difference()
			{
				cylinder(r=largeradius, h=thickness, center=true);
					
				translate([largeradius/2,0, 0])
				cube(size=[largeradius+joinfactor, (largeradius*2)+joinfactor*2, thickness+joinfactor*2], center=true);
		
				translate([0, -smallradius, 0])
				cylinder(r=smallradius, h=thickness+joinfactor, center=true);
			
			}
		
			translate([0, smallradius, 0])
			cylinder(r=smallradius, h=thickness, center=true);
		}

		translate([0, smallradius, 0])
		cylinder(r=focalradius, h =thickness+2*joinfactor, center=true );
	}
}

module yinyang(largeradius, focalradius, thickness = 2)
{
	// Color seems to even apply itself to the parts that have been
	// subtracted.  In this case, we print one half taller than the other
	// half to overcome the overwriting of the color.
	color([0,0,0])
	halfyinyang(largeradius, focalradius, thickness = thickness+joinfactor*4, $fn=24);

	color([1,1,1])
	translate([0.5, -0.5,0])
	rotate([0, 0, 180])
	halfyinyang(largeradius, focalradius, thickness, $fn=24);
}