//===================================== 
// This is public Domain Code
// Contributed by: William A Adams
// 14 May 2011
//=====================================

include <Renderer.scad>
include <tetra_160_120.scad>

// A test image 
rgb_image_array = [255,0,0, 0,255,0, 0,0,255, 255,0,0, 0,255,0, 0,0,255,
255,255,0, 255,255,255, 0,0,0, 255,255,0, 255,255,255, 0,0,0];


//rgb_image = image(6,2,255, rgb_image_array); 
//rgb_image =checker_image; 
rgb_image = tetra_80_60;
//rgb_image = tetra_320_240;

gUSteps = 8;

cp1 = [[0,0,0], [5,-4,0], [10,-4,0], [15,0,0]];
cp2 = [[0,5,1], [5,5,6], [10,5,6], [15,5,1]];
cp3 = [[0,10,1], [5,10,2], [10,10,2], [15,10,1]];
cp4 = [[0,15,0], [5,15,0], [10,15,0], [15,15,0]];

fcp4 = [[0,30,0], [10,40,0], [20,40,0], [30,30,0]];  
fcp3 = [[-10,20,0], [0,30,30], [30,30,30], [40,20,0]];  
fcp2 = [[-10,10,0], [0,0,30], [30,0,30], [40,10,0]];  
fcp1 = [[0,0,0], [10,-10,0], [20,-10,0], [30,0,0]];  

//linear_extrude_bezier([cp1, cp2, cp3, cp4], 
//	colors=[[1,0,0],[1,1,0],[0,1,1],[0,0,1]],
//	steps=gUSteps);


shell_extrude_bezier([cp1, cp2, cp3, cp4], 
	colors=[[1,0,0],[1,1,0],[0,1,1],[0,0,1]],
	steps=gUSteps, 
	thickness=2, 
	showNormals=false,
	texture=checker_image);

//shell_extrude_bezier([fcp1, fcp2, fcp3, fcp4], 
//	colors=[[1,0,0],[1,1,0],[0,1,1],[0,0,1]],
//	steps=gUSteps, thickness=-2, 
//	showControlFrame = true, 
//	showNormals=true,
//	texture=rgb_image);

//linear_extrude_bezier([fcp1, fcp2, fcp3, fcp4], 
//	colors=[[1,0,0],[1,1,0],[0,1,1],[0,0,1]],
//	steps=gUSteps, thickness=-2, 
//	showControlFrame = true, 
//	showNormals=true,
//	texture=rgb_image);
