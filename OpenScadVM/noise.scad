include <boolean.scad>


//======================================
//  Functions
//======================================

// http://en.wikipedia.org/wiki/Random_Number_Generator
// This one looks simple, but requires you change state between 
// executions, which is not possible with OpenScad
function _get_random(m_z, m_w) = [m_z, m_w, (LSHIFT(m_z,16)) + m_w];


function get_random(seed) = get_random(
	36969 * (16BITAND(m_z, 65535)) + (RSHIFT(m_z,16)), 
	 18000 * (16BITAND(m_w,65535)) + (RSHIFT(m_w,16)));

//=============================== 
// Interpolators
//===============================
function _CubicInterpolate(P, Q, R, S, u) =
P*pow(u,3) + Q*pow(u,2) + R*u + S;

function CubicInterpolate(v0, v1, v2, v3, u) =
_Cubic_Interpolate(
P = (v3-v2) - (v0-v1),
Q = (v0 - v1) - (v3-v2) - (v0-v1),
R = v2 - v0,
S = v1);


//=============================== 
// Noise
//===============================
// 0x7fffffff (2147483647) == 0-30 bits
function _noise1(x) = (1.0 - (32BITAND((x*(x*x*15731 + 789221) + 1376312589),  2147483647)) / 1073741824);
function noise1(x) = _noise1(32BITXOR(LSHIFT(x,13),x));


function smoothednoise1(x) = noise1(x)/2 + noise1(x-1)/4 + noise1(x+1)/4;

//function interpolatednoise1(x) =
//intX = floor(x);
//fractX = x-intX;
//v1 = smoothednoise1(intX);
//v2 = smoothednoise1(intX+1);
//
//return CubicInterpolate(v1, v2, fractX);
