include <superellipse.scad>

//test_singles();
//test_csg();

test_layout();

//======================================
//	TESTS
//======================================

module test_csg()
{
	difference()
	{
		  scale([10,10,10]) 
		superellipse(power1=0.2, power2=0.5, steps=9, ysteps=9);

		cylinder(r=5, h=45);
	}
}

module test_singles()
{
color([0,0,0,1])
sphere(r=1000, $fn=128);
scale([10,10,10]) 
//superellipse(power1=0.2, power2=0.5, steps=36, ysteps=36);
//superellipse(power1=0.2, power2=1, steps=72);
//superellipse(power1=0.2, power2=3, steps=36, ysteps=18, faces=false, wireframe=false, points=true);
//superellipse(power1=0.5, power2=0.5, steps=36);
//superellipse(power1=0.5, power2=3, steps=36, ysteps=18, wireframe=false,  pattern=[8,8]);
//superellipse(power1=1, power2=0.3, steps=18, ysteps=18, faces=true, wireframe=false);
//superellipse(power1=1, power2=1, steps=18, ysteps=18, faces=false, wireframe=false, points=true);
//superellipse(power1=1, power2=2, steps=18, ysteps=10, wireframe=true);
//superellipse(power1=1, power2=3, steps=36, ysteps=36, faces=false, points=true);

//scale([10,10,10]) 
superellipse(power1=1, power2=3, steps=16, ysteps=36, faces=true, pattern=[8,8], points=false);

//superellipse(power1=2, power2=0.3, steps=18, ysteps=18, faces=true, wireframe=false);
//superellipse(power1=2, power2=1, steps=18, ysteps=18, faces=true, wireframe=false);
//superellipse(power1=2, power2=2, steps=36, ysteps=18, faces=true, wireframe=true);
//superellipse(power1=2, power2=3, steps=36, ysteps=18, faces=true, wireframe=false);
//superellipse(power1=3, power2=0.2, steps=18, ysteps=18, pattern=[9,9]);
//superellipse(power1=3, power2=1, steps=72);
//superellipse(power1=4, power2=4, steps=36, ysteps=36, wireframe=true);
//superellipse(power1=4, power2=4, steps=36, ysteps=72, faces=false, wireframe=false, points=true);
//superellipse(power1=6, power2=3, steps=36, ysteps=36);
}

module test_layout()
{
//color([0,0,0,1])
//sphere(r=1000, $fn=128);

scale([10,10,10]) 
superellipse(power1=1, power2=3, steps=16, ysteps=36, points=true, wireframe=false, faces=false, pattern=[8,8]);

translate([10,0,0])
scale([10,10,10]) 
superellipse(power1=1, power2=3, steps=16, ysteps=36, points=false, wireframe=true, faces=false, pattern=[8,8]);

translate([20,0,0])
scale([10,10,10]) 
superellipse(power1=1, power2=3, steps=64, ysteps=64, points=false, wireframe=false, faces=true, pattern=[32,64]);

}
