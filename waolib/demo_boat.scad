include <Renderer.scad>

goldenratio = 1.618;

	width = 100;
	midwidth = width/2;
	depth = 100;
	height = 100;

bcolors = [[1,1,0],[1,1,0],[1,1,0],[1,1,0]];

//bow(4,2);
//midships(4,2);
//stern(4,2);
boat(8,4);

module bow(steps=8, thickness=2, right=true)
{
	rcp4 = [[0,depth,midwidth], 	[1/3*height,depth,midwidth*2/3*goldenratio], 	[2/3*height,depth,midwidth*1/3/goldenratio], 		[height,depth,0]]; 
	rcp3 = [[0,depth*2/3,midwidth], 	[1/3*height,depth*2/3,midwidth*2/3], 	[2/3*height,depth*2/3,midwidth*1/3/goldenratio/goldenratio], [height,depth*2/3,0]]; 
	rcp2 = [[0,depth*1/3,midwidth], 	[1/3*height,depth*1/3,midwidth*2/3], 	[2/3*height,depth*1/3,midwidth*1/3/goldenratio/goldenratio/goldenratio], [height,depth*1/3,0]]; 
	rcp1 = [[0,0,0], 			[1/3*height,0,0], 			[2/3*height,0,0], 			[height,0,0]]; 


	lcp4 = [[0,depth,midwidth], 	[-1/3*height,depth,midwidth*2/3*goldenratio], 	[-2/3*height,depth,midwidth*1/3/goldenratio], 		[-height,depth,0]]; 
	lcp3 = [[0,depth*2/3,midwidth], 	[-1/3*height,depth*2/3,midwidth*2/3], 	[-2/3*height,depth*2/3,midwidth*1/3/goldenratio/goldenratio], [-height,depth*2/3,0]]; 
	lcp2 = [[0,depth*1/3,midwidth], 	[-1/3*height,depth*1/3,midwidth*2/3], 	[-2/3*height,depth*1/3,midwidth*1/3/goldenratio/goldenratio/goldenratio], [-height,depth*1/3,0]]; 
	lcp1 = [[0,0,0], 			[-1/3*height,0,0], 		[-2/3*height,0,0], 		[-height,0,0]]; 


	union()
	{
//		linear_extrude_bezier([rcp1,rcp2,rcp3,rcp4], 
//			colors=bcolors,
//			steps=steps, thickness=thickness, showControlFrame=true);

		shell_extrude_bezier([rcp1,rcp2,rcp3,rcp4], 
			colors=bcolors,
			steps=steps, 
			thickness=thickness, 
			showControlFrame=false);

		rotate([0, -180, 0])
		{
			shell_extrude_bezier([lcp1,lcp2,lcp3,lcp4], 
				colors=bcolors,
				steps=steps, thickness=thickness);
		}
	}
}

module midships(steps=8, thickness=2)
{

	rcp4 = [[0,depth,midwidth], 	[1/3*height,depth,midwidth*2/3*goldenratio], 	[2/3*height,depth,midwidth*1/3/goldenratio], 		[height,depth,0]]; 
	rcp3 = [[0,depth*2/3,midwidth], 	[1/3*height,depth*2/3,midwidth*2/3*goldenratio], 	[2/3*height,depth*2/3,midwidth*1/3/goldenratio], [height,depth*2/3,0]]; 
	rcp2 = [[0,depth*1/3,midwidth], 	[1/3*height,depth*1/3,midwidth*2/3*goldenratio], 	[2/3*height,depth*1/3,midwidth*1/3/goldenratio], [height,depth*1/3,0]]; 
	rcp1 = [[0,0,midwidth], 		[1/3*height,0,midwidth*2/3*goldenratio], 		[2/3*height,0,midwidth*1/3/goldenratio], 			[height,0,0]]; 

