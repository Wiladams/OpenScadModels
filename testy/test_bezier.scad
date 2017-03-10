//=====================================
// This is public Domain Code
// Contributed by: William A Adams
// 11 May 2011
//=====================================
include <../waolib/maths.scad>
include <../waolib/Renderer.scad>


//=======================================
//
// 				Tests
//
//=======================================

//gcp1 = [[0,0,0], [1,-1,0], [2,-1,0], [2.5,0.5,0]]; 
//gcp2 = [[0,1,1], [1,1,2], [2,1,2], [3,1,1]]; 
//gcp3 = [[0,2,1], [1,2,2], [2,2,2], [3,2,1]]; 
//gcp4 = [[0,3,0], [1,4,0], [2,4,0], [3,3,0]]; 

//gcp4 = [[0,3,0], [1,4,0], [2,4,0], [3,3,0]]; 
//gcp3 = [[0,2,1], [1,2,2], [1.5,2.5,1.5], [2,2,0.5]]; 
//gcp2 = [[0,1,1], [1,1,2], [1.5,0.5,1.5], [2,1,0.5]]; 
//gcp1 = [[0,0,0], [1,-1,0], [2,-1,0], [3,0,0]]; 

gcp4 = [[0,30,0], [10,40,0], [20,40,0], [30,30,0]]; 
gcp3 = [[5,20,10], [10,20,20], [15,25,15], [20,20,5]]; 
gcp2 = [[5,10,10], [10,10,20], [15,5,15], [20,10,5]]; 
gcp1 = [[0,0,0], [10,-10,0], [20,-10,0], [30,0,0]]; 

//DisplayCubicCurve(
//	cubic_bezier_M(), 
//	cps = [[0, 1, 0],[2,3,0], [4,1,0],[5,2,0]], 
//	steps=20);

//DisplayBezCurvePoints(gcp1, steps=18, $fn=12);
//DisplayBezCurvePoints(gcp2, steps=36, $fn=12);
//DisplayBezCurvePoints(gcp3, steps=54, $fn=12);
//DisplayBezCurve(gcp4, steps=72, $fn=12);

//DisplayBezMeshPoints([gcp1, gcp2, gcp3, gcp4], steps=36, $fn=12);


//DisplayBezControlFrame([gcp1, gcp2, gcp3, gcp4], $fn=3);
//DisplayBezCurveFrame([gcp1, gcp2, gcp3, gcp4], steps=24, $fn=6);

//DisplayBezControlFrame([gcp1, gcp2, gcp3, gcp4], $fn=3);
DisplayBezSurface([gcp1, gcp2, gcp3, gcp4], steps=16, thickness=3);


//=======================================
//
// 				Functions
//
//=======================================

/*
function sNorm(tri) = VUNIT(VCROSS(tri[2]-tri[1],  tri[0]-tri[1]));

function triNormals(tri) = [sNorm([tri[2],tri[0],tri[1]]), 
				sNorm([tri[0],tri[1],tri[2]]), 
				sNorm([tri[1],tri[2],tri[0]])];
*/

function quadtrans(quad, trans) = [
	VSUM(quad[0], trans), 
	VSUM(quad[1], trans),
	VSUM(quad[2], trans),
	VSUM(quad[3], trans)];

//=========================================
//		Modules
//=========================================


module DisplayQuadShard(quad, thickness=1) 
{
	lowquad = quadtrans(quad, [0,0,-thickness]);
//echo("QUAD: ", quad);
//echo("LOW QUAD: ", lowquad);

	DisplayTriShard([[quad[0],quad[1],quad[2]],
		[lowquad[0], lowquad[1], lowquad[2]]]);

	DisplayTriShard([[quad[0],quad[2],quad[3]],
		[lowquad[0], lowquad[2], lowquad[3]]]);
}


module DisplayBezControlPoints(cps)
{
	side = 0.125;

	for(pt = cps)
	{
		translate(pt)
		color([0,0,1])
		sphere(r=side);
	}
}

