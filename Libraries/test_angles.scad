include <maths.scad>

steps = 1;
lowangle = 315;
highangle = 315;
thickness = 0.5;

tripointsy = [[0,10,0], [0,0,0],[10,5,10]];
tripointsx = [[0,0,0], [10,0,0],[5,10,10]];
tripointsflat = [[0,0,0], [10,0,0],[5,10,0]];

//rotatex();
//rotatey();
//rotateslab();

placetri(tripointsy);

//========================================
//		Functions
//========================================
function PlaneRotations(v) = [ 
	atan2(sqrt(v[0]*v[0]+v[1]*v[1]), v[2]), 
		0, 
		atan2(v[1], v[0])-270];

//========================================
//		Modules
//========================================

module rotateslab()
{
	for (step = [0:steps])
	{
		assign(angle = lowangle + (highangle-lowangle)*step/steps)
		{
			assign(angles=[angle, 0,0])
			{		
echo("Angles: ", angles);
				rotate([angle, 0,0])
				linear_extrude(height =thickness, convexity = 10) 
				polygon(
				points= [[0,0], [10,0], [10,10], [0,10]],
					paths = [[0,1,2,3]]);

				rotate([0, angle,0])
				linear_extrude(height =thickness, convexity = 10) 
				polygon(
				points= [[0,0], [0,10], [-10,10], [-10,0]],
					paths = [[0,1,2,3]]);

				translate([0,0,10])
				rotate([0, 0,angle])
				linear_extrude(height =thickness, convexity = 10) 
				polygon(
				points= [[0,0], [0,10], [-10,10], [-10,0]],
					paths = [[0,1,2,3]]);

			}
		}
	}
}

module rotatex()
{
	for (step = [0:steps])
	{
		assign(angle = lowangle + (highangle-lowangle)*step/steps)
		{
			assign(points = [[-10, 0, 0], [10, 0, 0], [0, 10*cos(angle), 10*sin(angle)]])
			{ 
				assign(normal = VPROD((points[2]-points[1]),(points[0]-points[1])))
				{
					assign(angles = rotations(normal))
					rotate(angles)
					{
		echo("Points: ", points);
		echo("Normal: ", normal);
		echo("Angles: ", angles);
						//cube(size=[30, thickness, 30], center=true);
				
						linear_extrude(height =thickness, convexity = 10) 
						polygon(
						points= [[-10,0], [10,0], [0,20]],
							paths = [[0,1,2]]);
					}
				}
			}
		}
	}
}

module rotatey()
{
	for (step = [0:steps])
	{
		assign(angle = lowangle + (highangle-lowangle)*step/steps)
		{
			assign(points = [[0, 10, 0], [0, -10, 0], [10*cos(angle), 0, 10*sin(angle)]])
			{ 
				assign(normal = VPROD((points[2]-points[1]),(points[0]-points[1])))
				{
					assign(angles = rotations(normal))
					rotate(angles)
					{
		echo("Points: ", points);
		echo("Normal: ", normal);
		echo("ANGLE: ", angle);
		echo("Angles: ", angles);
						//cube(size=[30, thickness, 30], center=true);
				
						linear_extrude(height =thickness, convexity = 10) 
						polygon(
						points= [[0,10], [0,-10], [20,0]],
							paths = [[0,1,2]]);
					}
				}
			}
		}
	}
}


module placetri(tri)
{

	offset = tri[1];

	op0 = tri[0] - offset;
	op1 = tri[1] - offset;
	op2 = tri[2] - offset;

//	v = tri[0]-tri[1];
//	w = tri[2]-tri[1];

	v = op0-op1;
	w = op2-op1;

echo("POINTS: ", tri);
echo("OFFSET: ", offset);
echo("VECTORS: ", v, w);

	normal = VCROSS(w,v);
echo("NORMAL: ", normal);

	angles = PlaneRotations(normal);
echo("ANGLES: ", angles);

	rotate(angles)
	{
		translate(offset)
		linear_extrude(height =thickness, convexity = 10) 
			polygon(
				points= [
					[op0[0],op0[1]], 
					[op1[0], op1[1]], 
					[op2[0],op2[1]]],
				paths = [[0,1,2]]);
	}
}

