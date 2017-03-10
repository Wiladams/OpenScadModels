include <maths.scad>

//=======================================
//
//		Bezier Curve Routines
//
//=======================================

 /* 
	Bernstein Basis Functions
	These are the coefficients for bezier curves

*/

// For quadratic curve (parabola)
function Basis02(u) = pow((1-u), 2);
function Basis12(u) = 2*u*(1-u);
function Basis22(u) = u*u;

// For cubic curves, these functions give the weights per control point.
function Basis03(u) = pow((1-u), 3);
function Basis13(u) = 3*u*(pow((1-u),2));
function Basis23(u) = 3*(pow(u,2))*(1-u);
function Basis33(u) = pow(u,3);


// Given an array of control points
// Return a point on the quadratic Bezier curve as specified by the 
// parameter: 0<= 'u' <=1
function Bern02(cps, u) = [Basis02(u)*cps[0][0], Basis02(u)*cps[0][1], Basis02(u)*cps[0][2]];
function Bern12(cps, u) = [Basis12(u)*cps[1][0], Basis12(u)*cps[1][1], Basis12(u)*cps[1][2]];
function Bern22(cps, u) = [Basis22(u)*cps[2][0], Basis22(u)*cps[2][1], Basis22(u)*cps[2][2]];

function berp2(cps, u) = Bern02(cps,u)+Bern12(cps,u)+Bern22(cps,u);

//===========
// Cubic Beziers - described by 4 control points
//===========
// Calculate a singe point along a cubic bezier curve
// Given a set of 4 control points, and a parameter 0 <= 'u' <= 1
// These functions will return the exact point on the curve
function PtOnBez2D(p0, p1, p2, p3, u) = [
	Basis03(u)*p0[0]+Basis13(u)*p1[0]+Basis23(u)*p2[0]+Basis33(u)*p3[0],
	Basis03(u)*p0[1]+Basis13(u)*p1[1]+Basis23(u)*p2[1]+Basis33(u)*p3[1]];

// Given an array of control points
// Return a point on the cubic Bezier curve as specified by the 
// parameter: 0<= 'u' <=1
function Bern03(cps, u) = [Basis03(u)*cps[0][0], Basis03(u)*cps[0][1], Basis03(u)*cps[0][2]];
function Bern13(cps, u) = [Basis13(u)*cps[1][0], Basis13(u)*cps[1][1], Basis13(u)*cps[1][2]];
function Bern23(cps, u) = [Basis23(u)*cps[2][0], Basis23(u)*cps[2][1], Basis23(u)*cps[2][2]];
function Bern33(cps, u) = [Basis33(u)*cps[3][0], Basis33(u)*cps[3][1], Basis33(u)*cps[3][2]];

function berp(cps, u) = Bern03(cps,u)+Bern13(cps,u)+Bern23(cps,u)+Bern33(cps,u);

// Calculate a point on a Bezier mesh
// Given the mesh, and the parametric 'u', and 'v' values
function berpm(mesh, uv) = berp(
	[berp(mesh[0], uv[0]), berp(mesh[1], uv[0]),
	berp(mesh[2], uv[0]), berp(mesh[3], uv[0])], 
	uv[1]);



//========================================
// Bezier Mesh normals
//========================================

// The following uses a partial derivative at each point.
// It is very expensive.
// For each point, calculate a partial derivative in both 'u' and 'v' directions, then do a cross
// product between those two to get the normal vector

// Partial derivative in the 'u' direction
function Bern03du(mesh, uv) = (Basis02(uv[0]) *  Basis03(uv[1])  *  (mesh[0][1]-mesh[0][0])) + 
					(Basis12(uv[0]) *  Basis03(uv[1])  *  (mesh[0][2]-mesh[0][1]))+
					(Basis22(uv[0]) *  Basis03(uv[1])  *  (mesh[0][3]-mesh[0][2]));


function Bern13du(mesh, uv) = ( Basis02(uv[0]) *  Basis13(uv[1])  *  (mesh[1][1]-mesh[1][0])) +
					 ( Basis12(uv[0]) *  Basis13(uv[1])  *  (mesh[1][2]-mesh[1][1])) +
					 ( Basis22(uv[0]) *  Basis13(uv[1])  *  (mesh[1][3]-mesh[1][2]));

function Bern23du(mesh, uv) = (Basis02(uv[0]) *  Basis23(uv[1])  *  (mesh[2][1]-mesh[2][0])) +
					(Basis12(uv[0]) *  Basis23(uv[1])  *  (mesh[2][2]-mesh[2][1])) +
					(Basis22(uv[0]) *  Basis23(uv[1])  *  (mesh[2][3]-mesh[2][2]));

function Bern33du(mesh, uv) =  (Basis02(uv[0]) *  Basis33(uv[1])  *  (mesh[3][1]-mesh[3][0])) +
					(Basis12(uv[0]) *  Basis33(uv[1])  *  (mesh[3][2]-mesh[3][1])) +
					(Basis22(uv[0]) *  Basis33(uv[1])  *  (mesh[3][3]-mesh[3][2]));


// Partial derivative in the 'v' direction
function Bern03dv(mesh, uv) = (Basis02(uv[1]) *  Basis03(uv[0])  *  (mesh[1][0]-mesh[0][0])) + 
					(Basis12(uv[1]) *  Basis03(uv[0])  *  (mesh[2][0]-mesh[1][0]))+
					(Basis22(uv[1]) *  Basis03(uv[0])  *  (mesh[3][0]-mesh[2][0]));


