/*
	By: William A Adams
	http://williamaadams.wordpress.com
*/

joinfactor = 0.1;
goldenratio = 1.618;

//nutslot(OR=6, facets=6, thickness=3, scaler=goldenratio);
//nuthatch(IR=3, OR=6, facets=6, thickness=3, fillet=true);
connector(IR=1/2*25.4, length = 2*25.4);

//================================================
//  Component Routines
//================================================
module tube(IR, OR, height)
{
	difference()
	{
		cylinder(r=OR, h=height);

		translate([0,0,-joinfactor])
		cylinder(r=IR, h=height+joinfactor*2);
	}
}

module nutslot(OR, facets=6, thickness=3, scaler=goldenratio)
{
	size = OR *2* scaler;

	difference()
	{
		cube(size=[size, thickness, size], center=true);
	
		rotate([90, 90, 0])
		cylinder(r=OR, h=thickness+2*joinfactor, center=true, $fn=facets);

		translate([0, 0, OR])
		cube(size=[OR*2, thickness+2*joinfactor, OR*2], center=true);
	}
}

/*
	Take the nutslot, and put it in a sandwhich
*/
module nuthatch(IR, OR, facets=6, thickness=3, fillet=false)
{
	size = OR*2*goldenratio;
	filletdepth = (thickness*3-joinfactor*2);
	filletheight =  (thickness*3-joinfactor*2)/2;

	difference()
	{
		union()
		{
			translate([0, +thickness-joinfactor, 0])
			cube(size=[size, thickness, size], center=true);
			
			nutslot(OR, facets, thickness, goldenratio);
		
			translate([0, -thickness+joinfactor, 0])
			cube(size=[size, thickness, size], center=true);

			if (fillet)
			{
				translate([0, 0, -filletheight/2-size/2+joinfactor])
				cube(size=[size, filletdepth, filletheight], center=true);
			}
		}

		rotate([90, 0, 0])
		cylinder(r=IR, h=thickness*3+joinfactor*2, center=true, $fn=12);

		if (fillet)
		{
			translate([0, -(thickness*3-joinfactor*2)/2, -size/2-thickness*3/2])
			rotate([0,90,0])
			cylinder(r=filletdepth, h = size+joinfactor*2, center=true);
		}
	}
}

/*
	Mate the nuthatch on the side of a tube
*/
module connector(IR, length)
{
	OR = IR*goldenratio;
	thickness = OR - IR;

	nutIR = 3;
	nutOR = 5;
	nutFacets = 6;
	nutThickness = 3;

	nuthatchsize = nutOR*2*goldenratio;

	difference()
	{
		union()
		{
			tube(IR, OR, height = length);
	
			translate([0, -nutThickness/2-nutThickness-OR+nutThickness, length/2])
			nuthatch(IR=nutIR, OR = nutOR, facets=nutFacets, thickness=nutThickness, fillet=true);
		}

		// Cut a hole all the way through to the pipe
		translate([0,0,length/2])
		rotate([90, 0, 0])
		cylinder(r=nutIR, h=OR+joinfactor);
	}
}
