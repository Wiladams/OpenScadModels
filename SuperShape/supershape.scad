//
// License: This code is placed in the public domain
// By: William A Adams
// 21st Oct 2011
//
// You can study the supershape by looking at the following by 
// Paul Bourke
// http://paulbourke.net/geometry/supershape3d/
//

include <LineRenderer.scad>

pi = 180;	// 3.14159;

//=========================================
//	Procedural Texture
//=========================================
function mod(x,y) = x-(y*floor(x/y));
function isodd(x) = mod(x,2) == 1;
function iseven(x) = !isodd(x);

function map_array(range, u) = (u*range) >= range ? range-1 : floor(u*range); 

function _procedural_texture(column, row) = 
iseven(column+row) ? [0,0,0] : [1,1,1];

// Fixed grid checkerboard
function procedural_texture(u,v, columns=8, rows=8) =
_procedural_texture(map_array(columns,u), map_array(rows,v));


//=========================================
// SuperFormula evaluation
//=========================================
// Calculate length of a vector
function vlength(v) = sqrt(v[0]*v[0]+v[1]*v[1]+v[2]*v[2]); 

// Turn polar back to cartesian
function pocart(r0,r1, t1, p1) = [r0*cos(t1)*r1*cos(p1),r0*sin(t1)*r1*cos(p1),r1*sin(p1)];

// Create an instance of the supershape data structure
function supershape(m=1,n1=1,n2=1, n3=1, a=1, b=1) = [m,n1,n2,n3,a,b];

function SSCos(shape, phi) = pow( abs(cos(shape[0]*phi/4) / shape[4]), shape[2]);
function SSSin(shape, phi) = pow(abs(sin(shape[0]*phi/4) / shape[5]), shape[3]);
function SSR(shape, phi) = pow((SSCos(shape,phi) + SSSin(shape,phi)), 1/shape[1]);

function _EvalSuperShape2D3(phi, r) = 
	abs(r) == 0 ? [0,0,0] : [1/r * cos(phi), 1/r*sin(phi),0];

function _EvalSuperShape2D2(phi, n1, t1, t2) =
	_EvalSuperShape2D3(phi, t1, t2, r=pow(t1+t2, 1/n1));


function EvalSuperShape2D(shape, phi) = _EvalSuperShape2D2(phi, shape[1], t1=SSCos(shape,phi), t2=SSSin(shape,phi));


/*
	Module: RenderSuperShape2D

	Description:  
	This routine will render a superformula object in 2D.  
*/
//module RenderSuperShape2D(shape=supershape(0, 1, 1, 1, 1, 1),
//	phisteps = 36,
//	wireframe=true,
//	points=false,
//	pointcolor=[0,0,0],
//	wirecolor=[1,1,1])
//{
//	radius = 0.065/4;
//	phiangle = 360/phisteps;
//
//
//	// Now we've got some powers and steps in more
//	// normal ranges, so iterate and rotate
//	for (j=[0:phisteps-1])
//	{
//		assign(phi1 = j*phiangle)
//		assign(phi2 = (j+1)*phiangle)
//
//		assign(v1 = EvalSuperShape2D(shape, phi1))
//		assign(v2 = EvalSuperShape2D(shape, phi2))
//		{
//			if (points)
//			{
//				color(pointcolor)
//				translate(v1)
//				sphere(r=radius);
//			}
//
//			if (wireframe)
//			{
//				color(wirecolor)
//				PlaceLine([v1, v2], radius=radius);
//			}
//		}
//	}
//}

