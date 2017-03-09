/*
	File: openscad_vm.scad

	Description:  The OpenScad VM is a technique for encapsulation of 
	OpenScad routines as arrays of operations.  

	License: Public Domain
	Placed By: William A Adams
	17 July 2011

	While OpenScad is a fairly straightforward largely declarative language
	it is constrained in certain aspects.  One of those aspects is the lack
	of recursion in modules.  This constraint makes it fairly challenging to 
	create complex compound parts computationally.  This openscad_vm
	is meant to help the user go beyond that constraint.

	The fundamental methodology utilized here is to encode the various
	CSG operations in arrays of operations.  There are the basic CSG
	operations of UNION, DIFFERENCE, INTERSECTION, and then there
	are the 3D primitives; CUBE, SPHERE, CYLINDER.

	There are routines here that help you simply place a list of primitives,
	including their translation, rotation, and scaling (place_prim).  As well,
	the more complex 'CSG()' module will take a compound object definition
	and recursively perform the various CSG operations until the
	object is ultimately rendered as primitives.
*/

function zero() = [0,0,0]; 

OP_CSG = 0;
OP_UNION = 1;
OP_DIFFERENCE = 2;
OP_INTERSECTION = 3;
OP_OPMAX = 7;

// The base constant for primitive types 
PRIM_BASE = OP_OPMAX+1;
PRIM_CUBE = PRIM_BASE+1;
PRIM_SPHERE = PRIM_BASE+2;
PRIM_CYLINDER = PRIM_BASE+3;

PRIM_MAX = 255;

USER_BASE = PRIM_MAX+1;

//=====================================
//	Helper Functions
//=====================================

//=============
// 3D Shapes
//=============
function CUBE(size, center=false, trans=zero(), rot=zero()) = 
	[PRIM_CUBE, [size[0], size[1], size[2], center], trans, rot];

function SPHERE(r, trans=zero(), rot=zero()) =
	[PRIM_SPHERE, [r], trans, rot];

function CYLINDER(r1=1, r2=1, h=1, center = false, trans=zero(), rot=zero(), scale=[1,1,1]) =
	[PRIM_CYLINDER, [r1, r2, h, center], trans, rot, scale];

//=============
// CSG Operations
//=============
function UNION(parts) = [OP_UNION, parts];

function DIFFERENCE(part1, part2) = [OP_DIFFERENCE, part1, part2];

function INTERSECTION(parts) = [OP_INTERSECTION, parts];

//=====================================
//		MODULES
//=====================================

/*
	Module: place_prim

	Description: Place an OpenScad primitive
	The primitives are CUBE, SPHERE, CYLINDER.  You represent a 
	primitive in an array.

	obj[0] == primitive type one of [PRIM_CUBE | PRIM_SPHERE | PRIM_CYLINDER]
	obj[1] == params, whatever parameters are necessary for that primitive
	obj[2] == trans, an array representing the translation
	obj[3] == rotation, an array representing the rotation

*/
module place_prim(obj) 
{
	primtype = obj[0];
	params = obj[1];
	trans = obj[2];
	rot = obj[3];

	translate(trans)
	rotate(rot)
	if (primtype== PRIM_CUBE) 
	{
		cube(size=[params[0], params[1], params[2]], center=params[3]);
	} else if (primtype == PRIM_CYLINDER) 
	{
		cylinder(r1=params[0], r2 = params[1], h=params[2]);
	} else if (primtype == PRIM_SPHERE)
	{
		sphere(r=params[0]);
	}
}

module place_prims(prims) 
{
	// part, params, trans, rotate
	for (prim = prims)
		place_prim(prim);
}


/*
	Module: EXEC

	Description:  This module will place parts according to a description
	that is encapsulated in an array.  Within the array, you can construct
	compound CSG objects, using UNION, DIFFERENCE, and 
	INTERSECTION.

	Note: At present, the routines will go through 4 levels of recursion.
	Adding more levels is as easy as just copying the CSG(x) and adding
	a new one.

	The following is a typical parameter to the CSG routine.

	CSG([OP_DIFFERENCE, 
		[PRIM_CUBE, [10,5,15, true], zero(), zero()],
		[OP_UNION,[
			[PRIM_SPHERE, [3],  [-2,0,0], zero()],
			[PRIM_SPHERE, [3], [2,0,0], zero()],
			]]
		]);
	
*/

