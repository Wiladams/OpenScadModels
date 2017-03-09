include <maths.scad>
include <Renderer.scad>

//===================================================
// 			Revoloids - OpenScad Solids Library
//===================================================
module sor_cone(r1=1, r2=1,h=1)
{
	translate([0,0,h])
	rotate([0,90,0])
	surface_rotation_cone(lp1=[0,r2], lp2=[h,r1], anglesteps=12, stacksteps=12);
}

module sor_ellipsoid(xRadius=1, yRadius=1)
{
	surface_rotation_ellipse(xradius = xRadius, yradius = yRadius, 
		anglesteps = 12, 
		sweepsteps = 12);
}

module sor_sphere(r=1, texture=[0,0,0,[0]])
{
	rotate([0,-90,0])
	surface_rotation_ellipse(xradius=r, yradius = r, 
		anglesteps=12, 
		sweepsteps=12,
		texture = texture);
}

module sor_torus(innerRadius=1, size=[1,1])
{
	rotate([0, -90,0])
	surface_rotation_torus(offset=[0,innerRadius], 
		size = size, 
		anglesteps = 20, 
		sweepsteps = 20);
}

module sor_bezier(curve, texture=[0,0,0,[0]])
{
	rotate([0, -90,0])
	shell_extrude_revoloid(anglesteps = 12, stacksteps =12, 
 		umult = 3, A = cubic_bezier_M(), 
 		cps = curve,
 		thickness = -2,
 		showNormals = false,
		texture=texture);
}

//===================================================
// 			Functions
//===================================================

// Returns a point on the surface given the angle and the position along the line
function param_cone(u, lp1, lp2, angle) = [lerp(u, lp1, lp2)[0],lerp(u, lp1, lp2)[1]*cos(angle),lerp(u, lp1, lp2)[1]*sin(angle)];

// Given an x, and y radius, the rotation angle and sweep angle, return the point on the surface of the ellipse
function param_ellipse(xr, yr, theta, phi) = [xr*cos(theta), yr*sin(theta)*cos(phi), yr*sin(theta)*sin(phi)];


// Point on the surface of a torus
function param_torus(offset, size, theta, phi) = 
	[offset[0]+size[0]*cos(theta), 
	(offset[1]+size[1]*sin(theta))*cos(phi), 
	(offset[1]+size[1]*sin(theta))*sin(phi)];


// Return the tangent point on the circle
// 
function circlediff(x,y) = -(x/y);
function circleradius(x,y) = sqrt(x*x+y*y);

function circletangent(pt, angle) = vec3_from_point3(vec4_mult_mat4(pt, transform_rotx(angle)));
function circlenormal(xyz) = VUNIT([0, xyz[1], xyz[2]]);

/*
	Function: cubic_surface_pt

	Description: Returns a point on the surface of revolution defined by a cubic
	planar curve.
	
	Parameters:
		T = This is a combination of the 'parameter' (u), and any multiplier.  It is a vec4
		A = This is the appropriate blending function defining the cubic curve.  A mat4
		G = This is the geometry, 4 points, in homogeneous terms. A mat4
		S = This is the rotation matrix.  A mat4

	Notes:
		
	
*/

function cubic_surface_pt(T, A, G, S) = vec3_from_point3(vec4_mult_mat4(vec4_mult_mat4(vec4_mult_mat4(T,A), G),S));

function quad_from_point3h(p0, p1, p2, p3) = [ 
	vec3_from_point3(p0), 
	vec3_from_point3(p1), 
	vec3_from_point3(p2), 
	vec3_from_point3(p3)
	];



//=====================================================
//		General surface of revolution
//=====================================================



/*
	Module: shell_extrude_revoloid

	Description:  Given a cubic planar curve geometry, generate the appropriate surface
	of revolution.

	Parameters:
		anglesteps - The number of steps around 360 degrees
		stacksteps - How many 'layers'.  This determines how smooth the curve is
		umult  - A simple multiplier for scaling
		A - The 4x4 matrix that defines a cubic curve (bezier, hermite, catmull_rom, etc)
		cps - The actual curve points.  There should be four of them in an array
		thickness - A negative number will go inward from the curve, positive outward
		showNormals - While debugging a curve, it will show the normals and tangents
		showWireframe - Will show the shape in wireframe form for easy debugging

	Notes:  
		It could become much fancier if the we allow the angle to sweep from a start
		to a finish.  Also, the rotation is currently only around the x-axis.  Realistically, it could
		be around any axis, or arbitrary line in space.  Just need to allow the rotation
		matrix to be passed in, instead of being fixed.
*/

