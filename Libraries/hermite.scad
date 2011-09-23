//=======================================
//
//		Hermite Curve Routines
//
//=======================================

include <maths.scad>

 /* 
	Hermite Curve Basis Functions
	Expressed in terms of cubic Bernstein basis functions

	For cubic Hermite curves
	these functions give the weights per control point.

http://en.wikipedia.org/wiki/Cubic_Hermite_spline
*/

// To express in terms of Bernstein cubic basis functions
function HERMp0(u) = Basis03(u)+Basis13(u);	// h00
function HERMm0(u) = 1/3 * Basis13(u);		// h10
function HERMp1(u) = Basis33(u) + Basis23(u);	// h01
function HERMm1(u) = -1/3 * Basis23(u);		// h11





// Given an array of control points
// Return a point on the Hermite curve as specified by the 
// parameter: 0<= 'u' <=1
function HermA(cps, u) = [HERMp0(u)*cps[0][0][0], HERMp0(u)*cps[0][0][1], HERMp0(u)*cps[0][0][2]];		// p0
function HermB(cps, u) = [HERMm0(u)*cps[0][1][0], HERMm0(u)*cps[0][1][1], HERMm0(u)*cps[0][1][2]];	// m0
function HermC(cps, u) = [HERMp1(u)*cps[1][0][0], HERMp1(u)*cps[1][0][1], HERMp1(u)*cps[1][0][2]];		// p1
function HermD(cps, u) = [HERMm1(u)*cps[1][1][0], HERMm1(u)*cps[1][1][1], HERMm1(u)*cps[1][1][2]];	// m1



// Hermite Interpolation
function herp(cps, u) = HermA(cps,u)+HermB(cps,u)+HermC(cps,u)+HermD(cps,u);

// Calculate a point on a Hermite mesh
// Given the mesh, and the parametric 'u', and 'v' values
function herpm(mesh, uv) = herp(
	[herp(mesh[0], uv[0]), herp(mesh[1], uv[0]),
	herp(mesh[2], uv[0]), herp(mesh[3], uv[0])], 
	uv[1]);


// Given a mesh, and the 4 parametric points, return a quad that has the appropriate 
// points along the curve, in counter clockwise order
function GetHermiteQuad(mesh, u1v1, u2v2) = [
	herpm(mesh, [u1v1[0],u2v2[1]]), 
	herpm(mesh, u1v1),
	herpm(mesh, [u2v2[0],u1v1[1]]), 
	herpm(mesh, u2v2)];
