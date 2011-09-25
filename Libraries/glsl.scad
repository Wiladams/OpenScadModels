pi = 3.14159;

/* 
// Already built into OpenScad
function abs(x)
function ceil(x)
function floor(x)
function max(x,y) = x>y ? x : y;
function min(x,y) = x<y ? x : y;


*/

/*
The following routines roughly map to those found in the 
OpenGL Shading language GLSL. They are largely convenience
routines, but very useful when doing image processing.
*/
function radians(degrees) = pi/180 * degrees;
function degrees(radians) = 180/pi * radians;

function fract(x) = x - floor(x);
function fract3(x) = [fract(x[0]), fract(x[1]), fract(x[2])];

function mix(x, y, a) = x*(1-a)+y*a;
function mix3(x, y,a) = [mix(x[0],y[0],a), mix(x[1],y[1],a), mix(x[2],y[2],a)];

function mod(x, y) = x-(y*floor(x/y));

function clamp(x, minValue, maxValue) = min(max(x,minValue),maxValue);
function clamp3(x, minValue, maxValue) = [clamp(x[0]), clamp(x[1]), clamp(x[2])];

function dot(v1,v2) = v1[0]*v2[0]+v1[1]*v2[1]+v1[2]*v2[2]; 

function step(edge, x) = x < edge ? 0 : 1;

