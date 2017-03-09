function VMAG(v) = sqrt(v[0]*v[0]+v[1]*v[1]+v[2]*v[2]); 

function LineRotations(v) = [ 
atan2(sqrt(v[0]*v[0]+v[1]*v[1]), v[2]), 
0, 
atan2(v[1], v[0])+90];

function parseSeg(seg) = [ 
seg[0], 
LineRotations(seg[1]-seg[0]), 
VMAG(seg[1]-seg[0])
];


module PlaceLine(seg, radius=0.025, style=1, smoothness=24) 
{
	$fn=smoothness;
	diameter = radius*2;
	side = sqrt((diameter*diameter)/2);


	params = parseSeg(seg);

	origin = params[0];
	rot = params[1];
	len = params[2];

	translate(origin)
	rotate(rot)
	{
		if (style == 0) // cylinders, with no end caps
		{
			cylinder(r=radius, h=len);
		} else if (style == 1) // cylinders with rounded end caps
		{
			cylinder(r=radius, h=len);

			// Cap with spheres
			sphere(r=radius);

			translate([0,0,len])
			sphere(r=radius); 
		}
	}
}
