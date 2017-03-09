//===================================== 
// This is public Domain Code
// Contributed by: William A Adams
// 14 May 2011
//=====================================

include <bezier.scad>

gPmm =1;
gGranuleStep = 1/gPmm;
gGranuleSize = [1/gPmm, 1/gPmm, 1/gPmm];

//PlaceGranule([0,0,0]);

//=========================================
// Modules
//=========================================

// The position is specified in units of gGranuleStep
module PlaceGranule(pos, granuleColor=[1,1,0], granuleSize=gGranuleSize)
{
	newpos = pos/gPmm;

	color(granuleColor)
	translate(pos/gPmm)
	cube(size=granuleSize);
}

// This routine restricts the placement to be on the XY Plane
// The position is specified in units of gGranuleStep
module PlaceGranuleXY(x,y, granuleColor=[1,1,0], granuleSize=gGranuleSize)
{
	PlaceGranule([x,y,0], granuleColor, granuleSize);
}

module PlaceGranuleLineH(x1,y,  length, colors=[[1,1,0],[1,1,0],[1,1,],[1,1,0]], granuleSize = gGranuleSize)
{
	xStart = x1;
	xEnd = x1+length;
	deltax = length;

	for (x=[xStart:xEnd])
	{
		currentcolor = PointOnBezCubic3D(colors[0], colors[1], colors[2], colors[3], abs(x-xStart)/deltax);
		PlaceGranuleXY(x, y, currentcolor, granuleSize);
	}
}

module PlaceGranuleLine(x1, y1, x2, y2, colors=[[1,1,0],[1,1,0],[1,1,],[1,1,0]], granuleSize = gGranuleSize) 
{
	// Calculate the slope
	m = (y2-y1)/(x2-x1);
	b = y1 - (m*x1);

	deltax = abs(x2-x1);

	for (x=[x1:x2])
	{
		currentcolor = PointOnBezCubic3D(colors[0], colors[1], colors[2], colors[3], abs(x-x1)/deltax);
		PlaceGranuleXY(x, (m*x+b), currentcolor, gGranuleSize*1.2);
	}
}