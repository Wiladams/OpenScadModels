//toothstamp(depth=3, width=3, 4);
//tootheddisc(75/2, 4, 6, 3);
//groove(65/2, 4, 3);
//grooveholder(65/2, 4, 3);
//grooveddisc(64.5/2, 4, 4, 3);
groovedwheel(65/2, 75/2);
//cradle_samsungfocus();
//cradle_samsungfocusfat();

	goldenratio = 1.61803399;
	joinfactor = 0.25;

module toothstamp(depth, width, height)
{
	cube([depth, width, height]);
}

module tootheddisc(radius, height, teeth, toothdepth, toothwidth)
{
	toothrotation = 360 / teeth;	

	difference()
	{
		cylinder(h=height, r=radius);

		for(i=[1:teeth])
		{
			rotate([0, 0, i*toothrotation])
			translate([radius-toothdepth, 0, -joinfactor])
			toothstamp(toothdepth+joinfactor, toothwidth, height+joinfactor*2);
		}
	}
}

module grooveddisc(radius, height, slotwidth, slotdepth)
{
	grooveradius = slotdepth/4;

	union()
	{
		difference()
		{
			cylinder(r=radius, h=height);
	
			// subtract out the slot
			translate([-radius-joinfactor, -slotwidth/2, height-slotdepth])
			cube(size=[radius*2+joinfactor*2, slotwidth, slotdepth+joinfactor]);
		}

		// add in some cylinder action to form a fitting groove
		rotate([0, 90, 0])
		translate([-height+grooveradius, -slotwidth/2, -radius])
		cylinder(r=grooveradius, h =(radius*2), $fn=6); 

		rotate([0, 90, 0])
		translate([-height+grooveradius, +slotwidth/2, -radius])
		cylinder(r=grooveradius, h =(radius*2), $fn=6); 
	}
}

module groove(length, slotwidth, slotdepth)
{
	grooveradius = slotdepth/4;

	wallheight = slotdepth+joinfactor;
	walldepth = slotwidth/goldenratio;
	walllength = length;

	union()
	{
		// plus-y wall
		translate([0, slotwidth/2, 0])
		cube(size=[walllength, walldepth, wallheight]);

		rotate([0, 90, 0])
		translate([-wallheight+grooveradius, slotwidth/2, 0])
		cylinder(r=grooveradius, h = length, $fn=6); 

		// minus-y wall
		translate([0, -(slotwidth/2)-walldepth, 0])
		cube(size=[walllength, walldepth, wallheight]);

		rotate([0, 90, 0])
		translate([-wallheight+grooveradius, -(slotwidth/2), 0])
		cylinder(r=grooveradius, h = length, $fn=6); 
	}
}

module grooveholder(length, slotwidth, slotdepth)
{
	grooveradius = slotdepth/4;

	wallheight = slotdepth+joinfactor;
	walldepth = grooveradius;
	walllength = length;

	basewidth = slotwidth-joinfactor*2;
	baseheight = slotdepth-grooveradius*2;

	neckwidth = slotwidth-grooveradius*2-joinfactor;

	union()
	{
		translate([0, (basewidth-neckwidth)/2 , 0])
		cube(size=[walllength, neckwidth, grooveradius*2+joinfactor]);

		translate([0, 0, baseheight-joinfactor])
		cube(size=[walllength,basewidth, baseheight]);


	}
}

module groovedwheel(innerradius, outerradius)
{
	baseheight = 4;

	teeth = 12;
	toothdepth = 3;
	toothwidth = 5;

	stencils = 4;
	stencilradius = 10;
	stencilangle = 360 / stencils;

	diffradius = outerradius - innerradius;

	difference()
	{
		union()
		{
			tootheddisc(outerradius, baseheight, teeth, toothdepth, toothwidth, $fn=teeth);
	
			translate([-innerradius, 0, baseheight-joinfactor])
			groove(innerradius*2, 4, 3);
		}

		// subtract out some holes to reduce the amount of plastic on the base disc
		for (i=[0:stencils])
		{
			rotate([0, 0, (i*stencilangle)+45])
			translate([outerradius-stencilradius-diffradius, 0, -joinfactor])
			cylinder(r=stencilradius, h=baseheight+joinfactor*2);
		}

		// put an axle hole through the middle of the disc
		// to fit a M3 threaded bolt, or roughly that size
		translate([0,0,-joinfactor])
		cylinder(r=3.2/2, h = baseheight+joinfactor*2, $fn=12);
	}
}

// Phone clips
module cradle_samsungfocus()
{
	slotwidth = 4;
	slotdepth = 3;

	devicethickness = 12;
	devicecoverextent = 8;

	wallthickness = 3;
	supportwallheight = 20;
	sidewallheight = 10;

	union()
	{
		// long back support wall
		cube(size=[wallthickness, devicethickness+wallthickness*2, supportwallheight+wallthickness]);
	
		// base
		cube(size=[devicecoverextent+wallthickness, wallthickness*2+devicethickness, wallthickness]);
	
		// Side walls
		cube(size=[8+wallthickness, wallthickness, sidewallheight+wallthickness]);
	
		translate([0, wallthickness+devicethickness, 0])
		cube(size=[8+wallthickness, wallthickness, sidewallheight+wallthickness]);
	
		// put a groove on the back of it
		rotate([0, -90, 0])
		translate([0, ((devicethickness+wallthickness*2)-slotwidth)/2, 0])
		grooveholder(supportwallheight+wallthickness, slotwidth, slotdepth);
	}
}

module cradle_samsungfocusfat()
{
	slotwidth = 4;
	slotdepth = 3;

	devicethickness = 13.5;
	devicecoverextent = 16;

	wallthickness = 3;
	supportwallheight = 30;
	sidewallheight = 30;

	difference()
	{
		union()
		{
			// long back support wall
			cube(size=[wallthickness, devicethickness+wallthickness*2, supportwallheight+wallthickness]);
			
			// Side walls
			cube(size=[devicecoverextent+wallthickness, wallthickness, sidewallheight+wallthickness]);
		
			translate([0, wallthickness+devicethickness, 0])
			cube(size=[devicecoverextent+wallthickness, wallthickness, sidewallheight+wallthickness]);
		
			// put a groove on the back of it
			rotate([0, -90, 0])
			translate([0, ((devicethickness+wallthickness*2)-slotwidth)/2, 0])
			grooveholder(supportwallheight+wallthickness, slotwidth, slotdepth);
		}
	}
}