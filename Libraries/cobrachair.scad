include <Renderer.scad>

cobrachair();

module cobrachair()
{
	cp1= [[-15, 20, 0], 
		[-25,-10,0], 
		[25,-10,0], 
		[15,20,0]]; 

	cp2= [[-10, 60, 30], 
		[-8, 55,30], 
		[8,55,30], 
		[10,60,30]]; 

	cp3= [[-15, -30, 0], 
		[-2.5, -25,-10], 
		[2.5,-25,-10], 
		[15,-30,0]]; 

	cp4= [[-25, 0, 60], 
		[-2.5, 0,65], 
		[2.5,0,65], 
		[25,0,60]]; 


//	linear_extrude_bezier([cp1, cp2, cp3, cp4], 
//		colors=[[1,0,0],[1,1,0],[0,1,1],[0,0,1]],
//		steps=8, 
//		thickness = 3, 
//		showNormals=true,
//		showControlFrame=true);

	shell_extrude_bezier([cp1, cp2, cp3, cp4], 
		colors=[[1,0,0],[1,1,0],[0,1,1],[0,0,1]],
		steps=8, 
		thickness = -3, 
		showNormals=false,
		showControlFrame=false);
}
