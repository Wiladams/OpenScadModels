include <Renderer.scad>

// Borrowed from the tutorial found here:
// http://www.local-guru.net/blog/2010/09/19/pulsating-heart-made-from-bezier-curves-in-processing

//beginShape();
//vertex(150,150);
//bezierVertex( 150,120, 100,120, 100, 150);
//bezierVertex( 100,180, 150,185, 150, 210 );
//bezierVertex( 150,185, 200,180, 200, 150 );  
//bezierVertex( 200,120, 150,120, 150, 150 );  
//endShape();



gDemoSteps = 50;
gDemoHeight = 4;

translate([0, -150, 0])
DrawHeart(150);

module DrawHeart(pointDepth=150)
{
	BezFillet( [[0, pointDepth],[0,120],[-50,120],[-50,pointDepth]], [0,pointDepth], 
	gDemoSteps, gDemoHeight, [[1,0,0],[1,0,0],[1,1,1],[1,0,0]]);
	
	BezFillet( [[-50, pointDepth],[-50,180],[0,185],[0,210]], [0,pointDepth], 
	gDemoSteps, gDemoHeight, [[1,0,0],[1,0,0],[1,1,1],[1,0,0]]);
	
	BezFillet( [[0, 210],[0,185],[50,180],[50,pointDepth]], [0,pointDepth], 
	gDemoSteps, gDemoHeight,  [[1,0,0],[1,0,0],[1,1,1],[1,0,0]]);
	
	BezFillet( [[50, pointDepth],[50,120],[0,120],[0,pointDepth]], [0,pointDepth], 
	gDemoSteps, gDemoHeight,  [[1,0,0],[1,0,0],[1,1,1],[1,0,0]]);
}


//====================================
// Helpers
//====================================

module DrawCubicControlPoints(c, focalPoint, height) 
{
// Draw control points
// Start point
translate(c[0])
color([1,0,0])
cylinder(r=1, h=height+joinfactor);

// Controll point 1
translate(c[1])
color([0,0,0])
cylinder(r=1, h=height+joinfactor);

// Control point 2
translate(c[2])
color([0,0,0])
cylinder(r=1, h=height+joinfactor);

// End Point
translate(c[3])
color([0,0,1])
cylinder(r=1, h=height+joinfactor);


// Draw the focal point
translate(focalPoint)
color([0,1,0])
cylinder(r=1, h=height+joinfactor);
}