//===================================== 
// This is public Domain Code
// Contributed by: William A Adams
// May 2011
//=====================================

/*
	A set of math routines for graphics calculations

	There are many sources to draw from to create the various math
	routines required to support a graphics library.  The routines here
	were created from scratch, not borrowed from any particular 
	library already in existance.

	One great source for inspiration is the book:
		Geometric Modeling
		Author: Michael E. Mortenson

	This book has many great explanations about the hows and whys
	of geometry as it applies to modeling.

	As this file may accumulate quite a lot of routines, you can either
	include it whole in your OpenScad files, or you can choose to 
	copy/paste portions that are relevant to your particular situation.

	It is public domain code, simply to avoid any licensing issues.
*/

//=======================================
//				Constants
//=======================================
// a very small number
Cepsilon = 0.00000001;

// The golden mean 
Cphi = 1.61803399;

// PI
Cpi = 3.14159;
Chalfpi = Cpi/2;

//  If the number is really small, then just return zero
function clean(n) = (n < 0) ? ((n < -Cepsilon) ? 0 : n)  : 
			(n < Cepsilon) ? 0 : n; 

//=======================================
//
// 				Point Routines
//
//=======================================

// Create a point
function Point2D_Create(u,v) = [u,v]; 
function Point3D_Create(u,v,w) = [u,v,w];

// Create a homogenized point from a vec3
function point3_from_vec3(vec) = [vec[0], vec[1], vec[2], 1]; 
function vec3_from_point3(pt) = [pt[0], pt[1], pt[2]];
function vec2_from_point3(pt) = [pt[0], pt[1]];
function vec2_from_vec3(pt) = [pt[0], pt[1]];

//=======================================
//
// 				Vector Routines
//
//=======================================

// Basic vector routines
function vec2_add(v1, v2) =  [v1[0]+v2[0], v1[1]+v2[1]];
function vec3_add(v1, v2) =  [v1[0]+v2[0], v1[1]+v2[1], v1[2]+v2[2]];
function vec4_add(v1, v2) = [v1[0]+v2[0], v1[1]+v2[1], v1[2]+v2[2], v1[3]+v2[3]];


function vec2_mults(v, s) =  [v[0]*s, v[1]*s];
function vec3_mults(v, s) =  [v[0]*s, v[1]*s, v[2]*s];
function vec4_mults(v, s) =  [v[0]*s, v[1]*s, v[2]*s, v[3]*s];

function vec3_dot(v1,v2) = v1[0]*v2[0]+v1[1]*v2[1]+v1[2]*v2[2];
function vec4_dot(v1,v2) = v1[0]*v2[0]+v1[1]*v2[1]+v1[2]*v2[2]+v1[3]*v2[3];

function vec3_lengthsqr(v) = v[0]*v[0]+v[1]*v[1]+v[2]*v[2];
function vec4_lengthsqr(v) = v[0]*v[0]+v[1]*v[1]+v[2]*v[2]+v[3]*v[3];

// Sum of two vectors
function VSUM(v1, v2) = [v1[0]+v2[0], v1[1]+v2[1], v1[2]+v2[2]];

function VSUB(v1, v2) = [v1[0]-v2[0], v1[1]-v2[1], v1[2]-v2[2]];

function VMULT(v1, v2) = [v1[0]*v2[0], v1[1]*v2[1], v1[2]*v2[2]];

// Magnitude of a vector
// Gives the Euclidean norm
function VLENSQR(v) = (v[0]*v[0]+v[1]*v[1]+v[2]*v[2]);
function VLEN(v) = sqrt(VLENSQR(v));
function VMAG(v) = sqrt(v[0]*v[0]+v[1]*v[1]+v[2]*v[2]);


// Returns the unit vector associated with a vector
function VUNIT(v) = v/VMAG(v);
function VNORM(v) = v/VMAG(v);

// The scalar, or 'dot' product
// law of cosines
// if VDOT(v1,v2) == 0, they are perpendicular
function SPROD(v1,v2) = v1[0]*v2[0]+v1[1]*v2[1]+v1[2]*v2[2];
function VDOT(v1v2) = SPROD(v1v2[0], v1v2[1]);

// The vector, or Cross product
// Given an array that contains two vectors
function VPROD(vs) = [
	(vs[0][1]*vs[1][2])-(vs[1][1]*vs[0][2]), 
	(vs[0][2]*vs[1][0])-(vs[1][2]*vs[0][0]),
	(vs[0][0]*vs[1][1])-(vs[1][0]*vs[0][1])];
function VCROSS(v1, v2) = VPROD([v1,v2]);

// Calculate the angle between two vectors
function VANG(v1, v2) = acos(VDOT([v1,v2])/(VMAG(v1)*VMAG(v2)));