function Bern13dv(mesh, uv) = ( Basis02(uv[1]) *  Basis13(uv[0])  *  (mesh[1][1]-mesh[0][1])) +
					 ( Basis12(uv[1]) *  Basis13(uv[0])  *  (mesh[2][1]-mesh[1][1])) +
					 ( Basis22(uv[1]) *  Basis13(uv[0])  *  (mesh[3][1]-mesh[2][1]));

function Bern23dv(mesh, uv) = (Basis02(uv[1]) *  Basis23(uv[0])  *  (mesh[1][2]-mesh[0][2])) +
					(Basis12(uv[1]) *  Basis23(uv[0])  *  (mesh[2][2]-mesh[1][2])) +
					(Basis22(uv[1]) *  Basis23(uv[0])  *  (mesh[3][2]-mesh[2][2]));

function Bern33dv(mesh, uv) =  (Basis02(uv[1]) *  Basis33(uv[0])  *  (mesh[1][3]-mesh[0][3])) +
					(Basis12(uv[1]) *  Basis33(uv[0])  *  (mesh[2][3]-mesh[1][3])) +
					(Basis22(uv[1]) *  Basis33(uv[0])  *  (mesh[3][3]-mesh[2][3]));



function Bern3du(mesh, uv) = Bern03du(mesh, uv) + Bern13du(mesh, uv) + Bern23du(mesh, uv) + Bern33du(mesh, uv);
function Bern3dv(mesh, uv) = Bern03dv(mesh, uv) + Bern13dv(mesh, uv) + Bern23dv(mesh, uv) + Bern33dv(mesh, uv);


// Calculate the normal at a specific u/v on a Bezier patch
function nberpm(mesh, uv) = VUNIT(VPROD([Bern3du(mesh, uv), Bern3dv(mesh, uv)]));





// Given a mesh of control points, and an array that contains the 
// row and column of the quad we want, return the quad as an 
// ordered set of points. The winding will be counter clockwise
function GetControlQuad(mesh, rc) = [ 
	mesh[rc[0]+1][rc[1]], 
	mesh[rc[0]][rc[1]], 
	mesh[rc[0]][rc[1]+1], 
	mesh[rc[0]+1][rc[1]+1]
	];


// Given a mesh, and the 4 parametric points, return a quad that has the appropriate 
// points along the curve, in counter clockwise order
function GetCurveQuad(mesh, u1v1, u2v2) = [
	berpm(mesh, [u1v1[0],u2v2[1]]), 
	berpm(mesh, u1v1),
	berpm(mesh, [u2v2[0],u1v1[1]]), 
	berpm(mesh, u2v2)];

function GetCurveQuadNormals(mesh, u1v1, u2v2) = [[ 
	berpm(mesh, [u1v1[0],u2v2[1]]), 
	berpm(mesh, u1v1),
	berpm(mesh, [u2v2[0],u1v1[1]]), 
	berpm(mesh, u2v2),
	],[
	nberpm(mesh, [u1v1[0],u2v2[1]]), 
	nberpm(mesh, u1v1),
	nberpm(mesh, [u2v2[0],u1v1[1]]), 
	nberpm(mesh, u2v2),
	]];


//=======================================
//
//		Hermite Curve Routines
//
//=======================================

/* 
Hermite Curve Basis Functions
Expressed in terms of cubic Bernstein basis functions

For cubic Hermite curves
these functions give the weights per control point.

http://en.wikipedia.org/wiki/Cubic_Hermite_spline
*/

// To express in terms of Bernstein cubic basis functions
function HERMp0(u) = Basis03(u)+Basis13(u); 	// h00
function HERMm0(u) = 1/3 * Basis13(u); 		// h10
function HERMp1(u) = Basis33(u) + Basis23(u); 	// h01
function HERMm1(u) = -1/3 * Basis23(u); 		// h11


// Given an array of control points
// Return a point on the Hermite curve as specified by the 
// parameter: 0<= 'u' <=1
function herp1(cps, u) = HERMp0(u)*cps[0] + HERMm0(u)*cps[1] + HERMp1(u)*cps[2] + HERMm1(u)*cps[3];

// Hermite Interpolation
function herp(cps, u) = [herp1([cps[0][0][0], cps[0][1][0], cps[1][0][0], cps[1][1][0]]),
				herp1([cps[0][0][1], cps[0][1][1], cps[1][0][1], cps[1][1][1]]),
				herp1([cps[0][0][2], cps[0][1][2], cps[1][0][2], cps[1][1][2]])];

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

// Given a first hermite curve, 'cpsu'
// and a second hermite curve 'cpsv'
// sweep the first, cpsu, along the second cpsv
// Calculate a patch for the given u,v parameters
function GetHermSweepQuad(cpsu, cpsv, uv1, uv2) = [
	herp(cpsu, uv1[0])+herp(cpsv, uv1[1]),
	herp(cpsu, uv2[0])+herp(cpsv, uv1[1]),
	herp(cpsu, uv2[0])+herp(cpsv, uv2[1]),
	herp(cpsu, uv1[0])+herp(cpsv, uv2[1])
	];