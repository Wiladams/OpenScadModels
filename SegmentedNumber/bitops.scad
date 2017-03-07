function bit(p) = pow(2,(p));
function _BTEST(x, abit) = x % (abit+abit) >= abit;
function BTEST(x, abit) = _BTEST(x, bit(abit));

function BIT(x, abit=0) = x % (bit(abit)+bit(abit)); 


//echo("5 :", BTEST(5,2), BTEST(5,1), BTEST(5,0));
//echo("5 :", BIT(5,2), BIT(5,1), BIT(5,0));

//=================================
// Bit manipulation
//=================================

function getdigit(x, pos=1) = floor(fract(x/pow(10,pos))*10);

function fract(x) = x - floor(x); 

function LSHIFT(x, pos=1, base=2) = x*pow(base,pos); 
function RSHIFT(x, pos=1, base=2) = floor(x/pow(base, pos));
function RSHIFTPART(x, pos=1, base=2) = x % pow(base, pos);
function lowbit(x, base=2) = x - LSHIFT(RSHIFT(x, base=base), base=base);

function BIT(x, pos=0, base=2) = lowbit(RSHIFT(x, pos,base), base=base);
//function BTEST(x, pos=0, base=2) = BIT(x,pos,base)>0;

