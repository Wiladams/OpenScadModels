//roundedcorner(4, 10);
//roundedbox(65,45,4, 8);
//roundedshelf(65, 45, 4);
//roundedgroove(65, 3, 2);
//groovedwall(length=45, height=9, thickness=3, groovedepth=4.5);
protrudinghookwall(walllength=45, wallheight=19, wallthickness=3, hooksize=2);

module roundedcorner(height, radius)
{
	intersection()
	{
		cube(size=[radius, radius, height]);
		color([1,0,0]) cylinder(h=height, r=radius, $fn=32);
	}
}

module roundedbox( length, width, height, radius)
{
	strutlength = length - radius*2;
	strutwidth = width - radius*2;

	translate([length-radius, width-radius, 0]) rotate([0,0,0]) roundedcorner(height, radius);

	translate([radius, width-radius, 0]) rotate([0,0,90]) roundedcorner(height, radius);
	
	translate([radius, radius, 0]) rotate([0,0,180]) roundedcorner(height, radius);
	
	translate([length-radius, radius, 0]) rotate([0,0,270]) roundedcorner(height, radius);

	// Connect corners with filler rectangles
	translate([radius, width-radius,0]) cube(size=[strutlength, radius, height]);
	translate([radius, 0,0]) cube(size=[strutlength, radius, height]);
	translate([0, radius, 0]) cube(size=[radius,strutwidth,height]);
	translate([length-radius, radius, 0]) cube(size=[radius,strutwidth,height]);

	// Fill in the center rectangle
	translate([radius, radius,0]) cube(size=[strutlength, strutwidth, height]);
}

module roundedshelf(length, width, height)
{
	rotate([0,90,0]) 
	translate([-height/2,width-(height/2),0])
	union()
	{
		roundedcorner(length, height/2);
		rotate([0,0,90]) roundedcorner(length, height/2);
	}

	cube(size=[length, width-height/2, height]);
}

module roundedgroove(length, width, height)
{
	difference()
	{
		union()
		{
			roundedshelf(length, width, height/3);
			translate([0,0,height/3]) cube(size=[length, width-height/3/2, height/3]);
			translate([0,0,(height/3)*2]) roundedshelf(length, width, height/3);
		}

		// subtract a cylinder to make the smooth bottom of the track
		rotate([0,90,0]) 
		translate([-(height/3)-(height/3)/2,width-height/3/2,-0.25]) 
			cylinder(h=length+0.5, r=(height/3)/2, $fn=32);
	}
}


// Walls
module groovedwall(length, height, thickness, groovedepth)
{
	lowerwallheight = height - groovedepth + groovedepth/3/2;
	
	union()
	{
	// place the lower wall
	color([0,0,1]) cube(size=[length, thickness, lowerwallheight]);
	
	// Place the grooved portion
	translate([0,0,height-groovedepth])
	roundedgroove(length, thickness, groovedepth);
	}
}

module protrudinghookwall(walllength, wallheight, wallthickness, hooksize)
{
	lowerwallheight = wallheight - hooksize *2;

	difference()
	{
		union()
		{
		// place the wall
		color([0,0,1]) cube(size=[walllength, wallthickness, wallheight]);
		
		
		// place the hook cyclinder
		color([1,0,0])
		translate([0, wallthickness, wallheight-(hooksize/2)])
		rotate([0,90,0])
		cylinder(r=hooksize/2, h=walllength, $fn=6);
		}

		// subtract the undercut
		translate([-0.25
, wallthickness, wallheight-(hooksize/2)-hooksize])
		rotate([0,90,0])
		cylinder(r=hooksize/2, h=walllength+0.5, $fn=6);
	}
}
