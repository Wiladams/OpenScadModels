include <glsl.scad>

test_smoothstep();

module test_smoothstep()
{
	scale = 20;
	edge0 = .30;
	edge1 = .70;
	iterations = 100;

	for (iter=[0:iterations])
	{
		assign(frac = iter/iterations)
		assign(v=smoothstep(edge0, edge1, frac))
		translate([frac*scale,v*scale, 0])
		circle(1);
	}
}
