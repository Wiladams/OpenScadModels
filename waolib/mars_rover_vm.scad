/*
	This file is a demonstration of how to use the openscad_vm technique.

	The parts defined here are taken from the Mars Exploration Rover object
		http://www.thingiverse.com/thing:10057
	Which was originally created by  Tony Buser<tbuser@gmail.com>

	License: This file is public domain code
	Placed By: William A Adams
	17 July 2011
*/

include <openscad_vm.scad>


//==================================
//	PRINT  ROUTINES
//==================================


EXEC(target());
//EXEC(arm_sensor());
//EXEC(antenna_uhf());
//EXEC(bolt());
//EXEC(camera());
//EXEC(camera_top_side());

//========================================
//	Part Definitions
//========================================

function antenna_uhf() =
	[OP_UNION, [
		[PRIM_CYLINDER, [2,2, 8+15+3],zero(), zero()],
		[PRIM_CYLINDER, [4,4, 3],zero(),zero()],
	]];

function arm_sensor() =
	[OP_UNION,[
		[PRIM_CUBE, [6, 10, 5, false],zero(), zero()],
		[PRIM_CYLINDER, [2,2, 10],[6/2, 2, 0], zero()],
		[PRIM_CUBE, [2, 15, 5, false], [6/2-1, 0, 0], zero()],
	]];

function bolt() = 
	[OP_UNION,[
		[PRIM_CYLINDER, [6,6, 3], zero(), zero()],
		[PRIM_CYLINDER, [2,2, 10], zero(),zero()],
	]];

//
// The camera is a fairly compound object, with 2 levels of nesting
//
function camera() =
	[OP_DIFFERENCE,
    		[OP_UNION,[ 
			[OP_DIFFERENCE,
				[PRIM_CUBE,[41, 10, 10], zero(), zero()],
				[PRIM_CUBE, [41-8, 10-2+1, 10-2+1], [4, 2, 2], zero()]
			],

      			// cameras
			[OP_UNION,[
				[PRIM_CYLINDER, [4,4,12],[10, 6, 0]],
				[PRIM_CYLINDER, [2,2,14],[10, 6, 0]],
		
				[PRIM_CYLINDER, [4,4,12], [41-10, 6, 0]],
				[PRIM_CYLINDER, [2,2,14], [41-10, 6, 0]],

		      		// tabs
				[PRIM_CUBE, [4, 13, 10],[0, -13, 0]], 
				[PRIM_CUBE, [4, 13, 10], [41-4, -13, 0]]
		      	]]
    		]],
    
	    	// holes
		[OP_UNION,[
			[PRIM_CYLINDER, [2,2,50], [-1, -8, 5], [0, 90, 0]]
		]]
	];


function camera_top_side() =
	[OP_UNION, [
		[PRIM_CYLINDER, [2,2,20],zero(), zero()], 
		[PRIM_CYLINDER, [4.5,4.5, 15],zero(), zero()]
	]];

function target() = UNION( [
	CYLINDER(r1=2, r2=2, h=4+4+3),
	CYLINDER(r1=4, r2=4, h=3),
	]);

function wheel() =
	[OP_DIFFERENCE,
		[OP_UNION,[
			[PRIM_CYLINDER, [20/2,17/2,5], [0, 0, 10], zero()],
			[PRIM_CYLINDER,[20/2, 20/2, 5], [0, 0, 5], zero()],
			[PRIM_CYLINDER,[17/2, 20/2, 5], [0, 0, 0],zero()],
		]],

	    	[OP_UNION,[
			[PRIM_CYLINDER, [13/2, 13/2, 15], [0, 0, 15/2], zero()],
			[PRIM_CYLINDER, [2,2,15+2], [0, 0, -1], zero()],
		]]
      	];