// Calculate the rotations necessary to take a polygon, and apply 
// the rotate() transform, and get the polygon to be perpendicular to 
// the specified vector.
function rotations(v) = [ 
	VANG([0,1,0], [0,v[1],v[2]]), 
	VANG([0,0,-1], [v[0],0,v[2]]), 
	VANG([1,0,0], [v[0], v[1],0])];

// Get the appropriate rotations to place a cylinder in world space 
// This is helpful when trying to place a 'line segment' in space
// Book: Essential Mathematics for Games and Interactive Applications (p.75)
function LineRotations(v) = [
	atan2(sqrt(v[0]*v[0]+v[1]*v[1]), v[2]), 
	0, 
	atan2(v[1], v[0])+90];

// The following are already provided in OpenScad, but are
// here for completeness
function VMULTS(v, s) = [v[0]*s, v[1]*s, v[2]*s];
function VDIVS(v,s) = [v[0]/s, v[1]/s, v[2]/s];
function VADDS(v,s) = [v[0]+s, v[1]+s, v[2]+s];
function VSUBS(v,s) = [v[0]-s, v[1]-s, v[2]-s];


// Some more convenience routines.  Not found in OpenScad, but primarily using OpenScad routines
function VMIN(v1,v2) = [min(v1[0],v2[0]), min(v1[1],v2[1]), min(v1[2], v2[2])];
function VMIN3(v1, v2, v3) = VMIN(VMIN(v1,v2),v3);
function VMIN4(v1, v2, v3, v4) = VMIN(VMIN3(v1, v2, v3), v4);

function VMAX(v1,v2) = [max(v1[0],v2[0]), max(v1[1],v2[1]), max(v1[2], v2[2])];
function VMAX3(v1, v2, v3) = VMAX(VMAX(v1,v2),v3);
function VMAX4(v1, v2, v3, v4) = VMAX(VMAX(v1, v2, v3), v4);


//=======================================
//
// 			MATRIX Routines
//
//=======================================
function MADD2X2(m1, m2) = [
	[m1[0][0]+m2[0][0],  m1[0][1]+m2[0][1]],
	[m1[1][2]+m2[1][0],  m1[1][1]+m2[1][1]]];

// Returns the determinant of a 2X2 matrix
// Matrix specified in row major order
function DETVAL2X2(m) = m[0[0]]*m[1[1]] - m[0[1]]*m[1[0]];

// Returns the determinant of a 3X3 matrix
function DETVAL(m) = 
	m[0[0]]*DETVAL2X2([ [m[1[1]],m[1[2]]], [m[2[1]],m[2[2]]] ]) - 
	m[0[1]]*DETVAL2X2([ [m[1[0]],m[1[2]]], [m[2[0]],m[2[2]]] ]) + 
	m[0[2]]*DETVAL2X2([ [m[1[0]],m[1[1]]], [m[2[0]],m[2[1]]] ]);

//=========================================
//	Matrix 4X4 Operations
//
// Upper left 3x3 == scaling, shearing, reflection, rotation (linear transformations)
// Upper right 3x1 == translation
// Lower left 1x3 ==  Perspective transformation
// Lower right 1x1 == overall scaling
//
// Note that the data is stored in a single large array
// which is column ordered.
//=========================================
m400 = 0; m401=4; m402=8;   m403=12;
m410 = 1; m411=5; m412=9;   m413=13;
m420 = 2; m421=6; m422=10; m423=14;
m430 = 3; m431=7; m432=11; m433=15;

function mat3_to_mat4(m) = [
	[m[0][0], m[0][1], m[0][2], 0],
	[m[1][0], m[1][1], m[1][2], 0],
	[m[2][0], m[2][1], m[2][2], 0],
	[m[3][0], m[3][1], m[3][2], 1],
];
 
function mat4_identity() = [
	[1, 0, 0, 0],  
	[0, 1, 0, 0],
	[0, 0, 1, 0],
	[0, 0, 0, 1]];


function mat4_transpose(m) = [
	mat4_col(m,0),
	mat4_col(m,1),
	mat4_col(m,2),
	mat4_col(m,3)
	];

function mat4_col(m, col) = [
	m[0][col],
	m[1][col],
	m[2][col],
	m[3][col]
	];

function mat4_row(m, row) = m[row];


function mat4_add(m1, m2) = m1 + m2;

// Multiply two 4x4 matrices together
// This is one of the workhorse mechanisms of the 
// graphics system
function mat4_mult_mat4(m1, m2) = [
	[vec4_dot(m1[0], mat4_col(m2,0)),
	vec4_dot(m1[0], mat4_col(m2,1)),
	vec4_dot(m1[0], mat4_col(m2,2)),
	vec4_dot(m1[0], mat4_col(m2,3))],

	[vec4_dot(m1[1], mat4_col(m2,0)),
	vec4_dot(m1[1], mat4_col(m2,1)),
	vec4_dot(m1[1], mat4_col(m2,2)),
	vec4_dot(m1[1], mat4_col(m2,3))],
	
	[vec4_dot(m1[2], mat4_col(m2,0)),
	vec4_dot(m1[2], mat4_col(m2,1)),
	vec4_dot(m1[2], mat4_col(m2,2)),
	vec4_dot(m1[2], mat4_col(m2,3))],

	[vec4_dot(m1[3], mat4_col(m2,0)),
	vec4_dot(m1[3], mat4_col(m2,1)),
	vec4_dot(m1[3], mat4_col(m2,2)),
	vec4_dot(m1[3], mat4_col(m2,3))],
];

