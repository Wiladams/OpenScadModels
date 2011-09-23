/*
	Metaballs.scad
	Public Domain Code
	Placed By: William A Adams
	4 June 2011

	This code is a rudimentary implementation of the so called 'metaball' technique of soft object rendering.  It uses "granules" to register the isosurface which is the interaction of the various balls.

	Some good reading on metaballs can be found here:
http://www.gamedev.net/page/resources/_//feature/fprogramming/exploring-metaballs-and-isosurfaces-in-2d-r2556

*/

//goldenratio = 1.618;
goldenratio = 1;

cube(size=[1,1,1]);

DrawMetaballs(3, [[15, 15, 5], [30, 15, 5], [20, 40, 5]], 
	area = [100, 100], resolution = [3,3], thickness = 20);

//PlaceSculpture(resolution=[1,1], layerheight=1, numLayers=15);

//=========================================
//		Functions
//=========================================

// metaball - _x, _y, _radius
function  MBInfluence(x, y, mball) = (mball[2] / sqrt((x-mball[0])*(x-mball[0]) + (y-mball[1])*(y-mball[1])));

function Sum2(x,y,mballs) = MBInfluence(x,y,mballs[0])+MBInfluence(x,y,mballs[1]);
function Sum3(x,y,mballs) = MBInfluence(x,y,mballs[0])+MBInfluence(x,y,mballs[1])+MBInfluence(x,y,mballs[2]);

//==========================================
//		Modules
//==========================================

module PlaceSculpture(resolution=[1.5,1.5], layerheight=1, numLayers=5)
{
	for (layer=[0:numLayers])
	{
		translate([0,0,layerheight*layer])
		AnimateMetaBalls( resolution=resolution, thickness=layerheight, $t=layer/numLayers);
	}
}


module AnimateMetaBalls( resolution=[1,1], thickness = 4)
{
	DrawMetaballs(3, 
		ballList = [[15, 15, 5], 
			[15+$t*15, 15+ $t*25, 4], 
			[15+$t*25, 15, 4]], 
		area = [100, 100], 
		resolution = resolution, 
		thickness = thickness);
}

module DrawMetaballs(nBalls, ballList, area, resolution=[1,1], thickness=1)
{	
	xres = resolution[0];
	yres = resolution[1];

	SCREEN_WIDTH = area[0];
	SCREEN_HEIGHT = area[1];

	MIN_THRESHOLD = 0.98;
	MAX_THRESHOLD = 1.02;
	sum = 0;

	// Ideally, we'd do a linear_extrude, but right now, it's
	// way too computationally expensive
	//linear_extrude(height=thickness)
	for (y=[0:SCREEN_HEIGHT*yres])
	{
		for (x=[0:SCREEN_WIDTH*xres])
		{
			if (nBalls == 2)
			{
			assign(sum=Sum2(x/xres, y/yres, ballList))
			{
				if (sum > MIN_THRESHOLD && sum < MAX_THRESHOLD)
				{
					translate([x/xres, y/yres, 0])
					cube([1/xres, 1/yres, thickness]);
				}
			} } else if (nBalls == 3)
			{
				assign(sum=Sum3(x/xres, y/yres, ballList))
				{
					if (sum > MIN_THRESHOLD && sum < MAX_THRESHOLD)
					{
						translate([x/xres, y/yres, 0])
						cube([1/xres, 1/yres, thickness]);
					}
				}
			}
		}
	}
}


