include <bezier.scad>

// Borrowed from the tutorial found here:
// http://www.local-guru.net/blog/2010/09/19/pulsating-heart-made-from-bezier-curves-in-processing

//beginShape();
//vertex(150,150);
//bezierVertex( 150,120, 100,120, 100, 150);
//bezierVertex( 100,180, 150,185, 150, 210 );
//bezierVertex( 150,185, 200,180, 200, 150 );  
//bezierVertex( 200,120, 150,120, 150, 150 );  
//endShape();



gDemoSteps = 100;
gDemoHeight = 4;

translate([-150, -150, 0])
DrawHeart();

module DrawHeart()
{
	BezCubicFilletColored( [[150, 150],[150,120],[100,120],[100,150]], [150,150], 
	gDemoSteps, gDemoHeight, [[1,0,0],[1,0,0],[1,1,1],[1,0,0]]);
	
	BezCubicFilletColored( [[100, 150],[100,180],[150,185],[150,210]], [150,150], 
	gDemoSteps, gDemoHeight, [[1,0,0],[1,0,0],[1,1,1],[1,0,0]]);
	
	BezCubicFilletColored( [[150, 210],[150,185],[200,180],[200,150]], [150,150], 
	gDemoSteps, gDemoHeight,  [[1,0,0],[1,0,0],[1,1,1],[1,0,0]]);
	
	BezCubicFilletColored( [[200, 150],[200,120],[150,120],[150,150]], [150,150], 
	gDemoSteps, gDemoHeight,  [[1,0,0],[1,0,0],[1,1,1],[1,0,0]]);
}
