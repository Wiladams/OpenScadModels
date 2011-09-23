equilateral(60,4);

module equilateral(size, height)
{
difference()
{
	color([1,0,0])
	cube(size=[size,size,4], center = false);
	
	color([0,1,0])
	translate([0,0,0])
	rotate([0,0,60])
	 cube(size=[size,size,height+0.5], center = fakse);

	translate([60,0,0]) rotate([0,0,30])
		cube(size=[60,60,4.5], center=false);
}
}