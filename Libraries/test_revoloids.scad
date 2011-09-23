include <revoloids.scad>

largeradius = 40; 
smallradius = largeradius / Cphi;

// A test image
rgb_image_array = [255,0,0, 0,255,0, 0,0,255, 255,0,0, 0,255,0, 0,0,255,
255,255,0, 255,255,255, 0,0,0, 255,255,0, 255,255,255, 0,0,0];

checker_array = [
0,0,0, 255,255,255, 0,0,0, 255,255,255,
255,255,255, 0,0,0, 255,255,255, 0,0,0,
0,0,0, 255,255,255, 0,0,0, 255,255,255,
255,255,255, 0,0,0, 255,255,255, 0,0,0,
];

//rgb_image = image(6,2,255, rgb_image_array); 
rgb_image = image(4,4,255, checker_array); 


//surface_rotation_ellipse(xradius = 40, yradius=40/Cphi, anglesteps = 10, sweepsteps = 10);
//surface_rotation_torus(center=[0,15], xradius = 5, yradius=5, anglesteps = 30, sweepsteps = 20);


//sor_cone(r1=30, r2=20, h=15);

//sor_ellipsoid(10,7);
//sor_sphere(r=20);
//sor_sphere(r=20, texture = rgb_image);
//sor_torus(innerRadius = 15, size=[10,6]);
//sor_bezier([[0,0,0], [0, 50,0], [20,10,0], [40, 1, 0]], texture = rgb_image);
//sor_bezier([[0,0,0], [0, 50,0], [20,10,0], [40, 1, 0]]);

//nob();
//halokiss();
//pierced();

//linear_extrude_revoloid(cps = [[0, 1, 0],[2,3,0], [4,1,0],[5,2,0]],
//	A = cubic_catmullrom_M(), umult = 5, 
//	startangle = 0, endangle=30,
//	anglesteps = 12, stacksteps = 12,
//	thickness=3,
//	showNormals=false,
//	showWireframe = false);


//shell_extrude_revoloid(cps = [[0, 1, 0],[2,3,0], [4,1,0],[5,2,0]],
//	A = cubic_catmullrom_M(), umult = 5, 
//	startangle = 0, endangle=30,
//	anglesteps = 12, stacksteps = 12,
//	thickness=3,
//	showNormals=false,
//	showWireframe = false);


//linear_extrude_revoloid(anglesteps = 12, stacksteps =12,
//	umult = 5, A = cubic_bezier_M(), 
//	cps = [[0, 1, 0],[2,3,0], [4,1,0],[5,2,0]],
//	thickness = -2,
//	showNormals = false);

//rotate_cubic_ribbon(cps = [[1, 0, 0],[3,2,0], [1,4,0],[2,5,0]],
//	M = cubic_bezier_M(), umult = 1,
//	thickness = 1,
//	stacksteps = 32,
//	showNormals = false,
//	$fn=12);


//DisplayCubicCurve(cubic_bezier_M(), 
//	cps = [[1, 0, 0],[3,2,0], [1,4,0],[2,5,0]], 
//	steps=10, 
//	showNormals=true);

//shell_extrude_revoloid(cps = [[0, 1, 0],[2,3,0], [4,1,0],[5,2,0]],
//	 A = cubic_bezier_M(), umult = 5, 
//	startangle = 15, endangle = 135,
//	anglesteps = 8, stacksteps =12,	
//	thickness = -3,
//	colors=[[1,1,0,1],[1,1,0,0.75],[0,1,1,0.75],[0.5,0.75,1,1]],
//	showNormals = true,
//	showWireframe=false);



//linear_extrude_revoloid(anglesteps = 10, stacksteps = 10,
//	umult = 1, A = cubic_hermite_M(), 
//	cps = [[0, 5, 0],[10,0,0], [15,5,0],[0,-15,0]],
//	showNormals=false);


//shell_extrude_revoloid(anglesteps = 12, stacksteps = 8,
//	umult = 5, A = cubic_hermite_M(), 
//	cps = [[0, 5, 0],[10,0,0], [15,5,0],[0,-15,0]],
//	thickness = 3,
//	showNormals=false,
//	showWireframe = false);


//===========================================
// 	Modules
//===========================================

module pierced()
{
	difference()
	{
//		shell_extrude_revoloid(anglesteps = 12, stacksteps =12,
//			umult = 5, A = cubic_bezier_M(), 
//			cps = [[0, 1, 0],[2,3,0], [4,1,0],[5,2,0]],
//			thickness = -3,
//			showNormals = false,
//			showWireframe=false);

rotate_cubic_ribbon(anglesteps =36, stacksteps = 32,
	umult = 5, A = cubic_bezier_M(), 
	cps = [[1, 0, 0],[3,2,0], [1,4,0],[2,5,0]],
	thickness = -3,
	showNormals = false);

		translate([0, 0, 10])
		rotate([90, 0, 0])
		cylinder(r=3, h = 70, center=true, $fn=24);
	}
}

module halokiss()
{
	sor_bezier([[0,0,0], [0, 50,0], [20,10,0], [40, 0, 0]]);

	translate([0,0,20])
	sor_torus(innerRadius = 15, size=[10,6]);
}

module nob()
{
	//osl_sphere(r=10);
	sor_torus(innerRadius = 15, size=[7,3]);

	rotate([0,90,0])
	cylinder(r=2.5, h=30, center=true, $fn = 12);
}