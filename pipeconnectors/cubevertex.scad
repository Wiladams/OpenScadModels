// A default set of sizes 
goldenratio = 1.61803399;
joinfactor = 0.25;

IR = 5/16/2*25.4; // Inner radius of connector
OR = (IR * goldenratio)*goldenratio; // Outer radius of connector
Length = OR*2; // Length of connector

quarterinch = 1/4 * 25.4; 
eighthinch = 1/8 * 25.4;

//OuterSquareInnerCylinder(22, IR, OR);
//cubevertexround(Radius, Length, IR, OR, Depth);
//cubevertexsquare(Length, IR, OR, Depth);
//cubevertexsquarestack(Length, IR, OR, Depth);
//cubevertexsquarestackthru(Length, IR, OR, Depth);
//cubevertexsquarethru(Length, IR, OR, Depth);
//elbowriser(Length, IR, OR);
cubevertex(Length, IR);

module cubevertex(side, IR)
{
	difference()
	{
		cube(size=[side, side, side], center=true);

		// along  x-axis
		rotate([0, 90, 0])
		cylinder(r=IR, h=side+joinfactor*2, center=true);

		// along y-axis
		rotate([90, 0, 0])
		cylinder(r=IR, h=side+joinfactor*2, center=true);

		// Along z-axis
		cylinder(r=IR, h=side+joinfactor*2, center=true);
	}
}



