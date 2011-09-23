use <Library-Shapes.scad>

// The following are a couple of templates to create harnesses for well known pcbs
// comment out the one you want, or create a new one.
// The 'length' is the length of the board, connected to the harness
// the 'width' is the other dimension
// You can leave the others as is, or alter, and experiment to suit your needs

// For Arduino Duemilanove - Also works with standard Arduino shields
//pcbholder( length = 66, width = 53.75, bottomclearance= 5, pcbthickness=2, slotdepth=2, grooveclearance=1.3);

// Arduino MEGA - Also works with standard Arduino shields
//pcbholder( length = 100, width = 53.75, bottomclearance= 3, pcbthickness=2, slotdepth=2, grooveclearance=1.3);

//LeafLabs Maple - Shorter than an Arduino
//pcbholder( length = 53, width = 53.75, bottomclearance= 3, pcbthickness=2, slotdepth=2, grooveclearance=1.3);

// Web Platform v1c - http://www.dangerousprototypes.com
//pcbholder( length = 50.5, width = 88, bottomclearance= 3, pcbthickness=2, slotdepth=2, grooveclearance=1.3);

// Battery Charger - http://www.adafruit.com (usb/dc adjustable LiPo charger
//pcbholder( length = 40.9, width = 44.5, bottomclearance= 3, pcbthickness=2, slotdepth=2, grooveclearance=1.3);

// LPC1343 Reference - http://www.microbuilder.eu
//pcbholder( length = 95.3, width = 70.5, bottomclearance= 3, pcbthickness=2, slotdepth=2, grooveclearance=1.3);

// Parallax Propeller demo Rev g 2008 - http://www.parallax.com
//pcbholder( length = 76.5, width = 76.5, bottomclearance= 3, pcbthickness=2, slotdepth=2, grooveclearance=1.3);

// Bus Pirate BPv3 - http://www.dangerousprototypes.com
//pcbholder( length = 52, width =29.5, bottomclearance= 3, pcbthickness=2, slotdepth=2, grooveclearance=1.3);

//RFBee v1.1 - http://www.seeedstudio.com
pcbholder( length = 25, width =26, bottomclearance= 7, pcbthickness=1, slotdepth=2, grooveclearance=1.3);








module pcbholdersingleholestencil(length, width, basethickness, wallthickness, holeradius)
{
	radius = 7.22/2;
	borderwidth = wallthickness;
	rectwidth = width/2.0 - borderwidth*4 ;
	rectlength = length/2.0 - borderwidth*2;


	// Subtract large rectangular chunks
	translate([borderwidth, borderwidth*2, -0.25])
		cube(size=[rectlength, rectwidth, basethickness+0.5]);

	translate([borderwidth, width/2 + borderwidth*2, -0.25])
		cube(size=[rectlength, rectwidth, basethickness+0.5]);


	translate([length - borderwidth-rectlength, borderwidth*2, -0.25])
		cube(size=[rectlength, rectwidth, basethickness+0.5]);

	translate([length - borderwidth-rectlength, borderwidth*2+width/2.0, -0.25])
		cube(size=[rectlength, rectwidth, basethickness+0.5]);

	// Remove the center hole
	translate([length/2, width/2.0, -0.25])
		cylinder(h = basethickness+0.5, r=holeradius, $fn = 12);

		//translate([length/2, width/2+wallextent,0])
			//cylinder(h=basethickness, r= holeradius+1.5);

}

// Create the base, with stencils cutout
module pcbholderbase(length, width, basethickness, wallthickness, grooveclearance)
{
	wallextent = wallthickness - grooveclearance;
	basewidth = width+wallextent*2;
	holeradius = 7.22/2;

	union()
	{
		difference()
		{
			// Start with a basic flat surface
			cube(size=[length,basewidth, basethickness]);
	
			// cutout stencil
			pcbholdersingleholestencil(length, basewidth, basethickness, wallthickness, holeradius);
		}
	
	}
}

// Main routine to generate a holder
module pcbholder(length, width, bottomclearance, pcbthickness, grooveclearance)
{
	wallthickness = 3;
	basethickness = 3;
	wallextent = wallthickness - grooveclearance;
	basewidth = width+wallextent*2;

	// Wall	
	groovedwall(length,  bottomclearance+pcbthickness*2.5, wallthickness, groovedepth=grooveclearance*3); 

	// Wall
	rotate([0,0,180])
	translate([-length,-basewidth,0]) 
		groovedwall(length,  bottomclearance+pcbthickness*2.5, wallthickness, groovedepth=grooveclearance*3); 
	

	// Base
	translate([0, 0, -basethickness])
		pcbholderbase(length, width, basethickness, wallthickness, grooveclearance);
}


