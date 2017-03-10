//
// License: This code is placed in the public domain
// By: William A Adams
// 11th Oct 2011
//
// You can study the superellipse by looking at the following by 
// Paul Bourke
// http://paulbourke.net/geometry/superellipse/
//

include <LineRenderer.scad>

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
// SuperEllipse evaluation
//=========================================

function _EvalSuperEllipse2(p1,p2,ct1,ct2,st1,st2,tmp) = [
	tmp * sign(ct2) *pow(abs(ct2), p2),
	sign(st1) * pow(abs(st1), p1),
	tmp * sign(st2) * pow(abs(st2),p2)];

function _EvalSuperEllipse1(p1,p2, ct1, ct2, st1, st2) = 
	_EvalSuperEllipse2(p1,p2, ct1,ct2,st1,st2, sign(ct1) * pow(abs(ct1),p1));

function EvalSuperEllipse(t1, t2, p1, p2) = 
	_EvalSuperEllipse1(p1, p2, cos(t1),cos(t2),sin(t1),sin(t2));


/*
	Module: superellipse

	Description: Generate a superellipse based object.  This routine will 
	do all the rendering of the object.  You can specify a wireframe, faces, 
	or both.
*/
module superellipse(power1, power2, 
	steps = 10, ysteps=10, 
	faces=true, 
	wireframe=false,
	points=false,
	pattern=[8,8],
	pointcolor=[0,0,0])
{
	radius = 0.065/8;
	PID2 = 180/2;
	stepangle = 360/steps;
	ystepangle = 360/ysteps;

	delta = 0.01*stepangle;

	// If the number of steps is too small,
	// just render a sphere, and skip all the calculations
	if (steps < 4)
	{
		sphere(r=1,$fn=12);
	} else if (power1 > 10 && power2 > 10)
	{
		// If the powers are really high, we can just draw axes
		// lines, as the math would end up being that anyway
		PlaceLine([[-1,0,0], [1, 0,0]], radius=0.125);
		PlaceLine([[0,-1,0], [0, 1,0]], radius=0.125);
		PlaceLine([[0,0,-1], [0, 0,1]], radius=0.125);
	} else
	{
		// Now we've got some powers and steps in more
		// normal ranges, so iterate and rotate
		for (j=[0:(ysteps/2)-1])
		{
			assign(jfrac = j/((ysteps/2)-1))
			assign(theta1 = j*ystepangle - PID2)
			assign(theta2 = (j+1)*ystepangle - PID2)

			for (i=[0:steps-1])
			{
				assign(ifrac = (i/steps-1))
				assign(  theta3 =  i*stepangle )
				assign(  theta4 = (i+1)*stepangle )

				assign(v1 = EvalSuperEllipse(theta2, theta3, power1, power2))
				assign(v2 = EvalSuperEllipse(theta2, theta4, power1, power2))
				assign(v3 = EvalSuperEllipse(theta1, theta4, power1, power2))
				assign(v4 = EvalSuperEllipse(theta1, theta3, power1, power2))
				{
					if (points)
					{
						color(pointcolor)
						translate(v1)
						sphere(r=radius);
					}

					if (wireframe)
					{
						color([1,1,1])
						PlaceLine([v1, v2], radius=radius);
						PlaceLine([v1,v3], radius=radius);
						color([1,1,1])
						PlaceLine([v2, v3], radius=radius);
						color([1,1,1])
						PlaceLine([v3, v4], radius=radius);
						color([1,1,1])
						PlaceLine([v4, v1], radius=radius);
					}
	
					if (faces)
					{
						color(procedural_texture(jfrac,ifrac,pattern[0],pattern[1]))
						polyhedron(
							points = [v1,v2,v3,v4],
							faces = [
								[0,2,1],
								[0,3,2]
							]);
					}
				}
			}
		}
	}
}
