// This clip is meant to fit within a cutout slot 
// It has a tab for the cutout on one side
// and a slot for the panel on the other side
module UClip(length, extent, thickness, gap)
{
baselength = 2*thickness+gap;

tablength = 5.25;
tabheight = 10;
tabwidth = gap;

	union()
	{
		// Base wall along x-axis
		cube(size=[baselength, thickness, length]);

		// Panel clip along y-axis
		translate([0, thickness-0.25, 0])
		cube(size=[thickness, extent+0.25, length]);
		translate([thickness+gap, thickness-0.25, 0])
		cube(size=[thickness, extent+0.25, length]);
	}
}
