// Some useful Constants
overlap = 0.001;
tau = 1.61803399;


// Change these to suit your needs
//OD = 6.25;
OD = 5/16*25.4;
//OD = 1/2*25.4;
OR = OD/2;

//ID = 4;
ID = OD/tau;
IR = ID/2;

conetop = IR+((OR-IR)/2);

length = 12;	// Overall length of flanged section
sections = 4;	// How many flange sections
section_length = length/(sections);

// Standoff is the smooth sleeve that goes from 
// the flanged section to the central hub
standoff=10;
standoffOR = OR;

// cilinder hole precision 
// based on http://hydraraptor.blogspot.com/2011/02/polyholes.html
$fn = max(round(diameter*2),3);

//===================================
// Printing various parts
//===================================
//print_cone_section();
//print_cone_sections();
//print_single_connector($fn=24);
//print_connectors(2, $fn=24);
//print_connectors(3);
//print_connectors(4, $fn=24);
//print_connectors(5, $fn=24);
//print_connectors(6, $fn=24);
//print_connectors(8, $fn=24);

//print_elbow(angle=90, $fn=24);
//print_elbow(angle=45, $fn=24);
print_elbow(angle=120, $fn=24);


//=========================================
//		MODULES
//=========================================

module print_cone_section()
{
	conebottom = OR;

	difference()
	{
		cylinder(r1=conebottom, r2=conetop, h=section_length+overlap);
	
		translate([0,0,-overlap])
		cylinder(r=IR, h=section_length+overlap*3);
	}
}

module print_cone_sections()
{
	for (section = [0:sections-1])
	{
		translate([0,0,section*section_length])
		print_cone_section();
	}
}

module connector_blank()
{
	cylinder(r=IR, h=standoff+overlap*3);
	sphere(r=IR);
}


module print_single_connector()
{
	translate([0,0,standoff-overlap])
	print_cone_sections();

	difference()
	{
		cylinder(r=standoffOR, h=standoff);

		translate([0,0,-overlap])
		connector_blank();
	}
}


module print_connectors(num)
{
	angle = 360/num;

	difference()
	{
		union()
		{
//			sphere(r=OR);
			rotate([0,90,0])
			cylinder(r=standoffOR, h=standoffOR*2, center=true);

			for(connector = [1:num])
			{
				rotate([(connector-1)*angle, 0, 0])
				print_single_connector();
			}
		}

		for(connector = [1:num])
		{
			rotate([(connector-1)*angle, 0, 0])
			connector_blank();
		}
	}
}

/*
	Print an elbow

	Parameter:
		angle - defaults to 90 degrees, set to whatever you want
*/
module print_elbow(angle=90)
{	
	difference()
	{
		union()
		{
			//sphere(r=standoffOR);
			
			rotate([0,90,0])
			cylinder(r=standoffOR, h=standoffOR*2, center=true);

			print_single_connector();
			rotate([angle, 0, 0])
			print_single_connector();
		}

		// subtract out the rounded bottom
		// for each connector
		connector_blank();

		rotate([angle, 0, 0])
		connector_blank();
	}
}
