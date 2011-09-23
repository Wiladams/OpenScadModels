gDefaultExtent = 25.4/2;
gDefaultGap = 5;	// MakerBot plywood
gDefaultThickness = 2;
gDefaultLength = 15;

gMakerBotDoubleSlotLength = 50;

// 1/4" plywood (6.29)
Lclip(gDefaultLength, gDefaultExtent, gDefaultThickness, 6.00);

//Lclip(gDefaultLength, gDefaultExtent, gDefaultThickness, gDefaultGap);
//LOffsetClip(gDefaultLength, gDefaultExtent, gDefaultThickness, gDefaultGap);
//Tclip(gDefaultLength, gDefaultExtent, gDefaultThickness, gDefaultGap);
//TOffsetClip(gDefaultLength, gDefaultExtent, gDefaultThickness, gDefaultGap);
//HClip(gDefaultLength, gDefaultExtent, gDefaultThickness, gDefaultGap);
//SingleSlotClip(gDefaultLength, gDefaultExtent, gDefaultThickness, gDefaultGap);
//DoubleSlotClip(gMakerBotDoubleSlotLength, gDefaultExtent, gDefaultThickness, gDefaultGap);

module Lclip(length, extent, thickness, gap)
{
	// Outer wall along x-axis	
	cube(size=[thickness*2+gap+extent, thickness, length]);
	
	// inner wall along x-axis
	translate([thickness*2+gap-0.25, thickness+gap, 0])
	cube(size=[extent+0.25, thickness, length]);

	// Outer wall along y-axis
	cube(size=[thickness, extent+thickness, length]);

	// inner wall along y-axis
	translate([thickness+gap, thickness-0.25,0])
	cube(size=[thickness, extent+0.25, length]);
}

module LOffsetClip(length, extent, thickness, gap)
{
	// Outer wall along x-axis	
	cube(size=[thickness*2+gap+extent, thickness, length]);
	
	// inner wall along x-axis
	translate([thickness*2+gap-0.25, thickness+gap, 0])
	cube(size=[extent+0.25, thickness, length]);

	// Outer wall along y-axis
	cube(size=[thickness, thickness*2+gap+extent, length]);

	// inner wall along y-axis
	translate([thickness+gap, 0,0])
	cube(size=[thickness, thickness*2+gap+extent, length]);

	// Joining corner section
	cube(size=[gap+thickness*2, gap+thickness*2, length]);
}

module Tclip(length, extent, thickness, gap)
{
	// Outer wall along x-axis	
	cube(size=[thickness*2+gap+extent, thickness, length]);
	
	// inner wall along x-axis
	translate([thickness*2+gap-0.25, thickness+gap, 0])
	cube(size=[extent+0.25, thickness, length]);

	// Outer wall along y-axis
	cube(size=[thickness, extent+thickness, length]);

	// inner wall along y-axis
	translate([thickness+gap, thickness-0.25,0])
	cube(size=[thickness, extent+0.25, length]);

	// Negative x-axis
	translate([-extent+0.25,0,0])
	cube(size=[extent+0.25, thickness, length]);

	// inner wall along negative x-axis
	translate([-extent+0.25, thickness+gap, 0])
	cube(size=[extent+0.25, thickness, length]);

}

module TOffsetClip(length, extent, thickness, gap)
{
	xwalllength = thickness*2+gap+extent;

	// Joining corner section
	cube(size=[gap+thickness*2, gap+thickness*2, length]);

	// Outer wall along x-axis	
	cube(size=[thickness*2+gap+extent, thickness, length]);
	
	translate([-extent, 0, 0])
	cube(size=[extent+0.25, thickness, length]);

	translate([-extent, thickness+gap, 0])
	cube(size=[extent+0.25, thickness, length]);

	// inner wall along x-axis
	translate([0, thickness+gap, 0])
	cube(size=[thickness*2+gap+extent, thickness, length]);

	// Outer wall along y-axis
	cube(size=[thickness, thickness*2+gap+extent, length]);

	// inner wall along y-axis
	translate([thickness+gap, 0,0])
	cube(size=[thickness, thickness*2+gap+extent, length]);

}

module HClip(length, extent, thickness, gap)
{
	union()
	{
		// Outer wall along x-axis	
		translate([-extent-thickness/2, 0,0])
		cube(size=[thickness+extent*2, thickness, length]);
		
		translate([-extent-thickness/2, thickness+gap-0.25,0])
		cube(size=[thickness+extent*2, thickness+0.25, length]);
	
		// divider wall along y-axis
		translate([-thickness/2, thickness-0.25, 0])
		cube(size=[thickness, gap+thickness+0.25, length]);
	}
}

// This clip is meant to fit within a cutout slot
// It has a tab for the cutout on one side
// and a slot for the panel on the other side
module SingleSlotClip(length, extent, thickness, gap)
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
	
		// Place a slot on the back
		translate([(baselength-tablength)/2, -tabwidth+0.25, (length-tablength)/2-tablength/2])
		cube(size=[5.125, tabwidth+0.25, 10]);
	}
}

// This clip is meant to fit within a cutout slot
// It has a tab for the cutout on one side
// and a slot for the panel on the other side
module DoubleSlotClip(length, extent, thickness, gap)
{
	baselength = 2*thickness+gap;

	tablength = 5.25;
	tabheight = 10;
	tabwidth = gap;

	difference()
	{
		union()
		{
			// Base wall along x-axis
			cube(size=[baselength, thickness, length]);
		
			// Panel clip along y-axis
			translate([0, thickness-0.25, 0])
			cube(size=[thickness, extent+0.25, length]);
		
			translate([thickness+gap, thickness-0.25, 0])
			cube(size=[thickness, extent+0.25, length]);
		
			// Place two slots on the back, at the edges
			translate([(baselength-tablength)/2, -tabwidth+0.25, (length-tabheight)])
			cube(size=[tablength, tabwidth+0.25, tabheight]);
	
			translate([(baselength-tablength)/2, -tabwidth+0.25, 0])
			cube(size=[tablength, tabwidth+0.25, tabheight]);
	
		}
		// Subtract a mounting hole for a roughly M3 sized screw
		translate([baselength/2, thickness+0.25, length/2])
		rotate([90, 0,0])
		cylinder(r=3/2, h=thickness+0.5, $fn=12);
	}
}