module EXEC(opparts) 
{
	op = opparts[0];
	operand1 = opparts[1];
	operand2 = opparts[2];

//echo();
//echo("OPARTS: ", opparts);
//echo("OP: ", op);
//echo("OPERAND1: ", operand1);
//echo("OPERAND2: ", operand2);

	if (op == OP_UNION)
	{
//		echo("EXEC: UNION");
		
		union()
		{
			// There are multiple objects to be unioned
			for(part = operand1)
			{
				EXEC1(part);
			}
		}
	} else if (op == OP_DIFFERENCE)
	{
		difference()
		{
			EXEC1(operand1);

			EXEC1(operand2);
		}
	}  else if (op == OP_INTERSECTION)
	{
		intersection()
		{
			// There are multiple objects to be intersected
			for(part = operand1)
			{
				EXEC1(part);
			}
		}
	} else if ((op > PRIM_BASE) && (op < PRIM_MAX))
	{
		place_prim(opparts);
	} 
}

module EXEC1(opparts) 
{
	op = opparts[0];
	operand1 = opparts[1];
	operand2 = opparts[2];

//echo();
//echo("OPARTS: ", opparts);
//echo("OP: ", op);
//echo("OPERAND1: ", operand1);
//echo("OPERAND2: ", operand2);

	if (op == OP_UNION)
	{
//		echo("EXEC: UNION");
		
		union()
		{
			// There are multiple objects to be unioned
			for(part = operand1)
			{
				EXEC2(part);
			}
		}
	} else if (op == OP_DIFFERENCE)
	{
		difference()
		{
			EXEC2(operand1);

			EXEC2(operand2);
		}
	} else if ((op > PRIM_BASE) && (op < PRIM_MAX))
	{
		place_prim(opparts);
	} 
}

module EXEC2(opparts) 
{
	op = opparts[0];
	operand1 = opparts[1];
	operand2 = opparts[2];

//echo();
//echo("OPARTS: ", opparts);
//echo("OP: ", op);
//echo("OPERAND1: ", operand1);
//echo("OPERAND2: ", operand2);

	if (op == OP_UNION)
	{
//		echo("CSG: UNION");
		
		union()
		{
			// There are multiple objects to be unioned
			for(part = operand1)
			{
				EXEC3(part);
			}
		}
	} else if (op == OP_DIFFERENCE)
	{
		difference()
		{
			EXEC3(operand1);

			EXEC3(operand2);
		}
	} else if ((op > PRIM_BASE) && (op < PRIM_MAX))
	{
		place_prim(opparts);
	} 
}

module EXEC3(opparts) 
{
	op = opparts[0];
	operand1 = opparts[1];
	operand2 = opparts[2];

//echo();
//echo("OPARTS: ", opparts);
//echo("OP: ", op);
//echo("OPERAND1: ", operand1);
//echo("OPERAND2: ", operand2);

	if (op == OP_UNION)
	{
//		echo("EXEC: UNION");
		
		union()
		{
			// There are multiple objects to be unioned
			for(part = operand1)
			{
				EXEC4(part);
			}
		}
	} else if (op == OP_DIFFERENCE)
	{
		difference()
		{
			EXEC4(operand1);

			EXEC4(operand2);
		}
	} else if ((op > PRIM_BASE) && (op < PRIM_MAX))
	{
		place_prim(opparts);
	} 
}

module EXEC4(opparts) 
{
	op = opparts[0];
	operand1 = opparts[1];
	operand2 = opparts[2];

//echo();
//echo("OPARTS: ", opparts);
//echo("OP: ", op);
//echo("OPERAND1: ", operand1);
//echo("OPERAND2: ", operand2);

	if (op == OP_UNION)
	{
//		echo("CSG: UNION");
		
		union()
		{
			// There are multiple objects to be unioned
			for(part = operand1)
			{
				EXEC5(part);
			}
		}
	} else if (op == OP_DIFFERENCE)
	{
		difference()
		{
			EXEC5(operand1);

			EXEC5(operand2);
		}
	} else if ((op > PRIM_BASE) && (op < PRIM_MAX))
	{
		place_prim(opparts);
	} 
}

module EXEC5(opparts) 
{
	op = opparts[0];
	operand1 = opparts[1];
	operand2 = opparts[2];

//echo();
//echo("OPARTS: ", opparts);
//echo("OP: ", op);
//echo("OPERAND1: ", operand1);
//echo("OPERAND2: ", operand2);

echo("SORRY - 5th level of recursion is too deep.");
echo("If you want to go further, alter the 'openscad_vm.scad' file.");
}

