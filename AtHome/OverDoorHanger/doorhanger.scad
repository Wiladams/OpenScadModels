joinfactor = 0.125;
goldenratio = 1.61803399;
grabfactor = 0.5;

gDoorWidth = 34.5;

gHangerWidth = gDoorWidth/goldenratio;
gHangerBase = gDoorWidth+grabfactor;
gHangerShortLength = gHangerBase;
gHangerLongLength = gHangerBase*goldenratio;

gGrooveWallHeight = 6;
gGrooveWallThickness = 3;
gGrooveLength =gHangerShortLength/goldenratio; 
gGrooveWide = gHangerWidth/goldenratio;
gGrooveSkinny = gGrooveWide/goldenratio;

gShoeThickness = (gGrooveWallHeight-gGrooveWallThickness)*0.9;

gStandoffHeight=6;
gStandoffThickness = 5;
gStandoffLength = 13;

//taperedGroove(gGrooveLength, gGrooveWide, gGrooveSkinny);
//doorHangerBase();

//shoeWithStandoff();
//verticalHoop();
horizontalHoop();

//===============================================
// Basic routiines
//===============================================

module trapezoid(base, top, height, thickness) 
{
linear_extrude(height=thickness, center=true, convexity=10, twist=0) 
polygon(
points=[
[-base/2, -height/2], 
[base/2,-height/2],
[top/2, height/2],
[-top/2, height/2] 
],
paths=[[0,1,2,3]], 
convexity=10);
}

module taperedGroove(length, wide, skinny, 
	wallthickness=gGrooveWallThickness, wallheight=gGrooveWallHeight)
{
	a = (wide-skinny)/2;
	o = length;

	angle = atan2(a,o);
	grooveradius = wallthickness/2;

	union()
	{
		translate([wide/2, 0, 0])
		rotate([0, 0, angle])
		{
			cube(size=[wallthickness, length,wallheight ]);
			translate([0, 0, wallheight-grooveradius])
			rotate([-90, 0, 0])
			cylinder(r=grooveradius, h=length, $fn=12);
		}
	
		translate([-wide/2-wallthickness, 0, 0])
		rotate([0, 0, -angle])
		{
			cube(size=[wallthickness, length,wallheight ]);
			translate([wallthickness, 0, wallheight-grooveradius])
			rotate([-90, 0, 0])
			cylinder(r=grooveradius, h=length, $fn=12);
		}
	}
}

module doorHangerBase(doorwidth=34.5, hangerwidth = 34.5/goldenratio)
{
	grabfactor = 0.5;
	wallthickness = 3;

	hangerbase = doorwidth + grabfactor;
	hangershortlength = hangerbase;
	hangerlonglength = hangerbase*goldenratio;

	groovelength = hangershortlength/goldenratio;

	cube(size=[hangerbase+2*wallthickness, wallthickness, hangerwidth]);

	// short hangover
	translate([hangerbase+wallthickness, 0, 0])
	cube(size=[wallthickness, hangerbase+wallthickness, hangerwidth]);

	// Long hangover
	cube(size=[wallthickness, hangerlonglength+wallthickness, hangerwidth]);

	translate([joinfactor, hangerlonglength-groovelength, hangerwidth/2])
	rotate([0, -90, 0])
	taperedGroove(groovelength, gGrooveWide, gGrooveSkinny);

}

//===============================================
// Some attachments
//===============================================

module shoeWithStandoff()
{
	shoethickness = 3*0.9;


		union()
		{
			trapezoid(gGrooveWide*0.95, gGrooveSkinny*0.95, gGrooveLength,gShoeThickness);
		
			translate([0, 0, gShoeThickness/2+4/2-joinfactor])
			cube(size=[gStandoffThickness, gStandoffLength, gStandoffHeight+joinfactor ], center=true);		
		}
}

module verticalHoop()
{
	shoethickness = 3*0.9;

	standoffheight=6;
	standoffthickness = 5;

	eyeletIR = 12/2;
	eyeletOR = eyeletIR*goldenratio;
	eyeletLength = 13;

	difference()
	{
		union()
		{
			trapezoid(gGrooveWide*0.95, gGrooveSkinny*0.95, gGrooveLength, shoethickness);
		
			translate([0, 0, shoethickness/2+4/2-joinfactor])
			cube(size=[standoffthickness, eyeletLength, standoffheight+joinfactor ], center=true);
		
			translate([0, 0, eyeletOR+shoethickness/2+standoffheight-(eyeletOR-eyeletIR)])
			rotate([90, 0, 0])
			cylinder(r=eyeletOR, h=eyeletLength, center=true);
		}

		translate([0, 0, eyeletOR+shoethickness/2+standoffheight-(eyeletOR-eyeletIR)])
		rotate([90, 0, 0])
		cylinder(r=eyeletIR, h=eyeletLength+2*joinfactor, center=true);
	}
}

module horizontalHoop()
{
	shoethickness = 3*0.9;

	standoffheight=6;
	standoffthickness = 5;

	eyeletIR = 12/2;
	eyeletOR = eyeletIR*goldenratio;
	eyeletLength = 13;

	difference()
	{
		union()
		{
			shoeWithStandoff();
		
			translate([0, 0, eyeletOR+gShoeThickness/2+gStandoffHeight-(eyeletOR-eyeletIR)])
			rotate([0, 90, 0])
			cylinder(r=eyeletOR, h=eyeletLength, center=true);
		}

		translate([0, 0, eyeletOR+gShoeThickness/2+gStandoffHeight-(eyeletOR-eyeletIR)])
		rotate([0, 90, 0])
		cylinder(r=eyeletIR, h=eyeletLength+2*joinfactor, center=true);
	}
}

