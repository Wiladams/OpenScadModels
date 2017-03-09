include <imaging.scad>

rgb_image = checker_image; 

module test_getpixel()
{
echo("0,0 - [1,1,1]", image_getpixel(rgb_image, [0,0]));
echo("1,0 - [0,0,0]", image_getpixel(rgb_image, [1,0]));
echo("2,0 - [1,1,1]", image_getpixel(rgb_image, [2,0]));

echo("0,1 - [0,0,0]", image_getpixel(rgb_image, [0,1]));
echo("1,1 - [1,1,1]", image_getpixel(rgb_image, [1,1]));
echo("2,1 - [0,0,0]", image_getpixel(rgb_image, [2,1]));
}

test_getpixel();