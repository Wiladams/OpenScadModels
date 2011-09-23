joinfactor = 0.125;
goldenratio = 1.61803399;

gThickness = 1/4 * 25.4;
gRoundingRadius = 1/2/2*25.4;

gStandardWidth = 2.75*25.4;
g1GangWidth = 2.75*25.4;
g2GangWidth = 4.5*25.4;
gStandardHeight = 4.5 * 25.4;

gFixtureHoleDistance = 2.375*25.4;		// The separation between holes when a fixture is being covered
gFixtureHoleIR =5/32/2*25.4;
gFixtureHoleOR = 6.75/2;

gLightSwitchHeight = 0.942*25.4;		// The height of a light switch
gLightSwitchWidth = 0.406 * 25.4;		// The width of a light switch

//
// Examples
//
//roundedplate(gStandardWidth, gStandardHeight, gThickness);

//plug_nema5();
//outlet_nema5_15();
//Duplex_Standard_ngang(1);

//Switch();
//Toggle_Standard_ngang(1);
//Toggle_Standard_ngang(3);

//GFCI();
GFCI_Standard_ngang(2);

//Toggle_Duplex_Standard();


//===============================
//  Modules
//===============================
module roundedplate(width, height, thickness)
{
	smooth = 12;

	difference()
	{
		cube([width, height, thickness], center=true);

		translate([0, -height/2+gRoundingRadius, thickness/2-gRoundingRadius])
		{
			difference()
			{
				translate([0, -gRoundingRadius+joinfactor, gRoundingRadius+joinfactor])
				cube([width+joinfactor*2, gRoundingRadius*2+joinfactor, gRoundingRadius*2+joinfactor], center=true);

				rotate([0, 90, 0])
				cylinder(r=gRoundingRadius, h=width+4*joinfactor, center=true, $fn=smooth);
			}
		}

		translate([0, height/2-gRoundingRadius, thickness/2-gRoundingRadius])
		{
			difference()
			{
				translate([0, gRoundingRadius-joinfactor, gRoundingRadius+joinfactor])
				cube([width+joinfactor*2, gRoundingRadius*2+joinfactor, gRoundingRadius*2+joinfactor], center=true);

				rotate([0, 90, 0])
				cylinder(r=gRoundingRadius, h=width+4*joinfactor, center=true, $fn=smooth);
			}
		}


		// Negative X along Y
		translate([-width/2+gRoundingRadius, 0, thickness/2-gRoundingRadius])
		{
			difference()
			{
				translate([-gRoundingRadius+joinfactor, 0, gRoundingRadius+joinfactor])
				cube([gRoundingRadius*2+joinfactor, height+joinfactor*2, gRoundingRadius*2+joinfactor], center=true);

				rotate([90, 0, 0])
				cylinder(r=gRoundingRadius, h=height+4*joinfactor, center=true, $fn=smooth);
			}
		}

		// Positive X along Y
		translate([width/2-gRoundingRadius, 0, thickness/2-gRoundingRadius])
		{
			difference()
			{
				translate([gRoundingRadius-joinfactor, 0, gRoundingRadius+joinfactor])
				cube([gRoundingRadius*2+joinfactor, height+joinfactor*2, gRoundingRadius*2+joinfactor], center=true);

				rotate([90, 0, 0])
				cylinder(r=gRoundingRadius, h=height+4*joinfactor, center=true, $fn=smooth);
			}
		}
	}
}

// A screw with a tapered head.  Used to subtract screw holes from the plate
module insetscrew()
{
	translate([0, 0, 0])
	cylinder(r=gFixtureHoleIR, h=gThickness+2*joinfactor, center=true, $fn = 12);

	translate([0,0, 0])
	cylinder(r1=gFixtureHoleIR, r2=gFixtureHoleOR, h=gThickness/2+joinfactor, $fn = 12);
}

//==============================================
// Toggle Switch
//==============================================

