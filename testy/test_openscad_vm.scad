/*
	License: This file is public domain code 
	Placed By: William A Adams
	17 July 2011
*/

include <openscad_vm.scad>

//======================================= 
// Test Routines
//=======================================
//place_prim([PRIM_CUBE, [10,5,15, true], zero(), zero()]);
//place_prim([PRIM_SPHERE, [6], zero(), zero()]);

//place_prims([
// [PRIM_CUBE, [10,5,15, true], zero(), zero()],
// [PRIM_SPHERE, [6], zero(), zero()],
//]);

//EXEC([PRIM_CUBE, [10,5,15, true], zero(), zero()]);
//EXEC([OP_UNION, 
// [PRIM_CUBE, [10,5,15, true], zero(), zero()],
// [PRIM_SPHERE, [6], zero(), zero()],
// ]);

// Executing using helper functions
//EXEC(UNION( [
//	CUBE([10,5,15], center=true),
//	SPHERE(r=6),
//	CYLINDER(r1=7, r2=2,h=10)
//	]));

// Executing all inline
//EXEC([OP_DIFFERENCE, 
// [PRIM_CUBE, [10,5,15, true], zero(), zero()],
// [PRIM_SPHERE, [3], zero(), zero()],
// ]);


// Assigning to a variable for later usage
//cube1 = CUBE([10,20,30], center=true);
//
//EXEC(cube1);


//================================== 
// PRINT ROUTINES
//
// Some parts inspired from the Mars Exploration Rover thing
//	 http://www.thingiverse.com/thing:10057
//
//==================================


//EXEC(target());
//EXEC(arm_sensor());
//EXEC(antenna_uhf());
//EXEC(bolt());
//EXEC(camera());
//EXEC(camera_top_side());
EXEC(wheel());

//======================================== 
// Part Definitions
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
	DIFFERENCE(
		UNION([
			CYLINDER(r1=20/2,r2=17/2, h=5, trans=[0, 0, 10]),
			CYLINDER(r1=20/2, r2=20/2, h=5, trans=[0, 0, 5]),
			CYLINDER(r1=17/2, r2=20/2, h=5),
		]),

		[OP_UNION,[
			[PRIM_CYLINDER, [13/2, 13/2, 15], [0, 0, 15/2], zero()],
			[PRIM_CYLINDER, [2,2,15+2], [0, 0, -1], zero()],
		]]
	);
