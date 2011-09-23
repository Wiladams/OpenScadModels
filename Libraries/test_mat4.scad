include <maths.scad>

MatrixMaths();
DemoTransforms();
RealTrans();

module MatrixMaths()
{
	// Here's a vector being multiplied by a scalar
	T = vec4_mults([1/8, 1/4, 1/2, 1], 1/2);
	
	// Here's a nice 4x4 matrix, in row order
	N = [
		[-1, 7, 0, 1], 
		[1, -11, 0, 1], 
		[4, 0, 0, 1], 
		[4, 6, 0, 1]
		];
	
	// Here's another nice 4x4 in row order
	G = [
		[1, 0, 0, 0], 
		[0, 1/2, sqrt(3)/2, 0], 
		[0,0,0,0], 
		[0,0,0,1]
		];
	
	
	//
	echo("T: ", T);
	echo("N: ", N);
	
	// The result of multiplying the vector by the matrix
	// The end result being a 1x4 matrix (1 row, 4 columns)
	echo("T*N: ", vec4_mult_mat4(T, N));
	
	// A function that shows compound matrix operations
	function qcalc() = vec4_mult_mat4(vec4_mult_mat4(T, N), G);
	
	echo(qcalc());
}

module DemoTransforms()
{
	// Just some simple transforms on a point
	P = [3, 2, 1, 1];
	T2 = [-1, -1, -1];
	TM = transform_translate(T2);
	RX  = transform_rotx(30);
	RY = transform_roty(45);
	
	echo("P: ", P);
	echo("TM: ", TM);
	echo("RX: ", RX);
	echo("RY: ", RY);
	
	// Combine the two rotations
	RXY = mat4_mult_mat4(RX, RY);
	echo("RXY: ", RXY);
	
	// Combine the two rotations and the translation
	TRXY = mat4_mult_mat4(TM, RXY);
	echo("TRXY: ", TRXY);
	
	// Apply the combined rotations and translation to transform the point
	TPT = vec4_mult_mat4(P, TRXY);
	echo("TPT: ", TPT);
}

// Do a simple translation and apply it to the 
// OpenScad world
module RealTrans()
{
	T3 = transform_translate([5, 15, 7]);

	// Apply one of the transforms to the OpenScad 
	// world.  
	// You must do the transpose because apparently 
	// the OpenScad matrix is in column order, rather 
	// than row order I'm using
	multmatrix(m=mat4_transpose(T3))
	cube(size=[10,10,10]);
}