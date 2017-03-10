include <../waolib/supershape.scad>

//test_singles();
//test_symmetry();
//test_csg();

//test_layout();

test_supershape();

//test_bowl();
//star_bowl();

//======================================
//	TESTS
//======================================

module test_csg()
{
	difference()
	{
	// Sphere
	scale([10,10,10])
	RenderSuperShape(
		shape1 = supershape(m=0, n1=1, n2=1, n3=1, a=1, b=1), 
		shape2=supershape(m=0, n1=1, n2=1, n3=1, a=1, b=1), 
		pattern=[18,18]);

		cylinder(r=5, h=45, center=true);
	}
}

module test_singles()
{
//color([0,0,0,1])
//sphere(r=1000, $fn=128);

//scale([10,10,10]) 

// Circle
//RenderSuperShape2D();


//RenderSuperShape2D(supershape(m=1, n1=0.5, n2=0.5, n3=0.5), phisteps=72);

//RenderSuperShape2D(supershape(m=2, n1=0.5, n2=0.5, n3=0.5), phisteps=72, points=false, wireframe=true);

//RenderSuperShape2D(supershape(m=2, n1=01, n2=1, n3=1), phisteps=72);


//scale([10,10,10])
//RenderSuperShape2D(shape=supershape(m=3, n1=30, n2=15, n3=15), 
//	phisteps=72,
//	wireframe=false,
//	faces=true,
//	thickness=3/10);

difference()
{
	scale([10,10,10])
	RenderSuperShape2D(shape=supershape(m=3, n1=5, n2=18, n3=18), 
		phisteps=72,
		wireframe=false,
		faces=true,
		thickness=3/10);

	scale([10,10,10])
	RenderSuperShape2D(shape=supershape(m=3, n1=1, n2=7, n3=8,a=0.85,b=0.85), 
		phisteps=72,
		wireframe=false,
		faces=true,
		thickness=4/10);

	//cylinder(r=2.5, h=12, center=true, $fn=12);
}

//difference()
//{
//RenderSuperShape2D(shape = supershape(m=12, n1=0.5, n2=0.5, n3=16), 
//	phisteps=72, 
//	wireframe=false,
//	faces=true);
//cylinder(r=0.25, h=3, center=true);
//}


}

module test_symmetry()
{
	// n == 1
	scale([10,10,10])
	{
		//RenderSuperShape2D(supershape(m=0), phisteps=72);
		//RenderSuperShape2D(supershape(m=1));
		//RenderSuperShape2D(supershape(m=2));
		RenderSuperShape2D(supershape(m=3));
		//RenderSuperShape2D(supershape(m=4));
		//RenderSuperShape2D(supershape(m=5));
		//RenderSuperShape2D(supershape(m=6));
	}

	// n == 0.3
//	scale([10,10,10])
//	{
//		RenderSuperShape2D(supershape(m=0, n1=0.3, n2=0.3, n3=0.3), phisteps=72);
//		RenderSuperShape2D(supershape(m=1, n1=0.3, n2=0.3, n3=0.3), phisteps=72);
//		RenderSuperShape2D(supershape(m=2, n1=0.3, n2=0.3, n3=0.3), phisteps=72);
//		RenderSuperShape2D(supershape(m=3, n1=0.3, n2=0.3, n3=0.3), phisteps=72);
//		RenderSuperShape2D(supershape(m=4, n1=0.3, n2=0.3, n3=0.3), phisteps=72);
//		RenderSuperShape2D(supershape(m=5, n1=0.3, n2=0.3, n3=0.3), phisteps=72);
//		RenderSuperShape2D(supershape(m=6, n1=0.3, n2=0.3, n3=0.3), phisteps=72);
//	}

