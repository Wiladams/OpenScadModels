
// Some samples
// Yazzo large hole - 9/32in hole size
//spearbaseconnector(4.2, 7.22/2.0, 8.0);

// connector for Klikko hole- 9/32in hole size
//translate([15,0,0])
spearspearconnector(4.2, 6.5/2.0, 6, 4.2, 6.5/2.0);


// circuit board hole - 3.22mm diameter, 1/8th inch (3.27mm)
//translate([-10,0,0])
//spearbaseconnector(4.2, 3.22/2.0, 8.0);

// connector for Klikko - PCB
//translate([30,0,0])
//spearspearconnector(4.2, 7.22/2.0, 8.0, 1.65, 3.22/2.0);

// connector for Klikko hole- 9/32in hole size
//translate([40,0,0])
//spearspearconnector(1.65, 3.22/2.0, 8.0, 1.65, 3.22/2.0);


module spearbaseconnector(holelength, holeradius, gap)
{		
	union()
	{
		spacer(gap, holeradius);

		// Spear top cap
		translate([0,0,gap])
			spearcap(holelength, holeradius, holelength*0.75);
	}
}

module spearcap(holelength, holeradius, capheight)
{
	capradius=holeradius*1.3;

	totalheight = capheight+holelength;
	slotheight = totalheight*0.9;
	slotwidth = capradius*2+0.25;
	slotthickness = holeradius * 0.40;
	shrinkfactor = 0.6;

	difference()
	{
		union()
		{
			// Basic cylinder to fit in the hole
			cylinder(h=holelength, r=holeradius, $fn=12);
		
			translate([0,0,holelength])
				cylinder(h=capheight, r1=capradius, r2=holeradius, $fn=12);
		}

		// Subtract out the slot material
		translate([-slotwidth/2, -slotthickness/2.0,totalheight-slotheight+0.2])
			cube(size=[slotwidth, slotthickness, slotheight], center=false);

//		rotate([0,0,90]) translate([-slotwidth/2, -slotthickness/2.0,totalheight-slotheight+0.2])
//			cube(size=[slotwidth, slotthickness, slotheight], center=false);

		translate([0,0,-0.25])
		cylinder(r=holeradius*shrinkfactor, h = totalheight+0.5, $fn =12);

	}
}

// A spacer is simply a cylinder with two 'caps', which are also cylinders, but larger in size
// the caps are there to prevent the piece that is connected from sliding along the shaft.
module spacer(length,radius)
{
	capheight=2;
	capradius = radius * 1.3;
	gap = length-(capheight*2);
	shrinkfactor = 0.6;

	difference()
	{
		union()
		{
			// Base flange
			cylinder(h=capheight, r=capradius, $fn = 12);
	
			// length of spacer gap
			translate([0,0,capheight])
				cylinder(h=gap, r=radius, $fn=12);
	
			// top flange
			translate([0,0,capheight+gap])
				cylinder(h=capheight, r=capradius, $fn = 12);
		}

		translate([0,0,-0.25]) 
			cylinder(h=length+0.5, r=radius*shrinkfactor, $fn=12);
	}
}

module spearspearconnector(holelength1, holeradius1, gap, holelength2, holeradius2)
{
	shrinkfactor = 0.6;

	union()
	{
		// Spear bottom cap
		rotate([180,0,0])
			spearcap(holelength1, holeradius1, holelength1*0.75);

		spacer(gap, holeradius1);

		// Spear top cap
		translate([0,0,gap])
			spearcap(holelength2, holeradius2, holelength2*0.75);
	}
}




