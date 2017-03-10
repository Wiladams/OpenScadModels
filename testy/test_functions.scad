include <../waolib/Renderer.scad>

lineradius = 0.01;

drawTree(alimit=[0,90,3], iterations=128, wireframe = true, faces=true);


//==================================
// Functions
//==================================
function clamp(x, minValue, maxValue) = min(max(x,minValue),maxValue);


//function func(x) = (2*pow(x,3) - 4*pow(x,2)  - 9)/(3-pow(x,2));

//function func(x) = (x*x + 3*x + 2) / (x-2);

function func(x) = (x*x+3*x+1) / (4*x*x - 9);

//function func(x) = (x*x-x-2) / (x-2);

module drawTree(xrange = [-10,10], yrange = [-30,30], alimit=[0,360,10], iterations = 20, 
	wireframe = false,
	faces = true)
{
	range = xrange[1] - xrange[0];

	arange = alimit[1]-alimit[0];

	rotatesteps = alimit[2];
	rotangle = arange/rotatesteps;

	for (rot = [0:rotatesteps-1])
	{
		for (iter = [0:iterations-1])
		{
			x1 = xrange[0]+iter/iterations*range;
			y1 = clamp(func(x1), yrange[0], yrange[1]);

			x2 = xrange[0]+(iter+1)/iterations*range;
			y2 = clamp(func(x2), yrange[0], yrange[1]);

			x11 = x1*cos((alimit[0]+rot)*rotangle);
			y11 = y1;
			z11 = x1*sin((alimit[0]+rot)*rotangle);

			x12 = x1*cos(((alimit[0]+rot)+1)*rotangle);
			y12 = y1;
			z12 = x1*sin(((alimit[0]+rot)+1)*rotangle);


			x21 = x2*cos((alimit[0]+rot)*rotangle);
			y21 = y2;
			z21 = x2*sin((alimit[0]+rot)*rotangle);

			x22 = x2*cos(((alimit[0]+rot)+1)*rotangle);
			y22 = y2;
			z22 = x2*sin(((alimit[0]+rot)+1)*rotangle);

			
				if (wireframe)
				{
                    color("black") {
					PlaceLine([[x11,y11,z11], [x12,y12,z12]], radius =lineradius);
					PlaceLine([ [x12,y12,z12],[x22,y22,z22]], radius =lineradius);
					PlaceLine([[x22,y22,z22],[x21,y21,z21]], radius =lineradius);
					PlaceLine([[x21,y21,z21],[x11,y11,z11]], radius =lineradius);
                    }
				}

				if (faces)
				{
					polyhedron(
						points=[
							[x11,y11,z11],
							[x12,y12,z12],
							[x22,y22,z22],
							[x21,y21,z21]
						],
						faces = [
							[0,1,2],
							[0,2,3]
						]);
				}
			
		}
	}
}