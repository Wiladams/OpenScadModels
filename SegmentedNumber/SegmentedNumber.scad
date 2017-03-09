/*
	This module creates seven segment display digits
*/

include <bitops.scad>


joinfactor = 0.01;
gap = 0.4;
digitwidth = 1;
digitdepth = 2;
scalar = 30;


/*
	segment

	An array of 2D coordinates which define the Outline
	for a single segment of the seven segement display.

	This single segment is laid out horizontally, and is
	centered around the origin.
*/
// Outline of a single segment

segment =[ 
	[-14/scalar, 0], 
	[-10/scalar, -4/scalar], 
	[10/scalar, -4/scalar], 
	[14/scalar, 0], 
	[10/scalar, 4/scalar], 
	[-10/scalar, 4/scalar]];

/*
	seglocs

	An array of translations and rotations which places
	each segment in the proper place in the seven segment
	display.


*/
// Take the template of a segment, and give appropriate
// translations and rotations to put it in place to form a number.
// for each segment there is a tuple:
// [trans], rot
// [trans] is a triplet that indicates the translation
// rot - is the angle of rotation around the z-axis

seglocs = [
	[[0,-1.0,0], 0],
	[[-0.5,-0.5,0],90],
	[[0.5,-0.5,0],90],
	[[0,0,0],0],
	[[-0.5,0.5,0],90],
	[[0.5,0.5,0],90],
	[[0,1.0,0],0]
];

/*
Digit Information

The seven segments of the display (left), 
each have the number indicated (right)
	 __			6
	|  |	4		5
	 --			3
	|  |	1		2
	 --			0

 A single 8-bit number is used to indicate which
 segments are active for any single digit.  If a bit
 is set, then that particular segment is active.
*/

DigitSegments = [
			119,	// 0	0111 0111
			36,		// 1	0010 0100
			107,	// 2	0110 1011
			109,	// 3	0110 1101
			60,		// 4	0011 1100
			93,		// 5
			95,		// 6
			100,	// 7
			127,	// 8
			125		// 9
			];


function value(astr)=search(astr,"0123456789")[0]; 

/*
	DisplayDigit

	Display a single digit
	iNumber - the single digit to Display
	height - how tall to make it, default to '1'
*/

module DisplayDigit(iNumber, height = 1)
{        
    for (iSeg = [0:6])
	{
		if (BTEST(DigitSegments[iNumber],iSeg))
        {
			linear_extrude(height=height, center=true) {
				translate(seglocs[iSeg][0])
				rotate(seglocs[iSeg][1])
				polygon(points = segment, paths = [[0,1,2,3,4,5]]);
			}
        }
	}
}

module DisplayNumber(number, height=1)
{
	digitstr = str(number);
	count = len(digitstr);
	echo("len: ", count);

	for (counter = [0:count-1])
	{
		digitchar = digitstr[counter];
		digitvalue = value(digitchar);
		
		echo(digitchar, " ", digitvalue);
		translate([counter*(digitwidth+gap),0,0])
		DisplayDigit(digitvalue, height);
	}
}

module RenderNumberPlate(number, thickness=1, height=1)
{
	digitstr = str(number);
	count = len(digitstr);
	platewidth = count*(digitwidth+gap)+2*gap;
	platedepth = digitdepth+2*gap;

	DisplayNumber(number, height);

	// Display the plate
	color([0.2, 0.7, 0.3])
	translate([-digitwidth/2-gap*2, -digitdepth/2-gap, -thickness-height/2+joinfactor])
	cube(size=[platewidth, platedepth, thickness]);
}