module shell_extrude_revoloid( cps,  
	A,  umult=1, 
	startangle = 0, endangle=360, 
	anglesteps=6, stacksteps=10,
	thickness=1, 
	colors=[[1,0,0],[1,1,0],[0,1,1],[0,0,1]],
	showNormals = false,
	showWireframe= false,
 	texture=image(0,0,0,[]))
{
	dangle = endangle - startangle;
	stepangle = dangle/anglesteps;

	G = [ 
		point3_from_vec3(cps[0]), 
		point3_from_vec3(cps[1]), 
		point3_from_vec3(cps[2]), 
		point3_from_vec3(cps[3])
	];


	for (stack = [0:stacksteps-1])
	{
		// Get a point on the first derivative curve
		TDU0 = vec4_mults(quadratic_U(stack/stacksteps), umult);
		TDU1 = vec4_mults(quadratic_U((stack+1)/stacksteps), umult);

		// Get a point on the curve
		T0 = vec4_mults(cubic_U(stack/stacksteps), umult);
		T1 = vec4_mults(cubic_U((stack+1)/stacksteps), umult);

		for (astep=[0:anglesteps-1])
		{
			// Circle tangent
			// It is the same, no matter what the radius
			// so we just need it for the two bounding angles
			CT0 = circletangent([0,0,1,1], startangle + (astep*stepangle));
			CT1 = circletangent([0,0,1,1],startangle + ((astep+1)*stepangle));

			S1 = transform_rotx(startangle + (astep*stepangle));
			S2 = transform_rotx(startangle + ((astep+1)*stepangle));
			
				// Get the tangent along the curve at the 4 points
				assign(Tp0 = cubic_surface_pt(TDU0, A, G, S1))
				assign(Tp1 = cubic_surface_pt(TDU0, A, G, S2))
				assign(Tp2 = cubic_surface_pt(TDU1, A, G, S2))
				assign(Tp3 = cubic_surface_pt(TDU1, A, G, S1))

				// Calculate 4 points so we can display a quad
				assign(p0 = cubic_surface_pt(T0, A, G, S1))
				assign(p1 = cubic_surface_pt(T0, A, G, S2))

				assign(p2 = cubic_surface_pt(T1, A, G, S2))
				assign(p3 = cubic_surface_pt(T1, A, G, S1))
				{
					// Create the normal vectors at each vertex
					// We want to use each vertex because if you just
					// calculate one normal for the entire face, the vertices of
					// different layers won't line up, and we won't have a 2-manifold
					assign(N0 = VUNIT(VCROSS(CT0,Tp0)))
					assign(N1 = VUNIT(VCROSS(CT1,Tp1)))
					assign(N2 = VUNIT(VCROSS(CT1,Tp2)))
					assign(N3 = VUNIT(VCROSS(CT0,Tp3)))

					{
						assign(quadshard = [[p0, p1, p2, p3], [N0, N1, N2, N3]])
						assign(edges = [ stack==0, 
								(dangle == 360 ? false : astep == anglesteps-1), 
								stack==stacksteps-1, 
								(dangle == 360 ? false : astep == 0)])
						assign(facetcolor = texture[0] == 0 ? 
								berp(colors, stack/stacksteps) : 
								image_gettexel(texture, astep/anglesteps, stack/stacksteps))
						{
							color(facetcolor)
							if (showWireframe)
							{
								DisplayQuadFrame(quadshard[0], radius = 1/16);
							} else
							{
								// When debugging, PlaceQuad is simple and will
								// show if the quad is essentially placed correctly
//								PlaceQuad(quadshard[0]);
								DisplayQuadShard(quadshard, 
									thickness=thickness, 
									shownormals=showNormals,
									edgefaces=edges);
							}

							if (showNormals)
							{
								// Circle tangents
								color([0,1,0])
								PlaceLine([p0, p0+CT0], radius = 0.065);	
	
								// curve tangents
								//color([0,0,0])
								//PlaceLine([p0, Tp0], radius = 0.065);	
	
								// curve tangents
								color([0,1,1])
								PlaceLine([p1, Tp1], radius = 0.065);	
	
								//color([0,0,1])
								//PlaceLine([p0, p0+N0], radius = 0.125);
							}
						}
					}
				}
			
		}
	}
}


