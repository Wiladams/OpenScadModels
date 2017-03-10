/*
    test_imaging_diplay_checker.scad

    Test the ability of the imaging system to display the
    default checkerboard pattern.
*/

include <imaging.scad>


module test_display_image(width, height, img)
{
	z = 0;

	for (x=[0:width-1])
	{
		for (y=[0:height-1])
		{
			rgb = image_gettexel(img, x/(width-1), y/(height-1));
			z=luminance(rgb);
			translate([x,y,0])
			color(rgb)
			cube(size=[1,1,(z*3)+1]);
		}
	}
}

test_display_image(80,60, checker_image);
