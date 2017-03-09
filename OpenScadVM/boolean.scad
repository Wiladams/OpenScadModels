/*
	License: None
	This code is public domain

	Placed By: William A Adams
	31 Oct 2011
*/
// convenience for powers of 2 arithmetic
// Bits start counting from '0'
function bitval(pos) = pow(2,(pos)); 

// A quick check to see if a bit is set
// Does not work with negative numbers
function _BTEST(x, abit) = x % (abit+abit) >= abit; 
function BTEST(x, pos) = _BTEST(x, bitval(pos));

// Shift left by the specified number of positions
// Default is 1 postion.
// Equivalent to multiplying by 2
function LSHIFT(x, pos=1) = x*bitval(pos);

// Shift right by the specified number of positions
// Default is 1 position
// Equivalent to division by 2
function RSHIFT(x, pos=1) = floor(x/bitval(pos));

// Get the value of the lowest bit
// return as number '0' or '1'
function lowbit(x) = x-LSHIFT(RSHIFT(x));

// Get the value of a bit at a specific position
// return as number '0' or '1'
function BIT(x, pos=0) = lowbit(RSHIFT(x,pos));

// Invert the value of a bit
function BINV(a) = !a;

// Boolean Algebra
function BFALSE(a,b) = 0;
function BAND(a,b) = (a==1) && (b==1) ? 1 : 0;
function BA(a,b) = (a==1) ? 1 : 0;
function BB(a,b) = (b==1) ? 1 : 0;
function BXOR(a,b) = (a==b) ? 0 : 1;
function BOR(a,b) = (a==1) || (b==1) ? 1 : 0;
function BNOR(a,b) = (a==0) && (b==0);			// Peirce's arrow
function BXNOR(a,b) = a==b;
function BNOTB(a,b) = !b;
function BNOTA(a,b) = !a;
function BNAND(a, b) = (a==1) ? (b==1) ? 0 : 1 : 1;	// Sheffer stroke
function BTRUE(a,b) = 1;

// multi-bit operations
// a & b
function 32BITAND(a, b) = 
	LSHIFT(BAND(BIT(a,31), BIT(b,31)),31) +
	LSHIFT(BAND(BIT(a,30), BIT(b,30)),30) +
	LSHIFT(BAND(BIT(a,29), BIT(b,29)),29) +
	LSHIFT(BAND(BIT(a,28), BIT(b,28)),28) +
	LSHIFT(BAND(BIT(a,27), BIT(b,27)),27) +
	LSHIFT(BAND(BIT(a,26), BIT(b,26)),26) +
	LSHIFT(BAND(BIT(a,25), BIT(b,25)),25) +
	LSHIFT(BAND(BIT(a,24), BIT(b,24)),24)+
	LSHIFT(BAND(BIT(a,23), BIT(b,23)),23) +
	LSHIFT(BAND(BIT(a,22), BIT(b,22)),22) +
	LSHIFT(BAND(BIT(a,21), BIT(b,21)),21) +
	LSHIFT(BAND(BIT(a,20), BIT(b,20)),20) +
	LSHIFT(BAND(BIT(a,19), BIT(b,19)),19) +
	LSHIFT(BAND(BIT(a,18), BIT(b,18)),18) +
	LSHIFT(BAND(BIT(a,17), BIT(b,17)),17) +
	LSHIFT(BAND(BIT(a,16), BIT(b,16)),16)+
	LSHIFT(BAND(BIT(a,15), BIT(b,15)),15) +
	LSHIFT(BAND(BIT(a,14), BIT(b,14)),14) +
	LSHIFT(BAND(BIT(a,13), BIT(b,13)),13) +
	LSHIFT(BAND(BIT(a,12), BIT(b,12)),12) +
	LSHIFT(BAND(BIT(a,11), BIT(b,11)),11) +
	LSHIFT(BAND(BIT(a,10), BIT(b,10)),10) +
	LSHIFT(BAND(BIT(a,9), BIT(b,9)),9) +
	LSHIFT(BAND(BIT(a,8), BIT(b,8)),8)+
	LSHIFT(BAND(BIT(a,7), BIT(b,7)),7) +
	LSHIFT(BAND(BIT(a,6), BIT(b,6)),6) +
	LSHIFT(BAND(BIT(a,5), BIT(b,5)),5) +
	LSHIFT(BAND(BIT(a,4), BIT(b,4)),4) +
	LSHIFT(BAND(BIT(a,3), BIT(b,3)),3) +
	LSHIFT(BAND(BIT(a,2), BIT(b,2)),2) +
	LSHIFT(BAND(BIT(a,1), BIT(b,1)),1) +
	LSHIFT(BAND(BIT(a,0), BIT(b,0)),0);

