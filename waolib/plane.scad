// In order to calculate the normal for a plane, we first
// need the planar coefficients
function PlaneCoA(pt1, pt2, pt3) =  pt1[1]*(pt2[2]-pt3[2]) + pt2[1]*(pt3[2]-pt1[2])+pt3[1]*(pt1[2]-pt2[2]);
function PlaneCoB(pt1, pt2, pt3) =  pt1[2]*(pt2[0]-pt3[0]) + pt2[2]*(pt3[0]-pt1[0])+pt3[2]*(pt1[0]-pt2[0]);
function PlaneCoC(pt1, pt2, pt3) =  pt1[0]*(pt2[1]-pt3[1]) + pt2[0]*(pt3[1]-pt1[1])+pt3[0]*(pt1[1]-pt2[1]);
function PlaneCoD(pt1, pt2, pt3) =  (-pt1[0]*(pt2[1]*pt3[2]-pt3[1]*pt2[2])-pt2[0]*(pt3[1]*pt1[2]-pt1[1]*pt3[2])-pt3[0]*(pt1[1]*pt2[2]-pt2[1]*pt1[2]));

function PlaneNormal(pt1, pt2, pt3) = [PlaneCoA(pt1, pt2, pt3), PlaneCoB(pt1, pt2, pt3), PlaneCoC(pt1,pt2,pt3)];

function AngleRightSides(adjacent, opposite) =  atan(opposite/adjacent);
function RotationFromNormal(normal) = [
	AngleRightSides(normal[2],normal[1]), 
	AngleRightSides(normal[2],normal[0]), 
	AngleRightSides(normal[1],normal[0]) ];

// Calculation of Point on a plane takes the form
// Ax + By + Cz + D != 0
// < 0, then x,y,z is 'inside'
// > 0, then x,y,z is 'outside'
// == 0, then x,y,z is 'on' 
//function PointOnPlane(pt, plane) = pt[0] * PlaneCoA() + pt[1]*PlaneCoB() + pt[2]*PlaneCoC() + PlaneCoD();



//DisplayNormalRotationValues([10,10,10]);
//RenderNormal([10,10,10]);
RenderTrianglePatch([0,0,0],[10,0,0],[5,5,10]);

module DisplayNormalRotationValues(normal)
{
	echo("Normal: ", normal[0], normal[1], normal[2]);

	echo("Rot X: ", AngleRightSides(normal[2], normal[1]));

	echo("Rot Y: ", AngleRightSides(normal[2],normal[0]));

	echo("Rot Z: ", AngleRightSides(normal[1],normal[0]) );

}

module RenderNormal(normal)
{
	echo(RotationFromNormal(normal));

	rotate(RotationFromNormal(normal))	
	cylinder(r=1, h=5);
}

module RenderTrianglePatch(p1, p2, p3, height=4)
{
	echo("Normal: ", PlaneNormal(p1, p2, p3));

	RenderNormal( PlaneNormal(p1, p2, p3));

//	linear_extrude(height = height, convexity = 10) 
//	polygon( 
//		points=[p1, p2, p3],
//		paths=[[0,1,2,0]]
//	);
}
