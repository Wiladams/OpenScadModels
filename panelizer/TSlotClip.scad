goldenratio = 1.61803399;
joinfactor = 0.125;

gDefaultExtent = 25.4/2; 
gDefaultGap = 5; // MakerBot plywood
gDefaultThickness = 2;
gDefaultLength = 15;

gMakerBotDoubleSlotLength = 50;

	gDefaultSlotDepth = 5;

//TSlotPin();
//ScrewHoleUClip(gDefaultLength, gDefaultExtent, gDefaultThickness, gDefaultGap);
//UClip(gDefaultLength, gDefaultExtent, gDefaultThickness, gDefaultGap); 
//TSlotClip(gDefaultLength, gDefaultExtent, gDefaultThickness, gDefaultGap);
//LTSlotClip(gDefaultLength, gDefaultExtent, gDefaultThickness, gDefaultGap);

//LLockClip(gDefaultLength, gDefaultExtent, gDefaultThickness, gDefaultGap); 
LLockClipSupported(gDefaultLength, gDefaultExtent, gDefaultThickness, gDefaultGap); 
//LLockClipStacker(gDefaultLength, gDefaultExtent, gDefaultThickness, gDefaultGap); 



module TSlotPin()
{
	grabbergap = 2;

	slotdepth = gDefaultSlotDepth;
	slotheight = 11.25;
	slotwidth = 3.2;

	snapdepth = (slotdepth/2)-(grabbergap/2) ;

	crossbeamlength = 5.5;
	crossbeambaseheight = 7;
	crossbeamheight = 3.2;


	union()
	{
		// Base
		translate([-slotwidth/2, 0, 0])
		cube(size=[slotwidth, slotdepth, slotheight*0.2]);

		// Front snap
		translate([-slotwidth/2, 0, 0])
		cube(size=[slotwidth, snapdepth, slotheight]);
		
		// cross beam
		translate([-crossbeamlength/2, 0, crossbeambaseheight])
		cube(size=[crossbeamlength, snapdepth, crossbeamheight]);
		
		translate([0, snapdepth-0.25, crossbeambaseheight+crossbeamheight/2])
		sphere(r=grabbergap/2, $fn=12);

		// Rear release
		translate([-slotwidth/2, slotdepth-snapdepth, 0])
		cube(size=[slotwidth, snapdepth, slotheight]);
		
		translate([0, slotdepth-snapdepth+0.25, crossbeambaseheight+crossbeamheight/2])
		sphere(r=grabbergap/2, $fn=12);

	}
}



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

module TSlotClip(length, extent, thickness, gap)
{
	rotate([90,0,0])
	UClip(length, extent, thickness, gap);

	translate([((thickness*2+gap)-gDefaultSlotDepth)/2, -length/2,+0.25])
	rotate([180,0,90])
	TSlotPin();
}

module LTSlotClip(length, extent, thickness, gap)
{
	//rotate([90,0,0])
	UClip(length, extent, thickness, gap);

	//translate([((thickness*2+gap)-gDefaultSlotDepth)/2, -length/2,+0.25])
	translate([(thickness*2+gap)-0.25, gDefaultSlotDepth, length /2])
	rotate([0,-90,180])
	TSlotPin();
}

module TSlotUClip(length, extent, thickness, gap)
{
	crossbeamlength = 5.5;
	crossbeambaseheight = 7;
	crossbeamheight = 3.2;

	// Lay down the basic UClip that will hold onto the T-slot
	UClip(length, extent, thickness, gap);

	// Add a key for the TSlot
	// Just a small piece of 6-sided cylinder
	// Placed in the right position
	translate([thickness+gap, thickness*2+crossbeambaseheight,length/2])
	rotate([90,30,0])
	color([0,0,1]) cylinder(r=crossbeamlength/2, h=thickness, $fn=6);

}

module ScrewHoleUClip(length, extent, thickness, gap, screwdiameter)
{
	screwoffset = 7.5;

	union()
	{
		UClip(length, extent, thickness, gap);
		
		// Place two dimples to snap into the screw hole
		translate([thickness, thickness+screwoffset, length/2])
		sphere(r=screwdiameter/2/goldenratio, $fn=12);
	
		translate([thickness+gap, thickness+screwoffset, length/2])
		sphere(r=screwdiameter/2/goldenratio, $fn=12);
	}
}

// This clip is designed to fit into the T-Slot that is formed by 
// the capture nut slot in laser cut wood designs.  It has an offset
// which is typical of these designs, as they are not corner connected.
module LLockClip(length, extent, thickness, gap)
{
	paneloffset = 5;

	screwdiameter = 3.2;

	crossbeamlength = 5.5;
	crossbeambaseheight = 7;
	crossbeamheight = 3.2;

	// UClip for a T-Slot
	TSlotUClip(length, extent, thickness, gap);

	// Do another UClip with an Opposing L orientation
	rotate([0,0,90])
	translate([(-thickness)-gap,-paneloffset-thickness*2-gap,0])
	ScrewHoleUClip(length, extent, thickness, gap, screwdiameter);
}

module LLockClipSupported(length, extent, thickness, gap)
{
	paneloffset = 5;

	difference()
	{
		union()
		{
			LLockClip(length, extent, thickness, gap);
		
			translate([gap+thickness*2, thickness, 0])
			cube(size=[paneloffset, paneloffset, length]);
		}

		translate([+(paneloffset)+gap+thickness*2, thickness+(paneloffset), -joinfactor])
		cylinder(r=paneloffset, h=length+2*joinfactor, $fn=24);
	}
}

module LLockClipStacker(length, extent, thickness, gap)
{
	LLockClip(length, extent, thickness, gap);

	// Another TSlotClip on the other side
	rotate([0,180,180])
	translate([0, gap,-length])
	TSlotUClip(length, extent, thickness, gap);

}