/*
	Module: RenderSuperShape2D

	Description:  
	This routine will render a superformula object in 2D.  
*/
module RenderSuperShape2D(shape=supershape(0, 1, 1, 1, 1, 1),
	phisteps = 36,
	points=false,
	wireframe=true,
	faces = false,
	pointcolor=[0,0,0],
	wirecolor=[1,1,1],
	thickness=1)
{
	radius = 0.065/4;
	phiangle = 360/phisteps;


	// Now we've got some powers and steps in more
	// normal ranges, so iterate and rotate
	for (j=[0:phisteps-1])
	{
		assign(phi1 = j*phiangle)
		assign(phi2 = (j+1)*phiangle)

		assign(v1 = EvalSuperShape2D(shape, phi1))
		assign(v2 = EvalSuperShape2D(shape, phi2))
		{
			if (points)
			{
				color(pointcolor)
				translate(v1)
				sphere(r=radius);
			}

			if (wireframe)
			{
				color(wirecolor)
				PlaceLine([v1, v2], radius=radius);
			}

			if (faces)
			{
				linear_extrude(height=thickness, center=true)
				polygon(points=[[0,0], [v1[0], v1[1]], [v2[0], v2[1]]], 
					paths=[[0,1,2]]);
			}
		}
	}
}

/*

	Module: RenderSuperShape()

	Description: Render a SuperFormula based shape in 3D

	Note:
	In order to truly appreciate what's going on here, and what are useful parameters to play 
	with, you should consult the original Paul Bourke web page:
		http://paulbourke.net/geometry/supershape3d/
*/

function nozeros(v1,v2,v3,v4) = v1 !=0 && v2!=0 && v3!=0 && v3!=0;

module RenderSuperShape(shape1=supershape(0, 1, 1, 1, 1, 1), shape2=supershape(0, 1, 1, 1, 1, 1),
	phisteps = 36,
	thetasteps = 36,
	points=false,
	wireframe=false,
	faces=true,
	pointcolor=[0,0,0],
	wirecolor=[1,1,1],
	wireradius = 0.065/8,
	facecolor=[1,0.75, 0],
	fadeface = false,
	pattern=[0,0])
{
	radius = 0.065/8;

	for (i=[0:thetasteps-1]) 		// theta (longitude) -pi to pi
	{
		assign(ifrac = i/(thetasteps-1))
		for (j=[0:phisteps-1])	// phi (latitude) -pi/2 to pi/2
		{
			assign(jfrac = j/(phisteps-1))

			assign(theta1 = -pi + i * 2*pi / thetasteps)
			assign(theta2 = -pi + (i+1)*2*pi / thetasteps)

			assign(phi1 = -pi/2 + j*1*pi/phisteps)
			assign(phi2 = -pi/2 + (j+1)*1*pi/phisteps)

			// Calculate 4 radii
			assign(r0 = SSR(shape1, theta1))
			assign(r1 = SSR(shape2, phi1))
			assign(r2 = SSR(shape1, theta2))
			assign(r3 = SSR(shape2, phi2))

			if (nozeros(r0,r1,r2,r3))
			{
				assign(pa = pocart(1/r0,1/r1,theta1,phi1))
				assign(pb = pocart(1/r2, 1/r1, theta2, phi1))
				assign(pc = pocart(1/r2, 1/r3, theta2, phi2))
				assign(pd = pocart(1/r0, 1/r3, theta1, phi2))
				{
					if (points)
					{
						color(pointcolor)
						translate(pa)
						sphere(r=radius);
					}
	
					if (wireframe)
					{
						color(wirecolor)
						{
							PlaceLine([pa, pb], radius=wireradius);
	
							PlaceLine([pd, pa], radius = wireradius);
						}
					}
	
					if (faces)
					{
						if (pattern[0] > 0)
						{
							color(procedural_texture(jfrac,ifrac,pattern[0],pattern[1]))
							polyhedron(
								points = [pa,pb,pc,pd],
								triangles = [
									[0,3,2],	// pa, pd, pc
									[0, 2, 1]	// pa, pc, pb
								]);
						} else
						{
							color(facecolor)
							polyhedron(
								points = [pa,pb,pc,pd],
								triangles = [
									[0,3,2],	// pa, pd, pc
									[0, 2, 1]	// pa, pc, pb
								]);
						}
					}
				}
			}
		}
	}
}