	// n1 = 40, n2 == n3 == 10
//	scale([10,10,10])
//	{
//		RenderSuperShape2D(supershape(m=0, n1=40, n2=10, n3=10), phisteps=72);
//		RenderSuperShape2D(supershape(m=1, n1=40, n2=10, n3=10), phisteps=72);
//		RenderSuperShape2D(supershape(m=2, n1=40, n2=10, n3=10), phisteps=72);
//		RenderSuperShape2D(supershape(m=3, n1=40, n2=10, n3=10), phisteps=72);
//		RenderSuperShape2D(supershape(m=4, n1=40, n2=10, n3=10), phisteps=72);
//		RenderSuperShape2D(supershape(m=5, n1=40, n2=10, n3=10), phisteps=72);
//		RenderSuperShape2D(supershape(m=6, n1=40, n2=10, n3=10), phisteps=72);
//	}

	// Polygonal shapes
	// n1 = large, n2 == n3
//	scale([10,10,10])
//	{
////		RenderSuperShape2D(supershape(m=0, n1=100, n2=160, n3=160), phisteps=72);
////		RenderSuperShape2D(supershape(m=1, n1=100, n2=160, n3=160), phisteps=72);
////		RenderSuperShape2D(supershape(m=2, n1=100, n2=160, n3=160), phisteps=72);
//		//RenderSuperShape2D(supershape(m=3, n1=100, n2=160, n3=160), phisteps=72);
//		//RenderSuperShape2D(supershape(m=4, n1=100, n2=160, n3=160), phisteps=72);
//		//RenderSuperShape2D(supershape(m=5, n1=100, n2=160, n3=160), phisteps=72);
//		RenderSuperShape2D(supershape(m=6, n1=100, n2=160, n3=160), phisteps=72);
//	}

	// starfish shapes
	// m=5, n1 = varies, n2 == n3 = 1.7
//	scale([10,10,10])
//	{
//		RenderSuperShape2D(supershape(m=5, n1=0.02, n2=1.7, n3=1.7), phisteps=72);
//		RenderSuperShape2D(supershape(m=5, n1=0.10, n2=1.7, n3=1.7), phisteps=72);
//		RenderSuperShape2D(supershape(m=5, n1=0.20, n2=1.7, n3=1.7), phisteps=72);
//		RenderSuperShape2D(supershape(m=5, n1=0.50, n2=1.7, n3=1.7), phisteps=72);
//	}

}

module test_supershape()
{
//color([0,0,0,1])
//color([0,0,0,1])
//sphere(r=1000, $fn=128);


//	scale([10,10,10])
//	RenderSuperShape(points=true);

	// Sphere
//	scale([10,10,10])
//	RenderSuperShape(
//		shape1 = supershape(m=0, n1=1, n2=1, n3=1, a=1, b=1), 
//		shape2=supershape(m=0, n1=1, n2=1, n3=1, a=1, b=1), 
//		phisteps = 5,
//		thetasteps = 5,
//		pattern=[0,18],
//		wireframe=true,
//		wireradius=0.1);

	// Octahedron
//	scale([10,10,10])
//	RenderSuperShape(
//		shape1 = supershape(m=4, n1=1, n2=1, n3=1, a=1, b=1), 
//		shape2=supershape(m=4, n1=1, n2=1, n3=1, a=1, b=1), 
//		points=false,
//		wireframe=false,
//		faces=true);


//	scale([10,10,10])
//	RenderSuperShape(
//		shape1 = supershape(m=8, n1=60, n2=100, n3=30, a=1, b=1), 
//		shape2=supershape(m=2, n1=10, n2=10, n3=10, a=1, b=1), 
//		phisteps = 18,
//		thetasteps = 18,
//		points=false,
//		wireframe=false,
//		faces=true);

//	scale([10,10,10])
//	RenderSuperShape(
//		shape1 = supershape(m=2, n1=0.7, n2=0.3, n3=0.2, a=1, b=1), 
//		shape2=supershape(m=3, n1=100, n2=100, n3=100, a=1, b=1), 
//		phisteps = 64,
//		thetasteps = 32,
//		points=false,
//		wireframe=false,
//		faces=true,
//		pattern=[32,32]);
//
//	scale([10,10,10])
//	RenderSuperShape(
//		shape1 = supershape(m=6, n1=60, n2=55, n3=1000, a=1, b=1), 
//		shape2=supershape(m=6, n1=250, n2=100, n3=100, a=1, b=1), 
//		phisteps = 8,
//		thetasteps = 64,
//		points=false,
//		pointcolor=[1,1,1],
//		wireframe=false,
//		faces=true);

//	scale([10,10,10])
//	RenderSuperShape(
//		shape1 = supershape(m=5, n1=1, n2=1, n3=1, a=1, b=1), 
//		shape2=supershape(m=3, n1=100, n2=100, n3=100, a=1, b=1), 
//		phisteps = 16,
//		thetasteps = 16,
//		points=false,
//		wireframe=true,
//		faces=false,
//		pattern=[0,0]);

