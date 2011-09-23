/*
	Zome
*/

// golden ratio
Ctau = (sqrt(5)+1)/2;
Ctau2 = Ctau*Ctau;

// Some useful trigonometry
sin60 = sqrt(3)/2;
sin72 = sqrt(2+Ctau)/2;

// 
// Function: zomestrut
//
// Description: 
//	Calculate the length of any strut in the Zome system.  
//
// Parameters:
//	index - Which exponent of strut (b1 = 1, b2 = 2, etc)
//	base - What is the base length of the strut, default is '1'
//	factor - Determines whether it is a 'blue' (1), 'yellow' (sin60), or 'red' (sin72) strut
//
// Notes
//	In the Zometool construction set, there are three colors of struts in three
//	lengths.  
//	b1, b2, b3
//	y1, y2, y3
//	r1, r2, r3
//
//	These strut lengths can be easily calculated using the zomestrut() function.
//	You can calculate new strut lengths either by varying the base, or by varying
//	the index.
//
function zomestrut(index=1, base=1, factor=1) = base*  pow(Ctau, index-1)*factor;

// These are for convenience.  The factor is associated with the color
function bluestrut(index=1, base=1) = zomestrut(index, base=base, factor=1);
function yellowstrut(index=1, base=1) = zomestrut(index, base, factor=sin60);
function redstrut(index=1, base=1) = zomestrut(index, base, factor=sin72);