/*
	Module: rotate_cubic_ribbon

	Description: Similar to the shell_extrude, but trying to use the built-in 'rotate_extrude'
	Although this method will play nicely with CSG rendering, it will not generate 2-manifold solids.
	Perhaps sections need to overlap.
*/
module rotate_cubic_ribbon(
	anglesteps=6, stacksteps=10, umult=1, A, 
	cps, thickness=1,
	stacksteps=10, 
	colors=[[1,0,0],[1,1,0],[0,1,1],[0,0,1]],
	showNormals = false)
{
	$fn=anglesteps;

	G = [ 
		point3_from_vec3(cps[0]), 
		point3_from_vec3(cps[1]), 
		point3_from_vec3(cps[2]), 
		point3_from_vec3(cps[3])
	];

	CT0 = [0,0,1];

	for (stack=[0:stacksteps-1])
	{
		assign(stackfrac1 = stack/stacksteps)
		assign(stackfrac2 = (stack+1)/stacksteps)

		// Prepare to Get a point on the first derivative curve
		assign(du0 = vec4_mults(quadratic_U(stack/stacksteps), umult))
		assign(du1 = vec4_mults(quadratic_U((stack+1)/stacksteps), umult))


		// Prepare to Get a point on the curve
		assign(u0 = vec4_mults(cubic_U(stack/stacksteps), umult))
		assign(u1 = vec4_mults(cubic_U((stack+1)/stacksteps), umult))
		{
			// Get the tangent along the curve at the 4 points
			assign(Tp0 = ccerp(du0, A, G))
			assign(Tp1 = ccerp(du1, A, G))

			// Get two points along the curve
			assign(p0 = ccerp(u0, A, G))
			assign(p1 = ccerp(u1, A, G))
			{		
				// Get the normals at the two tangent points
				assign(N0 = VUNIT(VCROSS(CT0,Tp0)))
				assign(N1 = VUNIT(VCROSS(CT0,Tp1)))
				{
					assign(p2 = p0+(-thickness*N0))
					assign(p3 = p1+(-thickness*N1))
					{
						color(berp(colors, stack/stacksteps))
						rotate_extrude(convexity=2) 
						polygon(
							points=[
								vec2_from_vec3(p0),
								vec2_from_vec3(p1),
								vec2_from_vec3(p2),
								vec2_from_vec3(p3)],
							paths=[[0,2,3,1]]
						);
						
						if (showNormals)
						{
							color([0,0,1])
							{
							PlaceLine([p0, p0+(N0*2)], radius = 0.065);
							PlaceLine([p1, p1+(N1*2)], radius = 0.065);
							}
						}
					}
				}
			}
		}
	}
}

module linear_extrude_revoloid(cps,  
	A,  umult=1, 
	startangle = 0, endangle=360, 
	anglesteps=6, stacksteps=10,
	thickness=1, 
	colors=[[1,0,0],[1,1,0],[0,1,1],[0,0,1]],
	showNormals = false,
	showWireframe= false)
{
	dangle = endangle - startangle;
	stepangle = dangle/anglesteps;

	G = [ 
		point3_from_vec3(cps[0]), 
		point3_from_vec3(cps[1]), 
		point3_from_vec3(cps[2]), 
		point3_from_vec3(cps[3])
	];


	for (stack = [0:stacksteps-1])
	{
		assign(T1 = vec4_mults(cubic_U(stack/stacksteps), umult))
		assign(T2 = vec4_mults(cubic_U((stack+1)/stacksteps), umult))
		for (astep=[0:anglesteps-1])
		{
			assign(CT0 = circletangent([0,0,1,1], startangle+(astep*stepangle)))
			assign(S1 = transform_rotx(startangle+(astep*stepangle)))
			assign(S2 = transform_rotx(startangle+((astep+1)*stepangle)))
			{
				// Calculate 4 points so we can display a quad
				assign(p0 = cubic_surface_pt(T1, A, G, S1))
				assign(p1 = cubic_surface_pt(T2, A, G, S1))

				assign(p2 = cubic_surface_pt(T1, A, G, S2))
				assign(p3 = cubic_surface_pt(T2, A, G, S2))
				{
					assign(CN0 = circlenormal(p0))
					assign(CN1 = circlenormal(p1))
					assign(CN2 = circlenormal(p2))
					assign(CN3 = circlenormal(p3))
					{
						assign(quadshard = [[p0, p2, p3, p1], [CN0, CN2, CN3, CN1]])
						assign(edges = [ stack==0, 
								(dangle == 360 ? false : astep == anglesteps-1), 
								stack==stacksteps-1, 
								(dangle == 360 ? false : astep == 0)])
						{
							if (showWireframe)
							{
								DisplayQuadFrame(quad, radius = 1/16);
							} else
							{
								//PlaceQuad(quadshard[0]);
								DisplayQuadShard(quadshard, 
									thickness=thickness, 
									shownormals=showNormals,
									edgefaces=edges);
							}

							//color([0,1,0])
							//PlaceLine([p0, p0+CT0], radius = 0.125);	
						}
					}
				}
			}
		}
	}
}