// a & b
function 16BITAND(a, b) = 
	LSHIFT(BAND(BIT(a,15), BIT(b,15)),15) +
	LSHIFT(BAND(BIT(a,14), BIT(b,14)),14) +
	LSHIFT(BAND(BIT(a,13), BIT(b,13)),13) +
	LSHIFT(BAND(BIT(a,12), BIT(b,12)),12) +
	LSHIFT(BAND(BIT(a,11), BIT(b,11)),11) +
	LSHIFT(BAND(BIT(a,10), BIT(b,10)),10) +
	LSHIFT(BAND(BIT(a,9), BIT(b,9)),9) +
	LSHIFT(BAND(BIT(a,8), BIT(b,8)),8)+
	LSHIFT(BAND(BIT(a,7), BIT(b,7)),7) +
	LSHIFT(BAND(BIT(a,6), BIT(b,6)),6) +
	LSHIFT(BAND(BIT(a,5), BIT(b,5)),5) +
	LSHIFT(BAND(BIT(a,4), BIT(b,4)),4) +
	LSHIFT(BAND(BIT(a,3), BIT(b,3)),3) +
	LSHIFT(BAND(BIT(a,2), BIT(b,2)),2) +
	LSHIFT(BAND(BIT(a,1), BIT(b,1)),1) +
	LSHIFT(BAND(BIT(a,0), BIT(b,0)),0);

// a | b
function 32BITOR(a, b) = 
	LSHIFT(BOR(BIT(a,31), BIT(b,31)),31) +
	LSHIFT(BOR(BIT(a,30), BIT(b,30)),30) +
	LSHIFT(BOR(BIT(a,29), BIT(b,29)),29) +
	LSHIFT(BOR(BIT(a,28), BIT(b,28)),28) +
	LSHIFT(BOR(BIT(a,27), BIT(b,27)),27) +
	LSHIFT(BOR(BIT(a,26), BIT(b,26)),26) +
	LSHIFT(BOR(BIT(a,25), BIT(b,25)),25) +
	LSHIFT(BOR(BIT(a,24), BIT(b,24)),24)+
	LSHIFT(BOR(BIT(a,23), BIT(b,23)),23) +
	LSHIFT(BOR(BIT(a,22), BIT(b,22)),22) +
	LSHIFT(BOR(BIT(a,21), BIT(b,21)),21) +
	LSHIFT(BOR(BIT(a,20), BIT(b,20)),20) +
	LSHIFT(BOR(BIT(a,19), BIT(b,19)),19) +
	LSHIFT(BOR(BIT(a,18), BIT(b,18)),18) +
	LSHIFT(BOR(BIT(a,17), BIT(b,17)),17) +
	LSHIFT(BOR(BIT(a,16), BIT(b,16)),16)+
	LSHIFT(BOR(BIT(a,15), BIT(b,15)),15) +
	LSHIFT(BOR(BIT(a,14), BIT(b,14)),14) +
	LSHIFT(BOR(BIT(a,13), BIT(b,13)),13) +
	LSHIFT(BOR(BIT(a,12), BIT(b,12)),12) +
	LSHIFT(BOR(BIT(a,11), BIT(b,11)),11) +
	LSHIFT(BOR(BIT(a,10), BIT(b,10)),10) +
	LSHIFT(BOR(BIT(a,9), BIT(b,9)),9) +
	LSHIFT(BOR(BIT(a,8), BIT(b,8)),8)+
	LSHIFT(BOR(BIT(a,7), BIT(b,7)),7) +
	LSHIFT(BOR(BIT(a,6), BIT(b,6)),6) +
	LSHIFT(BOR(BIT(a,5), BIT(b,5)),5) +
	LSHIFT(BOR(BIT(a,4), BIT(b,4)),4) +
	LSHIFT(BOR(BIT(a,3), BIT(b,3)),3) +
	LSHIFT(BOR(BIT(a,2), BIT(b,2)),2) +
	LSHIFT(BOR(BIT(a,1), BIT(b,1)),1) +
	LSHIFT(BOR(BIT(a,0), BIT(b,0)),0);

