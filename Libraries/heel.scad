//===================================== 
// High heels by Proton is licensed under the Attribution - Share Alike - Creative Commons license.
// AKA http://www.thingiverse.com/thing:8937
//=====================================

include <Renderer.scad>

steps=4;

//heel height
hh=60;

//high heel
fcp4 = [[0,20,hh],[30,20,hh+10], [30,-20,hh+10], [0,-20,hh]]; 
fcp3 = [[0,20,50], [30,20,60], [30,-20,60], [0,-20,50]]; 
fcp2 = [[0,0,40], [10,1,40], [10,-1,40], [0,0,40]]; 
fcp1 = [[0,0,0], [10,1,0], [10,-1,0], [0,0,0]]; 


//shell_extrude_bezier([fcp1,fcp2,fcp3,fcp4], 
//	colors=[[1,0,0],[1,1,0],[0,1,1],[0,0,1]],
//	steps=steps, 
//	thickness=-4,
//	showNormals = true);

//sole
bcp4 = [[0,20,hh],[30,20,hh+10], [30,-20,hh+10], [0,-20,hh]]; 
bcp3 = [[-30,15,hh-10], [-10,10,hh-15], [-10,-10,hh-5], [-30,-19,hh-10]]; 
bcp2 = [[-100,50,0], [-40,10,0], [-110,0,0], [-100,-20,0]]; 
bcp1 = [[-150,50,0], [-180,40,0], [-170,10,0], [-150,-25,0]];

solemesh=[bcp1,bcp2,bcp3,bcp4];

//shell_extrude_bezier(solemesh, 
//	colors=[[1,0,0],[1,1,0],[0,1,1],[0,0,1]],
//	steps=steps, 
//	thickness=4,
//	showControlFrame=false,
//	showNormals=false);

//heel
hcp4 = [[0,20,hh],[30,20,hh+10], [30,-20,hh+10], [0,-20,hh]]; 
hcp3 = [[0,20,hh+10], [30,20,hh+15], [30,-20,hh+15], [0,-20,hh+10]]; 
hcp2 = [[5,15,hh+20], [15,10,hh+40], [15,-10,hh+40], [2,-15,80]]; 
hcp1 = [[5,15,hh+30], [15,10,2*hh], [15,-10,2*hh], [5,-15,hh+30]];

heelmesh=[hcp1,hcp2,hcp3,hcp4];
//shell_extrude_bezier(heelmesh, 
//	colors=[[1,0,0],[1,1,0],[0,1,1],[0,0,1]],
//	steps=steps, 
//	thickness=4,
//	showControlFrame=false,
//	showNormals=false);


//nose
ncp4 = [[0,20,hh],[-190,100,25], [-170,-60,20], [0,-20,hh]]; 
ncp3 = [[-30,15,50], [-200,120,7], [-190,-100,7], [-30,-19,50]]; 
ncp2 = [[-100,50,0], [-250,120,20], [-200,-100,20], [-100,-20,0]]; 
ncp1 = [[-150,50,0], [-180,40,0], [-170,10,0], [-150,-25,0]];

nosemesh=[ncp1,ncp2,ncp3,ncp4];
shell_extrude_bezier(nosemesh, 
	colors=[[1,0,0],[1,1,0],[0,1,1],[0,0,1]],
	steps=steps, 
	thickness=4,
	showControlFrame=false,
	showNormals=false);

