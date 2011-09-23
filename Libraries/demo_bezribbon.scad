//=====================================
// This is public Domain Code
// Contributed by: William A Adams
//=====================================

include <Renderer.scad>

joinfactor = 0.125;

gDemoSteps = 300;
gDemoHeight =14;

//cuphandle();
hollowheart();


//======================================
// Demos
//======================================
c1 = [[0,0,100],[100,100,50],[0,150,50],[-50,-100,100]];
c2 = [[5,0,0],[105,105,0],[0,155,0],[-55,-100,0]];

//linear_extrude_bez_ribbon(c1, c2,
//	steps = 24,
//	height = 10,
//	colors=[[0,0,1],[0.3,1,1],[0.3,1,1],[0,0,1]]
//	);

module cuphandle()
{
	h1 = [[0,0,0],  [30,30,0], [20,90,0], [0,80,0]];
	h2 = [[0,10,0],[20,20,0], [10,80,0], [0,70,0]];
	
	linear_extrude_bez_ribbon(h1, h2,
		steps = 24,
		height = 10,
		colors=[[0,0,1],[0.3,1,1],[0.3,1,1],[0,0,1]]
		);
}


module hollowheart()
{
	h1 = [[0,0,0],  [70,30,0], [20,90,0], [0,40,0]];
	h2 = [[0,10,0],[60,20,0], [10,80,0], [0,30,0]];
	
	rotate_bez_ribbon(h1, h2,
		steps = 24,
		height = 10,
		colors=[[0,0,1],[0.3,1,1],[0.3,1,1],[0,0,1]]
		);
}