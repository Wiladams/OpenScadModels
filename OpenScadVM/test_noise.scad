include <noise.scad>

//====================================== 
// Test Routines
//======================================


module test_noise1()
{
	sfactor = 30;
	range = 200;

	scale([sfactor,sfactor,sfactor])
    color([1,0,0])

	for (x=[-range/2:range/2])
	{
		y1 = noise1(x);
		y2=smoothednoise1(y1);
        translate([x,y2*sfactor, 0]) 
        cube(size=[1, 1, 1], center=true);
    }
}