// ~a
function 32BITNOT(a) = 
	LSHIFT(BINV(BIT(a,31)), 31) +
	LSHIFT(BINV(BIT(a,30)), 30) +
	LSHIFT(BINV(BIT(a,29)), 29) +
	LSHIFT(BINV(BIT(a,28)), 28) +
	LSHIFT(BINV(BIT(a,27)), 27) +
	LSHIFT(BINV(BIT(a,26)), 26) +
	LSHIFT(BINV(BIT(a,25)), 25) +
	LSHIFT(BINV(BIT(a,24)), 24) +
	LSHIFT(BINV(BIT(a,23)), 23) +
	LSHIFT(BINV(BIT(a,22)), 22) +
	LSHIFT(BINV(BIT(a,21)), 21) +
	LSHIFT(BINV(BIT(a,20)), 20) +
	LSHIFT(BINV(BIT(a,19)), 19) +
	LSHIFT(BINV(BIT(a,18)), 18) +
	LSHIFT(BINV(BIT(a,17)), 17) +
	LSHIFT(BINV(BIT(a,16)), 16) +
	LSHIFT(BINV(BIT(a,15)), 15) +
	LSHIFT(BINV(BIT(a,14)), 14) +
	LSHIFT(BINV(BIT(a,13)), 13) +
	LSHIFT(BINV(BIT(a,12)), 12) +
	LSHIFT(BINV(BIT(a,11)), 11) +
	LSHIFT(BINV(BIT(a,10)), 10) +
	LSHIFT(BINV(BIT(a,9)), 9) +
	LSHIFT(BINV(BIT(a,8)), 8) +
	LSHIFT(BINV(BIT(a,7)), 7) +
	LSHIFT(BINV(BIT(a,6)), 6) +
	LSHIFT(BINV(BIT(a,5)), 5) +
	LSHIFT(BINV(BIT(a,4)), 4) +
	LSHIFT(BINV(BIT(a,3)), 3) +
	LSHIFT(BINV(BIT(a,2)), 2) +
	LSHIFT(BINV(BIT(a,1)), 1) +
	LSHIFT(BINV(BIT(a,0)), 0) ;

// a ^ b
function 32BITXOR(a, b) = 
	LSHIFT(BXOR(BIT(a,31), BIT(b,31)),31) +
	LSHIFT(BXOR(BIT(a,30), BIT(b,30)),30) +
	LSHIFT(BXOR(BIT(a,29), BIT(b,29)),29) +
	LSHIFT(BXOR(BIT(a,28), BIT(b,28)),28) +
	LSHIFT(BXOR(BIT(a,27), BIT(b,27)),27) +
	LSHIFT(BXOR(BIT(a,26), BIT(b,26)),26) +
	LSHIFT(BXOR(BIT(a,25), BIT(b,25)),25) +
	LSHIFT(BXOR(BIT(a,24), BIT(b,24)),24)+
	LSHIFT(BXOR(BIT(a,23), BIT(b,23)),23) +
	LSHIFT(BXOR(BIT(a,22), BIT(b,22)),22) +
	LSHIFT(BXOR(BIT(a,21), BIT(b,21)),21) +
	LSHIFT(BXOR(BIT(a,20), BIT(b,20)),20) +
	LSHIFT(BXOR(BIT(a,19), BIT(b,19)),19) +
	LSHIFT(BXOR(BIT(a,18), BIT(b,18)),18) +
	LSHIFT(BXOR(BIT(a,17), BIT(b,17)),17) +
	LSHIFT(BXOR(BIT(a,16), BIT(b,16)),16)+
	LSHIFT(BXOR(BIT(a,15), BIT(b,15)),15) +
	LSHIFT(BXOR(BIT(a,14), BIT(b,14)),14) +
	LSHIFT(BXOR(BIT(a,13), BIT(b,13)),13) +
	LSHIFT(BXOR(BIT(a,12), BIT(b,12)),12) +
	LSHIFT(BXOR(BIT(a,11), BIT(b,11)),11) +
	LSHIFT(BXOR(BIT(a,10), BIT(b,10)),10) +
	LSHIFT(BXOR(BIT(a,9), BIT(b,9)),9) +
	LSHIFT(BXOR(BIT(a,8), BIT(b,8)),8)+
	LSHIFT(BXOR(BIT(a,7), BIT(b,7)),7) +
	LSHIFT(BXOR(BIT(a,6), BIT(b,6)),6) +
	LSHIFT(BXOR(BIT(a,5), BIT(b,5)),5) +
	LSHIFT(BXOR(BIT(a,4), BIT(b,4)),4) +
	LSHIFT(BXOR(BIT(a,3), BIT(b,3)),3) +
	LSHIFT(BXOR(BIT(a,2), BIT(b,2)),2) +
	LSHIFT(BXOR(BIT(a,1), BIT(b,1)),1) +
	LSHIFT(BXOR(BIT(a,0), BIT(b,0)),0);