module DisplayBezCurvePoints(cps, steps=3)
{
	side = 0.25*(3/steps);

	for (astep=[0:steps])
	{
		pt = berp(cps, astep/steps);
		{
			translate(pt)
			//cube(size=[side, side, side]);
			sphere(r=side);
		}
	}
}


module DisplayBezCurve(cps, steps=6)
{
	DisplayBezControlPoints(cps);
	DisplayBezCurvePoints(cps, steps);
}

module DisplayBezMeshPoints(mesh, steps=6)
{
	side = 1.25*(6/steps);
	DisplayBezControlPoints(mesh[0]);
	DisplayBezControlPoints(mesh[1]);
	DisplayBezControlPoints(mesh[2]);
	DisplayBezControlPoints(mesh[3]);

	for (ustep = [0:steps]) 
	{
		for(vstep=[0:steps])
		{
			vpt = berpm(mesh, [ustep/steps, vstep/steps]);
			translate(vpt)
			sphere(r=side);
		}
	}
}

module DisplayBezControlFrame(mesh, radius=0.125)
{
	for (row=[0:2])
		for (column=[0:2])
		{
			color([0,1,1])
			DisplayQuadFrame(GetControlQuad(mesh, [row,column]), radius);
		}
}

module DisplayBezCurveFrame(mesh, 
	colors=[[1,1,0],[1,1,0],[1,1,0],[1,1,0]], 
	steps=4)
{
	for (ustep = [0:steps-1])
	{
		for (vstep=[0:steps-1])
		{
			ufrac1 = ustep/steps;
			ufrac2 = (ustep+1)/steps;
			vfrac1=vstep/steps;
			vfrac2=(vstep+1)/steps;
			quad = GetCurveQuad(mesh, [ufrac1,vfrac1], [ufrac2,vfrac2]);
			
			DisplayQuadFrame(quad, 36);
			
		}
	}
}

module DisplayBezSurface(mesh, 
	colors=[[1,0,0],[1,1,0],[0,1,1],[0,0,1]], 
	steps=4, thickness=1)
{
	for (ustep = [0:steps-1])
	{
		for (vstep=[0:steps-1])
		{
			ufrac1 = ustep/steps;
			ufrac2 = (ustep+1)/steps;
			vfrac1=vstep/steps;
			vfrac2=(vstep+1)/steps;
			quad = GetCurveQuad(mesh, [ufrac1,vfrac1], [ufrac2,vfrac2]);
			{
                acolor = berp(colors,vfrac1);
//				echo("COLOR: ", acolor, vfrac2);
				color([acolor[0], acolor[1], acolor[2], vfrac2])
				DisplayQuadShard(quad, thickness=thickness);
				
			}
		}
	}
}

//=================================================== 
// Bezier
//===================================================

// Calculate a point on a Bezier surface of revolution
// The 'u' is the parameter along the curve
// angle - sweep along the circle
function param_bezier(u, curve, angle) = [ 
	berp(curve, u)[0],
	berp(curve, u)[1]*cos(angle),
	berp(curve, u)[1]*sin(angle)];

module surface_rotation_bezier(curve, anglesteps=6, linearsteps=10)
{
stepangle = 360/anglesteps;

for (lstep = [0:linearsteps-1])
{
assign(u1 = lstep/linearsteps)
assign(u2 = (lstep+1)/linearsteps)
for (astep=[0:anglesteps-1])
{
// Calculate 4 points so we can display a quad
assign(p0 = param_bezier(u1, curve, astep * stepangle))
assign(p1 = param_bezier(u1, curve, (astep+1) * stepangle))

assign(p2 = param_bezier(u2, curve, astep * stepangle))
assign(p3 = param_bezier(u2, curve, (astep+1) * stepangle))
{
//DisplayQuadFrame([p0, p1, p3, p2]);
PlaceQuad([p0, p1, p3, p2]);
}
}
}
}