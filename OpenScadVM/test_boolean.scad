/* 
License: None
This code is public domain

Placed By: William A Adams
31 Oct 2011
*/

include <boolean.scad>

joinfactor = 0.00001;

//display_1_8();

scale([4,4,4])
display_binary(number=0, bits=4, withplate=true);
//display_binary(number=1, bits=4, withplate=true);
//display_binary(number=2, bits=4, withplate=true);
//display_binary(number=4, bits=4, withplate=true);
//display_binary(number=5, bits=4, withplate=true);

//scale([4,4,8])
//display_binary(number = 1964, bits = 12, withplate=true);

//display_binary(number = 198, bits = 12, withplate=true);
//test_lowbit();
//test_BIT();

module display_1_8()
{
	scale([8,8,8])
	{
		for (number = [0:8])
		{
			translate([0, 1.2*number, 0])
			display_binary(number = number, bits = 4, withplate=true);
		
		}
	}
}

module display_binary(number, bits)
{
	side = 1;
	gap = 0.1;

	for (pos = [0:bits-1])
	{
		if (BTEST(number, bits-1-pos))
		{
			translate([pos*(side+gap), 0, 0])
			cube(size=[side, side, side], center=true);
		} else
		{
			translate([pos*(side+gap), 0, 0])
			{
				difference()
				{
					cube(size=[side, side, side], center=true);
					
					cube(size=[side-gap, side-gap,side+gap], center=true);
//					cube(size=[side-gap, side-gap,side-gap], center=true);
				}
			}
		}
	}

	if (withplate)
	{
		translate([-side/2-gap, -side/2-gap, -gap-(side/2)+joinfactor])
		cube(size = [(side+gap)*bits+gap*2, (side+gap*2), gap]);
	}
}

module test_lowbit()
{
	echo(lowbit(3));
	echo(lowbit(2));
	echo(lowbit(5));

	echo(lowbit(5));

	echo(lowbit(RSHIFT(5)));

	echo(lowbit(RSHIFT(RSHIFT(5))));
}

module test_BIT()
{
	echo(BIT(5,0));
	echo(BIT(5,1));
	echo(BIT(5,2));
	
	echo(BTEST(5,0));
	echo(BTEST(5,1));
	echo(BTEST(5,2));
	
	
	echo("8: ", BIT(8,3), BIT(8,2), BIT(8,1), BIT(8,0));
	echo("7: ", BIT(7,3), BIT(7,2), BIT(7,1), BIT(7,0));
}

module test_algebra()
{
// Truth tables
//echo("AND  ", BAND(0,0), BAND(0,1), BAND(1,0), BAND(1,1));
//echo("XOR  ", BXOR(0,0), BXOR(0,1), BXOR(1,0), BXOR(1,1));
//echo("OR  ", BOR(0,0), BOR(0,1), BOR(1,0), BOR(1,1));
//echo("NOR  ", BNOR(0,0), BNOR(0,1), BNOR(1,0), BNOR(1,1));
//echo("XNOR  ", BXNOR(0,0), BXNOR(0,1), BXNOR(1,0), BXNOR(1,1));
//echo("NAND ", BNAND(0,0),BNAND(0,1),BNAND(1,0),BNAND(1,1));


//echo("32BITAND (3,6):  ", 32BITAND(3,6));
//echo("32BITAND (1,0):  ", 32BITAND(1,0));
//echo("32BITAND (7,5):  ", 32BITAND(7,5));

//
//echo("BITS (3): ", BIT(3,3), BIT(3,2), BIT(3,1), BIT(3,0));
//echo("BITS (6): ", BIT(6,3), BIT(6,2), BIT(6,1), BIT(6,0));

//echo(LSHIFT(BAND(BIT(3,3), BIT(6,3)),3));

//echo("pow 2, 0 ");
//
//cube();
}