module Switch()
{
	union()
	{
		cube(size=[gLightSwitchWidth, gLightSwitchHeight, gThickness+2*joinfactor], center=true);

		translate([0, gFixtureHoleDistance/2, 0])
		insetscrew();

		translate([0, -gFixtureHoleDistance/2, 0])
		insetscrew();
	}	
}

module Toggle_Standard_ngang(gangs)
{
	edge = (1+3/8)*25.4;
	toggleseparation = 1.75 * 25.4;

	width = edge*2+((gangs-1)*toggleseparation);
	height = gStandardHeight;
	thickness = gThickness;

	difference()
	{
		translate([width/2, 0, 0])
		roundedplate(width, height, thickness);
	
		for (plate=[0:gangs-1])
		{
			translate([edge +plate*toggleseparation, 0, 0])
			Switch();
		}
	}
}

//===================================
// Nema 5 Plug
//===================================

module plug_nema5()
{
	plugradius = ((1+3/8)*25.4)/2;
	flatradius = ((1+1/8)*25.4)/2;

	difference()
	{
		cylinder(r=plugradius, h=gThickness+2*joinfactor, center=true);
	
		translate([0, plugradius/2 +flatradius, 0])
		cube(size=[plugradius*2, plugradius, gThickness+4*joinfactor], center=true);

		translate([0, -plugradius/2 -flatradius, 0])
		cube(size=[plugradius*2, plugradius, gThickness+4*joinfactor], center=true);
	}
}

module outlet_nema5_15()
{
	plugradius = 34/2;
	flatradius = ((1+1/8)*25.4)/2;
	outerseparation = 2.77*25.4;
	plugoffset = outerseparation/2;

	translate([0, plugoffset-flatradius, 0])
	plug_nema5();

	// Mounting screw in the middle
	insetscrew();

	translate([0, -plugoffset+flatradius, 0])
	plug_nema5();

}

module Duplex_Standard_ngang(gangs)
{
	edge = (1+3/8)*25.4;
	separation = 1.75 * 25.4;

	width = edge*2+((gangs-1)*separation);
	height = gStandardHeight;
	thickness = gThickness;

	difference()
	{
		translate([width/2, 0, 0])
		roundedplate(width, height, thickness);

		for (plate=[0:gangs-1])
		{
			translate([edge +plate*separation, 0, 0])
			outlet_nema5_15();
		}

	}
}

//=============================================
// GFCI
//=============================================

module GFCI()
{
	mountholeseparation = 3.75*25.4;

	holewidth = 1.3125*25.4;	// 1 5/16"
	holeheight = (2+(5/8))*25.4;

	translate([holewidth/2, 0, 0])
	union()
	{
		translate([0, mountholeseparation/2, 0])
		insetscrew();
	
		cube(size=[holewidth, holeheight, gThickness+2*joinfactor], center=true);
	
		translate([0, -mountholeseparation/2, 0])
		insetscrew();
	}
}

module GFCI_Standard_ngang(gangs)
{
	edge = 0.75*25.4;
	separation = 1.75 * 25.4;

	holewidth = 1.3125*25.4;
	holeheight = (2+(5/8))*25.4;

	width = edge*2+(separation*(gangs));
	height = gStandardHeight;
	thickness = gThickness;

	difference()
	{
		translate([width/2, 0, 0])
		roundedplate(width, height, thickness);

		for (plate=[0:gangs-1])
		{
			translate([edge+plate*separation, 0, 0])
			GFCI();
		}
	}
}

//=============================================
// Combinations
//=============================================
module Toggle_Duplex_Standard()
{
	edge = (1+3/8)*25.4;
	separation = 1.75 * 25.4;

		width = edge*2+((2-1)*separation);
	height = gStandardHeight;
	thickness = gThickness;

	difference()
	{
		translate([width/2, 0, 0])
		roundedplate(width, height, thickness);

		translate([edge+0*separation, 0, 0])
		Switch();

		translate([edge+1*separation, 0, 0])
		outlet_nema5_15();
	}

}