// This is the other workhorse routine
// Most transformations are of a vector and 
// a transformation matrix.
function vec4_mult_mat4(vec, mat) = [
	vec4_dot(vec, mat4_col(mat,0)), 
	vec4_dot(vec, mat4_col(mat,1)), 
	vec4_dot(vec, mat4_col(mat,2)), 
	vec4_dot(vec, mat4_col(mat,3)), 
	];

function vec4_mult_mat34(vec, mat) = [
	vec4_dot(vec, mat4_col(mat,0)), 
	vec4_dot(vec, mat4_col(mat,1)), 
	vec4_dot(vec, mat4_col(mat,2))
	];


// Linear Transformations
//	Translate
function transform_translate(xyz) = [
	[1, 0, 0, xyz[0]],
	[0, 1, 0, xyz[1]],
	[0, 0, 1, xyz[2]],
	[0, 0, 0, 1]
	];

// 	Scale
function  transform_scale(xyz) = [
	[xyz[0],0,0,0],
	[0,xyz[1],0,0],
	[0,0,xyz[2],0],
	[0,0,0,1]
	];

//	Rotation
function transform_rotx(angle) = [
	[1, 0, 0, 0],
	[0, cos(angle), -sin(angle), 0],
	[0, sin(angle), cos(angle), 0],
	[0, 0, 0, 1]
	];

function  transform_rotz(deg) = [
	[cos(deg), -sin(deg), 0, 0],
	[sin(deg), cos(deg), 0, 0],
	[0, 0, 1, 0],
	[0, 0, 0, 1]
	];

function  transform_roty(deg) = [
	[cos(deg), 0, sin(deg), 0],
	[0, 1, 0, 0],
	[-sin(deg), 0, cos(deg), 0],
	[0, 0, 0, 1]
	];






//=======================================
//
// 			Helper Routines
//
//=======================================

function AvgThree(v1,v2,v3) = (v1+v2+v3)/3; 
function AvgFour(v1,v2,v3,v4) = (v1+v2+v3+v4)/4;

function CenterOfGravity3(p0, p1, p2) = [
	AvgThree(p0[0], p1[0], p2[0]), 
	AvgThree(p0[1], p1[1], p2[1]), 
	AvgThree(p0[2], p1[2], p2[2])];
function CenterOfGravity4(p0, p1, p2, p3) = [
	AvgThree(p0[0], p1[0], p2[0], p3[0]), 
	AvgThree(p0[1], p1[1], p2[1], p3[1]), 
	AvgThree(p0[2], p1[2], p2[2], p3[2])];

function lerp1( p0, p1, u) = (1-u)*p0 + u*p1;
function lerp(v1, v2, u) = [
	lerp1(v1[0], v2[0],u),
	lerp1(v1[1], v2[1],u),
	lerp1(v1[2], v2[2],u)
	];

//=======================================
//
//		Cubic Curve Routines
//
//=======================================
function quadratic_U(u) = [3*(u*u), 2*u, 1, 0];
function cubic_U(u) = [u*u*u, u*u, u, 1];

function ccerp(U, M, G) = vec4_mult_mat34(vec4_mult_mat4(U, M), G); 


function cubic_hermite_M() = [ 
	[2, -2, 1, 1],
	[-3, 3, -2, -1],
	[0, 0, 1, 0],
	[1, 0, 0, 0]
	];

function cubic_bezier_M() = [
	[-1, 3, -3, 1],
	[3, -6, 3, 0],
	[-3, 3, 0, 0],
	[1, 0, 0, 0]
	];

function cubic_catmullrom_M() = [
	[-1, 3, -3, 1],
	[2, -5, 4, -1],
	[-1, 0, 1, 0],
	[0, 2, 0, 0]
	];

/*
	To use the B-spline, you must use a multiplier of 1/6 on the matrix itself
	Also, the parameter matrix is
	[(t-ti)^3, (t-ti)^2, (t-ti), 1]

	and the geometry is

	[Pi-3, Pi-2, Pi-1, Pi]
	
	Reference: http://spec.winprog.org/curves/
*/

function cubic_bspline_M() = [
	[-1, 2, -3, 1],
	[3, -6, 3, 0],
	[-3, 0, 3, 0],
	[1, 4, 1, 0],
	];


