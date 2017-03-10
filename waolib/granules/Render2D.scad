//===================================== 
// This is public Domain Code
// Contributed by: William A Adams
// 14 May 2011
//=====================================

include <maths.scad>
include <granules.scad>

goldenratio = 1.618;

//gPmm = 1;
//gGranuleStep = 1/gPmm;
//gGranuleSize = [1/gPmm, 1/gPmm, 1/gPmm];

//line(1,1,10,10);
//lineHorizontal(10,10,10);
//fillRectangle(10,11, 20, 20, [[1,0,0],[1,1,0],[0,1,1],[0,0,1]]);

//=========================================
// Modules
//=========================================

module point(x, y, granuleColor=[1,1,0], granuleSize=gGranuleSize)
{
	x1 = x*gPmm;
	y1 = y*gPmm;

	PlaceGranule([x1, y1, 0], granuleColor, granuleSize);
}

// Horizontal Line
module lineHorizontal(x1, y1, length,  colors=[[1,1,0],[1,1,0],[1,1,],[1,1,0]], granuleSize = gGranuleSize)
{
	xStart = x1*gPmm;
	y11 = y1*gPmm;
	length1 = length*gPmm;
	xEnd = x11+length1;

	for (x=[xStart:xEnd])
	{
		assign(currentcolor = PointOnBezCubic3D(colors[0], colors[1], colors[2], colors[3], abs(x-x11)/deltax))
		PlaceGranuleXY(x, y11, currentcolor, gGranuleSize*1.2);
	}
}

// Here is a 2D line drawing algorithm.  It uses the line equation directly
// because OpenScad doesn't really have state that can be changed
// iteratively
module line(x1, y1, x2, y2, colors=[[1,1,0],[1,1,0],[1,1,],[1,1,0]], granuleSize = gGranuleSize)
{
	x11 = x1*gPmm;
	y11 = y1*gPmm;

	x21 = x2*gPmm;
	y21 = y2*gPmm;
 
	// Calculate the slope
	m = (y2-y1)/(x2-x1);
	b = y11 - (m*x11);

	deltax = abs(x21-x11);

	for (x=[x11:x21])
	{
		assign(currentcolor = PointOnBezCubic3D(colors[0], colors[1], colors[2], colors[3], abs(x-x11)/deltax))
		PlaceGranuleXY(x, (m*x+b), currentcolor, gGranuleSize*1.2);
	}
}

module fillRectangle(left,top,right,bottom, colors=[[1,1,0],[1,1,0],[1,1,],[1,1,0]], granuleSize = gGranuleSize)
{
	xStart = left*gPmm;
	xEnd = right*gPmm;
	deltax = abs(xEnd-xStart);

	yStart = bottom*gPmm;
	yEnd = top*gPmm;

	for (row=[yStart:yEnd])
	{
		PlaceGranuleLineH(xStart, row, deltax, colors, granuleSize);
	}
}





module bezier(x1,y1, x2,y2, x3, y3, x4,y4, colors=[[1,1,0],[1,1,0],[1,1,],[1,1,0]], granuleSize = gGranuleSize, steps=100)
{
	// Express the control points in terms of granule steps
	c0 = [x1*gPmm, y1*gPmm];
	c1 = [x2*gPmm, y2*gPmm];
	c2 = [x3*gPmm, y3*gPmm];
	c3 = [x4*gPmm, y4*gPmm];

	for(step = [0:steps-1])
	{
		assign(currentColor = (PointOnBezCubic3D(colors[0], colors[1], colors[2], colors[3], step/steps)))
		assign(pt1 = PointOnBezCubic2D(c0, c1, c2,c3, step/steps))
		assign(pt2 = PointOnBezCubic2D(c0, c1, c2,c3, step+1/steps))
		{
			//echo(pt1, pt2);
			 PlaceGranule([pt1[0], pt1[1], 0], currentColor, granuleSize);
			//PlaceGranuleLine(pt1[0], pt1[1], pt2[0], pt2[1]);
		}
	}
}

module bezierCurve(c1, colors=[[1,1,0],[1,1,0],[1,1,],[1,1,0]], 
	granuleSize = gGranuleSize, usteps=100)
{
	gp1 = c1*gPmm;

	for(ustep = [0:usteps])
	{
		
		assign(currentColor = (PointOnBezCubic3D(colors[0], colors[1], colors[2], colors[3], ustep/usteps)))
		assign(pt1 = PointOnBezCubic3D(gp1[0],gp1[1], gp1[2], gp1[3], ustep/usteps))
		//assign(pt2 = PointOnBezCubic3D(gp1[0],gp1[1], gp1[2], gp1[3], ustep+1/usteps))
		{
			 PlaceGranule([pt1[0], pt1[1], pt1[2]], currentColor, granuleSize);
			//PlaceGranuleLine(pt1[0], pt1[1], pt2[0], pt2[1]);
		}
	}
	
}

module bezierSurface(cp1, cp2, colors=[[1,1,0],[1,1,0],[1,1,],[1,1,0]], granuleSize = gGranuleSize, steps=100, zsteps=100)
{
	// Express the control points in terms of granule steps
	assign(gp1=cp1*gPmm)
	assign(gp2=cp2*gPmm)
	for (zstep = [0:zsteps])
	{
		assign(offset = (PointOnBezCubic3D(gp2[0], gp2[1], gp2[2], gp2[3], zstep/zsteps)))
		translate(offset)
		for(step = [0:steps-1])
		{
			assign(currentColor = (PointOnBezCubic3D(colors[0], colors[1], colors[2], colors[3], step/steps)))
			assign(pt1 = PointOnBezCubic2D(gp1[0], gp1[1], gp1[2],gp1[3], step/steps))
			assign(pt2 = PointOnBezCubic2D(gp1[0], gp1[1], gp1[2],gp1[3], step+1/steps))
			{
				//echo(pt1, pt2);
				 PlaceGranule([pt1[0], pt1[1], 0], currentColor, granuleSize);
				//PlaceGranuleLine(pt1[0], pt1[1], pt2[0], pt2[1]);
			}
		}
	}
}

module bezierMeshSurface(lcp1, lcp2, lcp3, lcp4,
	colors=[[1,1,0],[1,1,0],[1,1,],[1,1,0]], 
	granuleSize = gGranuleSize, usteps=100, zsteps=100)
{
	// Express the control points in terms of granule steps
	assign(gp1=lcp1*gPmm)
	assign(gp2=lcp2*gPmm)
	assign(gp3=lcp3*gPmm)
	assign(gp4=lcp4*gPmm)
	for (ustep = [0:usteps])
	{
		assign(ufrac = ustep/usteps)
		assign(zgp1 =  PointOnBezCubic3D(gp1[0],gp1[1], gp1[2], gp1[3], ufrac))
		assign(zgp2 =  PointOnBezCubic3D(gp2[0],gp2[1], gp2[2], gp2[3], ufrac))
		assign(zgp3 =  PointOnBezCubic3D(gp3[0],gp3[1], gp3[2], gp3[3], ufrac))
		assign(zgp4 =  PointOnBezCubic3D(gp4[0],gp4[1], gp4[2], gp4[3], ufrac))

		bezierCurve([zgp1, zgp2, zgp3, zgp4], colors, gGranuleSize, zsteps);
	}
}
