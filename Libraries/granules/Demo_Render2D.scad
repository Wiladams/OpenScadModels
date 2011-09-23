//===================================== 
// This is public Domain Code
// Contributed by: William A Adams
// 14 May 2011
//=====================================

include <Render2D.scad>
include <Renderer.scad>

gPmm = 1;	// How many granules per millimeter

cp1 = [[-25, -30,0], [-10, 20,0], [10,20,0], [25,-30,0]];
cp2 = [[-15, -25,7], [-7, 15,0], [7,15,0], [15,-25,7]];
cp3 = [[-15, -25,15], [-7, 15,0], [7,15,0], [15,-25,15]];
cp4 = [[-25, -30,25], [-10, 20,0], [10,20,0], [25,-30,25]];

//PlaceGranuleLine(1,1,10,10,  [[1,0,0],[1,1,0],[0,1,1],[0,0,1]]);

//line(1,1,10,10); 
////lineHorizontal(10,10,10);
//fillRectangle(10,11, 20, 20, [[1,0,0],[1,1,0],[0,1,1],[0,0,1]]);
//

uvalues = [[0,75],  [-25,-25],  [75,-25],  [50,75]];
vvalues = [[0,75,0],  [-25,-25,25],  [75,-25,32],  [50,75,75]];

//bezier(0,150,  -50,-50,  150,-50,  100,150, 
//	colors=[[1,0,0],[1,1,0],[0,1,1],[0,0,1]], 
//	granuleSize=gGranuleSize*1.3, steps=10, zsteps=10);

//bezierSurface(uvalues, vvalues, 
//	colors=[[1,0,0],[1,1,0],[0,1,1],[0,0,1]],
//	steps=25, zsteps=25);

//bezierMeshPoints(uvalues, vvalues, 
//	colors=[[1,0,0],[1,1,0],[0,1,1],[0,0,1]],
//	usteps=25, vsteps=25);

bezierMesh(uvalues, vvalues, 
	colors=[[1,0,0],[1,1,0],[0,1,1],[0,0,1]],
	usteps=5, vsteps=5);

//bezierMeshSurface(cp1, cp2, cp3, cp4, 
//	colors=[[1,0,0],[1,1,0],[0,1,1],[0,0,1]],
//	usteps=750, zsteps=50);

//bezierMeshSolid(uvalues, vvalues, 
//	colors=[[1,0,0],[1,1,0],[0,1,1],[0,0,1]],
//	steps=100, zsteps=100);