	scale([30,30,30])
	RenderSuperShape(
		shape1 = supershape(m=7, n1=0.2, n2=1.7, n3=1.7, a=1, b=1), 
		shape2=supershape(m=7, n1=0.2, n2=1.7, n3=1.7, a=1, b=1), 
		phisteps = 64,
		thetasteps = 128,
		points=false,
		wireframe=false,
		faces=true,
		facecolor = [0,.75,0.75],
		pattern=[0,32]);

//	scale([10,10,10])
//	RenderSuperShape(
//		shape1 = supershape(m=4, n1=0.5, n2=0.5, n3=4, a=1, b=1), 
//		shape2=supershape(m=4, n1=0.5, n2=0.5, n3=4, a=1, b=1), 
//		phisteps = 64,
//		thetasteps = 64,
//		points=false,
//		wireframe=false,
//		faces=true,
//		facecolor = [0,.75,0.75],
//		pattern=[0,64]);

//	scale([50,50,50])
//	RenderSuperShape(
//		shape1 = supershape(m=12, n1=1, n2=1, n3=1, a=1, b=1), 
//		shape2=supershape(m=0, n1=1, n2=1, n3=1, a=1, b=1), 
//		phisteps = 16,
//		thetasteps = 128,
//		points=false,
//		wireframe=false,
//		faces=true,
//		facecolor = [0,.75,0.75],
//		pattern=[0,64]);

//	scale([50,50,50])
//	RenderSuperShape(
//		shape1 = supershape(m=5, n1=1, n2=1, n3=1, a=1, b=1), 
//		shape2=supershape(m=0, n1=1, n2=1, n3=1, a=1, b=1), 
//		phisteps = 16,
//		thetasteps = 128,
//		points=false,
//		wireframe=false,
//		faces=true,
//		facecolor = [0,.75,0.75],
//		pattern=[0,64]);

	// Needs multiple loops through pi to get a good pattern
	// can't do it by default right now
//	scale([10,10,10])
//	RenderSuperShape(
//		shape1 = supershape(m=5.2, n1=0.04, n2=1.7, n3=1.7, a=1, b=1), 
//		shape2=supershape(m=0, n1=1.0, n2=1.0, n3=1.0, a=1, b=1), 
//		phisteps = 32,
//		thetasteps = 32,
//		points=false,
//		wireframe=false,
//		faces=true,
//		facecolor = [0,.75,0.75],
//		pattern=[0,0]);
//

	// Not quite
//	scale([10,10,10])
//	RenderSuperShape(
//		shape1 = supershape(m=9.0, n1=-89.25, n2=0.41, n3=-31.90, a=1, b=1), 
//		shape2=supershape(m=4.0, n1=100, n2=1000, n3=1000, a=1, b=1), 
//		phisteps = 32,
//		thetasteps = 32,
//		points=false,
//		wireframe=false,
//		faces=true,
//		facecolor = [0,.75,0.75],
//		pattern=[0,0]);
}


module test_bowl()
{
	difference()
	{
		import_stl("se2.stl",convexity=5); 

		scale([0.95,0.95,1])
		import_stl("se2.stl",convexity=5); 

		translate([-55,-55,0])
		cube(size=[110,110,60]);
	}

	translate([0,0,-50])
	cylinder(r=19.5, h=8);
}


module star_bowl()
{
	difference()
	{
		import_stl("Models/star1.stl",convexity=5); 

		scale([0.50,0.50,1])
		import_stl("Models/star1.stl",convexity=5); 

		translate([-55,-55,0])
		cube(size=[110,110,60]);
	}

//	translate([0,0,-50])
//	cylinder(r=19.5, h=8);
}
