include <Renderer.scad>
include <hermite.scad>


herm1 = [[0,0,0],  [10,0,0], [5,0,5], [3,0,-5]];
herm2 = [[0,0,0],  [10,0,0], [5,0,-15], [3,0,15]];
herm3 = [[0,0,0], [30,0,0], [0,0,-10], [0,0,10]];
herm4 = [[0,0,0], [10,0,0], [0,0,5], [0,0,-5]];

sweep1 = [[[0,0,0],[0,0,10]], [[0,25,0],[0,0,-10]]];
sweep2 = [[[0,0,0],[10,0,10]], [[10,25,15],[-10,0,-10]]];
sweep3 = [[0,0,0],[0,60,40],[0,25,-10], [0,10,-15]];

//sweep_hermite(herm3, sweep3, 
//	steps=12, 
//	thickness=3, 
//	showControlFrame=true);


//DisplayCubicCurve(M = cubic_hermite_M(), umult = 1, 
//	cps=herm4,
//	steps=20,
//	showNormals=true);

DisplayHermiteCurve(herm1, steps=10);
//DisplayHermiteCurve(herm2, steps=10);
//DisplayHermiteCurve(herm3, steps=10);
//DisplayHermiteCurve(sweep1, steps=10);
//DisplayHermiteCurve(sweep2, steps=10);

//DisplayBasis();



//=======================================
//		Modules
//=======================================


// 
// Not quite ready for prime time
// It doesn't quite make sense to interpolate the tangents
module linear_extrude_hermite(mesh, 
	colors=[[1,0,0],[1,1,0],[0,1,1],[0,0,1]], 
	steps=4, 
	thickness=1, 
	showControlFrame = false)
{
	if (showControlFrame)
		DisplayHermiteControlFrame(mesh, steps=steps);
	
	for (ustep = [0:steps-1])
	{
		for (vstep=[0:steps-1])
		{
			assign(ufrac1 = ustep/steps)
			assign(ufrac2 = (ustep+1)/steps)
			assign(vfrac1=vstep/steps)
			assign(vfrac2=(vstep+1)/steps)
			assign(quad = GetHermiteQuad(mesh, [ufrac1,vfrac1], [ufrac2,vfrac2]))
			{
				//color([acolor[0], acolor[1], acolor[2], ufrac1/vfrac2])
				color(berp(colors, vfrac1))
				PlaceQuad(quad);
				//DisplayQuadFrame(quad);
				//DisplayQuadShard(quad, thickness=thickness);
			}
		}
	}
}

module DisplayBasis()
{
	steps = 100;
	height = 100;
	width = 100;
	offset = width/steps;
	radius=1;
	
	for (step=[0:steps])
	{
		assign(u=step/steps)
		{
			translate([step*(offset), 0, 0])
			color([1,0,0])
			cylinder(r=radius, h=HERMp0(u)*height);
	
	
			translate([step*(offset), 10, 0])
			color([0,1,0])
			cylinder(r=radius, h=HERMm0(u)*height);
	
			translate([step*(offset), 20, 0])	
			rotate([180, 0,0])
			color([0,1,1])
			cylinder(r=radius, h=-HERMm1(u)*height);

			echo(HERMp1(u));
			translate([step*(offset), 30, 0])
			color([0,0,1])
			cylinder(r=radius, h=HERMp1(u)*height);
	
	
		}
	}
}



module DisplayHermiteControlFrame(mesh, steps=12)
{
	DisplayHermiteCurve(mesh[0]);
	DisplayHermiteCurve(mesh[1]);
	DisplayHermiteCurve(mesh[2]);
	DisplayHermiteCurve(mesh[3]);

}




