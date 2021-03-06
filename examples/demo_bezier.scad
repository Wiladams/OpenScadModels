//=====================================
// This is public Domain Code
// Contributed by: William A Adams
//=====================================

include <Renderer.scad>
include <bezier.scad>


joinfactor = 0.125;

gDemoSteps = 200;
gDemoHeight =14;

//======================================
// Demos
//======================================
//BezCubicFilletColored( [[0, 15],[5,5],[10,5],[15,15]], [7.5,12], gDemoSteps, gDemoHeight, 
//	[[1,0,0],[1,1,0],[0,1,1],[0,0,1]]);

//BezCubicFilletColored( [[0, 15],[5,5],[10,5],[15,15]], [7.5,18], gSteps, gHeight, 
//	[[1,0,0],[0,1,0],[0,1,0],[0,0,1]]);
//DrawCubicControlPoints([[0, 15],[5,5],[10,5],[15,15]], [7.5,18], gHeight, $fn=12);

//BezCubicFillet( [[0, 5],[5,15],[10,3],[15,10]], [7.5,0], gSteps, gHeight);
//DrawCubicControlPoints( [[0, 5],[5,15],[10,3],[15,10]], [7.5,0], gHeight, $fn=12);

//BezCubicRibbon([[0,15],[6,13],[3,5],[15,0]], [[0,13],[6,11],[3,2],[13,0]]);


//BezCubicRibbonRotate([[0,15],[6,13],[3,5],[15,0]], [[0,13],[6,11],[3,2],[13,0]], $fn=100);

BezCubicRibbon3D(
	[[0,0,200],[100,100,100],[0,150,100],[-50,-100,200]],
	[[5,0,0],[105,105,0],[0,155,0],[-55,-100,0]]
	);



//PlotBEZ0(100,0);
//PlotBEZ1(100,4);
//PlotBEZ2(100,8);
//PlotBEZ3(100,12);
//PlotBez4Blending();

//===================================
// Modules
//===================================

module BezCubicRibbon3D(c1, c2, steps=gDemoSteps, colors=[[1,0,0],[1,1,0],[0,1,1],[0,0,1]])
{
	for (step=[0:steps-1]) 
	{
		acolor = berp(colors, step/steps);
        //echo("COLOR: ", acolor);
		color(acolor)
        linear_extrude(height = berp(c1, step/steps)[2], convexity = 10) 
		polygon(
			points=[
				berp(c1, step/steps),
				berp(c2, (step)/steps),
				berp(c2, (step+1)/steps),
				berp(c1, (step+1)/steps)],

			paths=[[0,1,2,3]]
	);
//				PointOnBezCubic2D(c1[0], c1[1], c1[2],c1[3], step/steps),
//				PointOnBezCubic2D(c2[0], c2[1], c2[2],c2[3], (step)/steps),
//				PointOnBezCubic2D(c2[0], c2[1], c2[2],c2[3], (step+1)/steps),
//				PointOnBezCubic2D(c1[0], c1[1], c1[2],c1[3], (step+1)/steps)],

}

}

module DrawCubicControlPoints(c, focalPoint, height)
{
	// Draw control points
	// Start point
	translate(c[0])
	color([1,0,0])
	cylinder(r=0.5, h=height+joinfactor);

	// Controll point 1
	translate(c[1])
	color([0,0,0])
	cylinder(r=0.5, h=height+joinfactor);

	// Control point 2
	translate(c[2])
	color([0,0,0])
	cylinder(r=0.5, h=height+joinfactor);

	// End Point
	translate(c[3])
	color([0,0,1])
	cylinder(r=0.5, h=height+joinfactor);


	// Draw the focal point
	translate(focalPoint)
	color([0,1,0])
	cylinder(r=0.5, h=height+joinfactor);
}

module PlotBEZ0(steps, offset=0)
{
	cubeSize = 1;
	cubeHeight = steps;

    color([0,0,1,0.5])
	for (step=[0:steps])
	{
		translate([cubeSize*step, offset, 0])
		cube(size=[cubeSize, cubeSize, Basis03(step/steps)*cubeHeight]);
	}	
}

module PlotBEZ1(steps, offset=0)
{
	cubeSize = 1;
	cubeHeight = steps;

    color([0,1,0,0.5])
	for (step=[0:steps])
	{
		translate([cubeSize*step, offset, 0])
		cube(size=[cubeSize, cubeSize, Basis13(step/steps)*cubeHeight]);
	}	
}

module PlotBEZ2(steps, offset=0)
{
	cubeSize = 1;
	cubeHeight = steps;

    color([1,0,0,0.5])
	for (step=[0:steps])
	{
		translate([cubeSize*step, offset, 0])
		cube(size=[cubeSize, cubeSize, Basis23(step/steps)*cubeHeight]);
	}	
}

module PlotBEZ3(steps, offset=0)
{
	cubeSize = 1;
	cubeHeight = steps;

    color([0,1,1,0.5])
	for (step=[0:steps])
	{
		translate([cubeSize*step, offset, 0])
		cube(size=[cubeSize, cubeSize, Basis33(step/steps)*cubeHeight]);
	}	
}

module PlotBez4Blending()
{
	sizing = 100;

	translate([0, 0, sizing + 10])
	PlotBEZ0(100);

	translate([sizing+10, 0, sizing + 10])
	PlotBEZ1(100);

	translate([0, 0, 0])
	PlotBEZ2(100);

	translate([sizing+10, 0, 0])
	PlotBEZ3(100);
}
