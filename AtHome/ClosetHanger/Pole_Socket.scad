goldenratio = 1.61803399;
joinfactor = 0.125;

//closedSocket();
//halfSocket();
PoleSocketSet();

module closedSocket()
{
	baseRadius = 2/2*25.4;
	baseThickness = 3.5;
	baseSmallHole = 4.5/2;
	baseLargeHole = 8.5/2;

	socketOR = 41/2;
	socketIRBase = 35.5/2;
	socketIRTop = 36/2;
	socketHeight = 16;

	difference()
	{
		union()
		{
			cylinder(r=baseRadius, h=baseThickness);	

			translate([0,0,baseThickness-joinfactor])
			cylinder(r=socketOR, h=socketHeight);
		}

		translate([0,0,-joinfactor])
		cylinder(r1=baseSmallHole, r2 = baseLargeHole, h=baseThickness+2*joinfactor);

		translate([0,0,baseThickness-joinfactor])
		cylinder(r1=socketIRBase, r2=socketIRTop, h=socketHeight+joinfactor);
	}
}

module halfSocket()
{
	baseRadius = 2/2*25.4;
	baseThickness = 3.5;
	baseSmallHole = 4.5/2;
	baseLargeHole = 8.5/2;

	socketOR = 41/2;
	socketIRBase = 35.5/2;
	socketIRTop = 36/2;
	socketHeight = 16;

	difference()
	{
		union()
		{
			cylinder(r=baseRadius, h=baseThickness);	

			translate([0,0,baseThickness-joinfactor])
			cylinder(r=socketOR, h=socketHeight);
		}

		translate([0,0,-joinfactor])
		cylinder(r1=baseSmallHole, r2 = baseLargeHole, h=baseThickness+2*joinfactor);

		translate([0,0,baseThickness-joinfactor])
		cylinder(r1=socketIRBase, r2=socketIRTop, h=socketHeight+joinfactor);

		translate([-socketIRTop, 0, baseThickness])
		cube(size=[socketIRTop*2, socketOR+joinfactor, socketHeight]);
	}
}

module PoleSocketSet()
{
	halfSocket();
	
	translate([2.5*24.4, 0, 0])
	closedSocket();
}