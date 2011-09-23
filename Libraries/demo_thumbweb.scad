//===================================== 
// This is public Domain Code
// Contributed by: William A Adams
// 14 May 2011
//=====================================

include <Renderer.scad>


cp1=		[[-5, 65, 0], 
		[-18, 50,0], 
		[0,0,0], 
		[18,45,0]]; 

cp2=		[[5, 65, 7], 
		[-18, 20,7], 
		[0,20,7], 
		[12,45,7]]; 

cp3=		[[5, 65, 14], 
		[-18, 20,14], 
		[0,20,14], 
		[12,45,14]]; 

cp4=		[[-5, 65, 22], 
		[-18, 50,22], 
		[0,0,22], 
		[18,45,22]]; 


//linear_extrude_bezier([cp1, cp2, cp3, cp4], 
//	colors=[[1,0,0],[1,1,0],[0,1,1],[0,0,1]],
//	steps=8);

shell_extrude_bezier([cp1, cp2, cp3, cp4], 
	colors=[[1,0,0],[1,1,0],[0,1,1],[0,0,1]],
	steps=12, thickness = -3, 
	showNormals=false);