handyman();

module grasper(height, outerradius, innerradius)
{
	slotsize = 3.3;
	slotoffset = 0;

	difference()
	{
		cylinder(h=height, r=outerradius, $fn = 12);

		// Subtract inner cylinder
		cylinder(h=height+0.5, r=innerradius, $fn =12);

		// Subtract slot
		translate([-slotsize/2,slotoffset,-0.25]) color([1,0,0]) 
			cube(size=[3.5, innerradius*2+0.5, height+0.5]);
	}
}

module handyman()
{
	armlength = 48;
	outerradius = 8/2;
	innerradius = 3.85/2;
	height = 7;
	thickness = 3;

	union()
	{
		difference()
		{
			// The backbone
			translate([0,0,0]) cube(size=[armlength, thickness, height]);
				

			// Remove some curves so graspers can be cleanly attached
			translate([0,outerradius,-0.25]) cylinder(h= height +0.5, r = outerradius-0.25);
	
			translate([armlength, outerradius, 0]) cylinder(h=height+0.5, r=outerradius-0.25);
		}
	
		// The grasping connectors
		translate([0, outerradius, 0])
			grasper(7, outerradius, innerradius);
	
		translate([armlength, outerradius, 0])
			grasper(7,outerradius, innerradius);
	}

}