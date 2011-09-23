use <UClip.scad>
use <hinge.scad>

goldenratio = 1.61803399; 
gDefaultExtent = 25.4/2; 
gDefaultGap = 5; // MakerBot plywood
gDefaultThickness = 2;
gDefaultLength = 15;

HingedUClip(gDefaultLength, gDefaultExtent, gDefaultThickness, gDefaultGap);

module HingedUClip(length, extent, thickness, gap)
{
	union()
	{
		UClip(length, extent, thickness, gap);
	
		rotate([-90,-180, 0])
		//translate([0, 0, -thickness])
		hinge(thickness*goldenratio, length, notchdepth=thickness*goldenratio, $fn=12 );
	}
}
