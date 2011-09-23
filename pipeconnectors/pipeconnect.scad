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
smoothbarholder(Length, OR*2, IR, IR*1.05, $fn=32);

module OuterSquareInnerCylinder(Length, IR, OR) 
{
	OuterSize = OR*2;

	difference()
	{
		cube(size=[OuterSize, OuterSize, Length]);
		
		translate([OR, OR, -joinfactor])
		cylinder(r=IR, h=Length+joinfactor*2);
	}
}

module elbowriser(Length, IR, OR)
{
	Offset = 0;
	OuterSize = OR*2;
	RDiff = OR - IR;

	difference()
	{
		union()
		{
			for(c=[
				[Length, OuterSize, OuterSize],	// Along x-axis
				[OuterSize, Length, OuterSize],	// Along y-axis
				[OuterSize, OuterSize, Length]		// Along z-axis
				])
			{
				cube(size=c);
			}
		}

		// Subtract out the holes
		rotate([0, 90, 0])
		translate([-OR, OR,-joinfactor])
		cylinder(r=IR, h=Length+joinfactor*2);

		rotate([-90, 0, 0])
		translate([OR, -OR,-joinfactor])
		cylinder(r=IR, h=Length+joinfactor*2);

		translate([OR, OR,-joinfactor])
		cylinder(r=IR, h=Length+joinfactor*2);

		// Do some carving on the edges for better raft separation and aesthetics
//		rotate([0, 90, 0])
//		translate([IR*1/goldenratio, OR,-joinfactor])
//		cylinder(r=IR*goldenratio, h=Length+joinfactor*2);
	}
	
}

module smoothbarholder(Width, Depth, rodRadius, barRadius)
{

	difference()
	{
		cube(size=[Width, Depth, Depth]);
	
		rotate([0, 90, 0])
		translate([-Depth/2, Depth/2,-joinfactor])
		cylinder(r=rodRadius, h=Length+joinfactor*2);

		translate([Width/2, Depth/2,Depth-rodRadius*goldenratio])
		cylinder(r=barRadius, h=Length);
	}
}


