include <glsl.scad>

/*
    smoothstep
    
    A function that will do a smooth interpolation between
    the edge0 and edge1 threshold values.
    
    
*/

module test_smoothstep()
{
	scale = 100;
	edge0 = .30;
	edge1 = .70;
	iterations = 300;

	for (iter=[0:iterations])
	{
		frac = iter/iterations;
		v=smoothstep(edge0, edge1, frac);
		translate([frac*scale,v*scale, 0])
		circle(1);
	}
}

test_smoothstep();

