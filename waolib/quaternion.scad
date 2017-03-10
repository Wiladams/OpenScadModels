include <maths.h>

//=======================================
//		QUATERNION
//
// As a data structure, the quaternion is represented as:
// 	x, y, z, w
//=======================================
function quat_new(x, y, z, w) = [x, y, z, w];

function quat_identity() = [0,0,0,1];

function _quat(a, s, c) = 	
	[a[0]*s, 
	a[1]*s, 
	a[2]*s,
	c];

/*
	Function: quat

	Description: Create a quaternion which represents a rotation
	around a specified axis by a given angle.

	Parameters
		axis - vec3
		angle - The amount of rotation in degrees
*/
function quat(axis, angle) = _quat(
	VNORM(axis), 
	s=sin(angle/2), 
	c=cos(angle/2));

// Basic quaternion functions
function quat_add(q1, q2) = [q1[0]+q2[0], q1[1]+q2[1], q1[2]+q2[2], q1[3]+q2[3]];

function quat_adds(q1, s) = [q1[0], q1[1], q1[2], q1[3]+s];

function quat_sub(q1, q2) = [q1[0]-q2[0], q1[1]-q2[1], q1[2]-q2[2], q1[3]-q2[3]];

function quat_subs(q1, s) = [q1[0], q1[1], q1[2], q1[3]-s];

function scalar_sub_quat(s, q1) = [-q1[0], -q1[1], -q1[2], s-q1[3]];

// Multiply two quaternions
function quat_mult(a, r) = [
	a[1]*r[2] - a[2]*r[1] + r[3]*a[0] + a[3]*r[0],
	a[2]*r[0] - a[0]*r[2] + r[3]*a[1] + a[3]*r[1],
	a[0]*r[1] - a[1]*r[0] + r[3]*a[2] + a[3]*r[2],
	a[3]*r[3] - a[0]*r[0] - a[1]*r[1] - a[2]*r[2]
	];

function quat_mults(q1, s) = [q1[0]*s, q1[1]*s,q1[2]*s,q1[3]*s];

function quat_divs(q1, s) = [q1[0]/s, q1[1]/s,q1[2]/s,q1[3]/s];

function quat_neg(q1) = [-q1[0], -q1[1],-q1[2],-q1[3]];

function quat_dot(q1, q2) = q1[0]*q2[0]+q1[1]*q2[1]+q1[2]*q2[2]+ q1[3]*q2[3];

function quat_norm(q) = sqrt(q[0]*q[0]+q[1]*q[1]+q[2]*q[2]+q[3]*q[3]);
function quat_normalize(q) = q/quat_norm(q);

function quat_conj(q) = [-q[0], -q[1], -q[2], q[3]];

function quat_distance(q1, q2) = quat_norm(quat_sub(q1-q2));

// Converting quaternion to matrix4x4
function quat_to_mat4_s(q) = (vec4_lengthsqr(q)!=0) ? 2/vec4_lengthsqr(q) : 0; 
function quat_to_mat4_xyzs(q, s) = [q[0]*s,q[1]*s, q[2]*s];
function quat_to_mat4_X(xyzs, x) = xyzs*x;
function _quat_xyzsw(xyzs, w) = xyzs*w;
function _quat_XYZ(xyzs, q)= [
		quat_to_mat4_X(xyzs, q[0]),
		quat_to_mat4_X(xyzs, q[1]),
		quat_to_mat4_X(xyzs,q[2])
		];
 
function _quat_to_mat4(xyzsw, XYZ) = [
		[(1.0-(XYZ[1][1]+XYZ[2][2])),  (XYZ[0][1]-xyzsw[2]), (XYZ[0][2]+xyzsw[1]), 0], 

		[(XYZ[0][1]+xyzsw[2]), (1-(XYZ[0][0]+XYZ[2][2])), (XYZ[1][2]-xyzsw[0]), 0],
		[(XYZ[0][2]-xyzsw[1]), (XYZ[1][2]+xyzsw[0]), (1.0-(XYZ[0][0]+XYZ[1][1])), 0], 
		[0,  0, 0, 1]
		];


function quat_to_mat4(q) = _quat_to_mat4(
	_quat_xyzsw(quat_to_mat4_xyzs(q, quat_to_mat4_s(q)),q[3]), 
	_quat_XYZ(quat_to_mat4_xyzs(q, quat_to_mat4_s(q)), q));

function quat_cosom(p, q) = p.x*q.x+p.y*q.y+p.z*q.z+p.w*q.w;

function quat_slerp_factors(cosom, t) = ((1.0+cosom)>Cepsilon) ? 
							(((1.0-cosom)>Cepsilon) ? [sin((1.0-t)*acos(cosom))/ sin(acos(cosom)), sin(t*acos(cosom))/sin( acos(cosom))] : 
							[1.0-t, t]) : 		[sin((1.0-t)*Chalfpi), sin(t*Chalfpi)];
		
		
function quat_slerp1(p, q, f) = [
	f[0]*p[0]+f[1]*q[0],
	f[0]*p[1]+f[1]*q[1],
	f[0]*p[2]+f[1]*q[2],
	f[0]*p[3]+f[1]*q[3]
	];

function quat_slerp2(p, qt, f) = [
		f[0]*p[0]+f[1]*qt[0],
		f[0]*p[1]+f[1]*qt[1],
		f[0]*p[2]+f[1]*qt[2],
		pt[3]
	];

function _quat_slerp_adjust_q(p, q) = (quat_distance(p,q) > quat_distance(p,quat_neg(q))) ? quat_neg(q) : q;

function _quat_slerp1(p, q, t, cosom) = ((1.0+cosom)>Cepsilon) ? quat_slerp1(p,q, quat_slerp_factors(cosom, t)) : quat_slerp2(p, [-p[1], p[0], -p[3], p[2]], quat_slerp_factors(cosom, t));

function _quat_slerp(p, q, t) = _quat_slerp1(p,q,t,quat_cosom(p,q));

function quat_slerp(p, q, t) = _quat_slerp(p, _quat_slerp_adjust_q(p,q),t);
