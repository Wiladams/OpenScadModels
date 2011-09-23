goldenratio = 1.61803399;
joinfactor = 0.125;

mounthole = 3/2;		// Sized to fit an M3 screw
mountholedepth = 14;

pullknob_simplecylinder();

module pullknob_simplecylinder()
{
	difference()
	{
		cylinder(r=15, h=22);

		translate([0,0,-joinfactor])
		cylinder(r=mounthole, h=mountholedepth, $fn=12); 
	}
}