	lcp4 = [[0,depth,midwidth], 	[-1/3*height,depth,midwidth*2/3*goldenratio], 	[-2/3*height,depth,midwidth*1/3/goldenratio], 		[-height,depth,0]]; 
	lcp3 = [[0,depth*2/3,midwidth], 	[-1/3*height,depth*2/3,midwidth*2/3*goldenratio], 	[-2/3*height,depth*2/3,midwidth*1/3/goldenratio], [-height,depth*2/3,0]]; 
	lcp2 = [[0,depth*1/3,midwidth], 	[-1/3*height,depth*1/3,midwidth*2/3*goldenratio], 	[-2/3*height,depth*1/3,midwidth*1/3/goldenratio], [-height,depth*1/3,0]]; 
	lcp1 = [[0,0,midwidth], 		[-1/3*height,0,midwidth*2/3*goldenratio], 		[-2/3*height,0,midwidth*1/3/goldenratio], 			[-height,0,0]]; 


	shell_extrude_bezier([rcp1,rcp2,rcp3,rcp4], 
		colors=bcolors,
		steps=steps, thickness=thickness);

	rotate([0, -180, 0])
	{
		shell_extrude_bezier([lcp1,lcp2,lcp3,lcp4], 
			colors=bcolors,
			steps=steps, thickness=thickness);
	}
}

module stern(steps=8, thickness=2)
{

	rcp4 = [[0,depth,0], 	[1/3*height,depth,0], 	[2/3*height,depth,0], 		[2/3*height,2/3*depth, 0]]; 
	rcp3 = [[0,depth*2/3,midwidth], 	[1/3*height,depth*2/3,midwidth*2/3*goldenratio], 	[2/3*height,depth*2/3,midwidth*1/3/goldenratio], [2/3*height,depth*2/3,0]]; 
	rcp2 = [[0,depth*1/3,midwidth], 	[1/3*height,depth*1/3,midwidth*2/3*goldenratio], 	[2/3*height,depth*1/3,midwidth*1/3/goldenratio], [height,depth*1/3,0]]; 
	rcp1 = [[0,0,midwidth], 		[1/3*height,0,midwidth*2/3*goldenratio], 		[2/3*height,0,midwidth*1/3/goldenratio], 			[height,0,0]]; 

	lcp4 = [[0,depth,0], 	[-1/3*height,depth,0], 	[-2/3*height,depth,0], 		[-2/3*height,2/3*depth, 0]]; 
	lcp3 = [[0,depth*2/3,midwidth], 	[-1/3*height,depth*2/3,midwidth*2/3*goldenratio], 	[-2/3*height,depth*2/3,midwidth*1/3/goldenratio], [-2/3*height,depth*2/3,0]]; 
	lcp2 = [[0,depth*1/3,midwidth], 	[-1/3*height,depth*1/3,midwidth*2/3*goldenratio], 	[-2/3*height,depth*1/3,midwidth*1/3/goldenratio], [-height,depth*1/3,0]]; 
	lcp1 = [[0,0,midwidth], 		[-1/3*height,0,midwidth*2/3*goldenratio], 		[-2/3*height,0,midwidth*1/3/goldenratio], 			[-height,0,0]]; 


	shell_extrude_bezier([rcp1,rcp2,rcp3,rcp4], 
		colors=bcolors,
		steps=steps, thickness=thickness);

	rotate([0, -180, 0])
	{
		shell_extrude_bezier([lcp1,lcp2,lcp3,lcp4], 
			colors=bcolors,
			steps=steps, thickness=thickness);
	}
}

module boat(steps=8, thickness=2)
{
	rotate([0,90,0])
	union()
	{
		bow(steps, thickness);

		translate([0, 1*depth, 0])
		midships(steps,thickness);
		
//		translate([0, 2*depth, 0])
//		midships(steps, thickness);
		
		translate([0, 2*depth, 0])
		//rotate([0, 0, 180])
		stern(steps, thickness);
	}
}