goldenratio = 1.6180339;

//hinge(2, 15, 4, $fn=12);
hinge(2, 20, 4, $fn=12);

module hinge(thickness, length, notchdepth)
{
	joinwidth = 1;
	joinfactor = 0.25;

	notchlength = length / 5;
	halfnotchlength = notchlength / 2;

	dimpleradius = thickness/goldenratio/goldenratio/goldenratio;  // Not the same as... //dimpleradius = thickness/(goldenratio*3);
	
	dimpleoffset = notchdepth / goldenratio;

	// First, lay down an area that can be joined to other objects
	// lay it flat in the x-y plane
	cube(size=[joinwidth, length, thickness]);

	// Lay in the tongues

	// First tongue is a half notch with an extruded dimple
	translate([joinwidth, 0, 0])
	cube(size=[notchdepth, halfnotchlength, thickness]);
	translate([joinwidth+dimpleoffset, halfnotchlength, thickness/2])
	sphere(r=dimpleradius);

	// Second tongue has a recess in the near side
	difference()
	{
		translate([joinwidth, halfnotchlength+notchlength, 0])
		cube(size=[notchdepth, notchlength, thickness]);
	
		translate([joinwidth+dimpleoffset, halfnotchlength+notchlength, thickness/2])
		sphere(r=dimpleradius);
	}

	// The last tongue has both a extrusion and intrusion
	// extrusion on the near side, intrusion far side
	difference()
	{
		union()
		{	
			translate([joinwidth, halfnotchlength+3*notchlength, 0])
			cube(size=[notchdepth, notchlength, thickness]);
	
			translate([joinwidth+dimpleoffset, halfnotchlength+3*notchlength, thickness/2])
			sphere(r=dimpleradius);
	
		}
		translate([joinwidth+dimpleoffset, halfnotchlength+4*notchlength, thickness/2])
		sphere(r=dimpleradius);
	}
}