//===================================================
// 			Linear Cones
//===================================================

module surface_rotation_cone(lp1, lp2, anglesteps=6, stacksteps=10)
{
	stepangle = 360/anglesteps;

	for (stack = [0:stacksteps-1])
	{
		for (astep=[0:anglesteps-1])
		{
			// Calculate 4 points so we can display a quad
			assign(p0 = param_cone(stack/stacksteps, lp1, lp2, astep * stepangle))
			assign(p1 = param_cone(stack/stacksteps, lp1, lp2, (astep+1) * stepangle))

			assign(p2 = param_cone((stack+1)/stacksteps, lp1, lp2, astep * stepangle))
			assign(p3 = param_cone((stack+1)/stacksteps, lp1, lp2, (astep+1) * stepangle))
			{
				//DisplayQuadFrame([p0, p1, p3, p2]);
				PlaceQuad([p0, p1, p3, p2]);
			}
		}
	}
}


module surf_cone(r1=1, r2=1, h=1, steps = 8)
{
	translate([0, 0, h])
	rotate([0, 90, 0])
	surface_rotation_cone([0, r1,0], [h, r2, 0], anglesteps=steps, linearsteps=steps);
}

module surf_tube(inner=0.5, outer=1, h=1, steps=8)
{
	surf_cone(r1=outer, r2=outer, h=h, steps=steps);
}


//===================================================
//				Ellipse and Sphere
//===================================================

module surface_rotation_ellipse(xradius = 1, yradius = 1, 
	anglesteps = 6, sweepsteps = 6,  
	colors=[[1,0,0],[1,1,0],[0,1,1],[0,0,1]],
	texture=[0,0,0,[0]])
{
	sstepangle = 360 / sweepsteps;	// phi
	astepangle = 180/ anglesteps;		// theta

	// Angle 0 <= phi <= 2pi
	for (sstep = [0:sweepsteps-1])
	{
		// Angle 0 <= theta <= pi
		for(astep = [0:anglesteps-1])
		{
			assign(p0 = param_ellipse(xr = xradius, yr=yradius, theta = astep*astepangle, phi = sstep*sstepangle))
			assign(p1 = param_ellipse(xr = xradius, yr=yradius, theta = (astep+1)*astepangle, phi = sstep*sstepangle))

			assign(p3 = param_ellipse(xr = xradius, yr=yradius, theta = astep*astepangle, phi = (sstep+1)*sstepangle))
			assign(p2 = param_ellipse(xr = xradius, yr=yradius, theta = (astep+1)*astepangle, phi = (sstep+1)*sstepangle))
			assign(facetcolor = texture[0] == 0 ? 
				berp(colors, sstep/sweepsteps) : 
				image_gettexel(texture, sstep/(sweepsteps-1), astep/(anglesteps-1)))
			{
				color(facetcolor)
				//DisplayQuadFrame([p0, p1, p3, p2]);
				PlaceQuad([p0, p1, p2, p3]);
			}
		}
	}
}


//===================================================
//				Torus
//===================================================

module surface_rotation_torus(offset=[0,1], 
	size=[0.5,0.5], 
	anglesteps = 12, 
	sweepsteps = 12)
{
	sstepangle = 360 / sweepsteps;	// phi
	astepangle = 360/ anglesteps;		// theta

	// Angle 0 <= phi <= 2pi
	for (sstep = [0:sweepsteps-1])
	{
		// Angle 0 <= theta <= 2pi
		for(astep = [0:anglesteps-1])
		{
			assign(p0 = param_torus(offset=offset, size = size, theta = astep*astepangle, phi = sstep*sstepangle))
			assign(p1 = param_torus(offset=offset, size=size, theta = (astep+1)*astepangle, phi = sstep*sstepangle))

			assign(p2 = param_torus(offset=offset,  size=size, theta = astep*astepangle, phi = (sstep+1)*sstepangle))
			assign(p3 = param_torus(offset=offset,  size=size, theta = (astep+1)*astepangle, phi = (sstep+1)*sstepangle))
			{
				//DisplayQuadFrame([p0, p1, p3, p2]);
				PlaceQuad([p0, p1, p3, p2]);
			}
		}
	}
}


