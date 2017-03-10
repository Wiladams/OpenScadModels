//===================================== 
// This is public Domain Code
// Contributed by: William A Adams
// 14 May 2011
//=====================================

include <Renderer.scad>


// These coordinates originate from the OpenGl bezmesh
// Sample, originally done by Mark Kilgard

cp1=		[[-1.5, -1.5, 4.0], 
		[-0.5, -1.5, 2.0], 
		[0.5, -1.5, -1.0], 
		[1.5, -1.5, 2.0]]; 

cp2 = 	[[-1.5, -0.5, 1.0], 
		[-0.5, -0.5, 3.0], 
		[0.5, -0.5, 0.0], 
		[1.5, -0.5, -1.0]]; 

cp3=		[[-1.5, 0.5, 4.0], 
		[-0.5, 0.5, 0.0], 
		[0.5, 0.5, 3.0], 
		[1.5, 0.5, 4.0]];

cp4=		[[-1.5, 1.5, -2.0], 
		[-0.5, 1.5, -2.0], 
		[0.5, 1.5, 0.0], 
		[1.5, 1.5, -1.0]];


//linear_extrude_bezier([cp1, cp2, cp3, cp4], 
//	colors=[[1,0,0],[1,1,0],[0,1,1],[0,0,1]],
//	steps=16);

scale([20,20,20])
shell_extrude_bezier([cp1, cp2, cp3, cp4], 
	colors=[[1,0,0],[1,1,0],[0,1,1],[0,0,1]],
	steps=12, thickness = 0.25, showNormals=false);
