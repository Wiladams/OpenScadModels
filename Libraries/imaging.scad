//===================================== 
// This is public Domain Code
// Contributed by: William A Adams
// September 2011
//=====================================

include <glsl.scad>


/*
	Function: map_to_array

	Description
		This routine will return which element in the array corresponds
		to the normalized value 'u' specified.

	Parameters
		len - length of array
		u - normalized value from 0..1
*/

function map_to_array(len, u) = u*len >= len ? len-1 : floor(u*len);

/*
	Function: image()

	Description: Create an image object for later usage.  The image
	Is a RGB, interleaved image, with all elements flat in the array

	Parameters:
		width  - width in pixels
		height - height in pixels
		maxvalue	- The maximum value of any component
		values - The array of values representing the image
*/
function image(width, height, maxvalue, values, cpe=3) = 
	[width, height, maxvalue, values, cpe];

function image_pixel_normalize(img, pixel) = [pixel[0]/img[2], pixel[1]/img[2], pixel[2]/img[2]];

//function image_getoffset(img, x,y) = ((img[0]*(y))+x)*img[4];
function image_getoffset(img, xy) = ((img[0]*(img[1]-1-xy[1]))+xy[0])*img[4];

function _image_getpixel_1(img, offset) = [img[3][offset],img[3][offset],img[3][offset]];
function _image_getpixel_2(img, offset) = [img[3][offset],img[3][offset+1]];
function _image_getpixel_3(img, offset) = [img[3][offset],img[3][offset+1],img[3][offset+2]];
function _image_getpixel_4(img, offset) = [img[3][offset],img[3][offset+1],img[3][offset+2],img[3][offset+3]];

function _image_getpixel(img, offset) = 
	(img[4] == 1) ? _image_getpixel_1(img,offset) :
		(img[4] == 3) ? _image_getpixel_3(img,offset) :
			(img[4] == 4) ? _image_getpixel_4(img,offset) :
				(img[4] == 2) ? _image_getpixel_2(img,offset) : [0];


function image_getpixel(img, xy) = _image_getpixel(img, image_getoffset(img, xy));

function image_gettexelcoords(img, s, t) = [map_to_array(img[0],s), map_to_array(img[1],t)];

function image_gettexel(img, s, t, r=0, q=1) = image_pixel_normalize(img, image_getpixel(img, image_gettexelcoords(img,s,t)));


/*
	checker_image

	This is a useful image to be used if no other image is available.
	It is a simple black/white image that is 8x8 pixels, like a standard
	chess board.
*/
//checker_array = [ 
//0,0,0, 255,255,255, 0,0,0, 255,255,255, 0,0,0, 255,255,255, 0,0,0, 255,255,255,
//255,255,255, 0,0,0, 255,255,255, 0,0,0, 255,255,255, 0,0,0, 255,255,255, 0,0,0,
//0,0,0, 255,255,255, 0,0,0, 255,255,255, 0,0,0, 255,255,255, 0,0,0, 255,255,255,
//255,255,255, 0,0,0, 255,255,255, 0,0,0, 255,255,255, 0,0,0, 255,255,255, 0,0,0,
//0,0,0, 255,255,255, 0,0,0, 255,255,255, 0,0,0, 255,255,255, 0,0,0, 255,255,255,
//255,255,255, 0,0,0, 255,255,255, 0,0,0, 255,255,255, 0,0,0, 255,255,255, 0,0,0,
//0,0,0, 255,255,255, 0,0,0, 255,255,255, 0,0,0, 255,255,255, 0,0,0, 255,255,255,
//255,255,255, 0,0,0, 255,255,255, 0,0,0, 255,255,255, 0,0,0, 255,255,255, 0,0,0
//];
// checker_image = image(8,8,255, checker_array, cpe=3); 

checker_array = [ 
0, 1, 0, 1, 0, 1, 0, 1,
1, 0, 1, 0, 1, 0, 1, 0,
0, 1, 0, 1, 0, 1, 0, 1,
1, 0, 1, 0, 1, 0, 1, 0,
0, 1, 0, 1, 0, 1, 0, 1,
1, 0, 1, 0, 1, 0, 1, 0,
0, 1, 0, 1, 0, 1, 0, 1,
1, 0, 1, 0, 1, 0, 1, 0,
];

checker_image = image(8,8,1, checker_array, cpe=1); 

//====================================
// COLOR MAPPING
//====================================

// For modern day monitor luminance
function luminance(rgb) = dot([0.2125, 0.7154, 0.0721], rgb);

// For non-linear luminance, and old NTSC
function luminance_ntsc(rgb) = dot([0.299, 0.587, 0.114], rgb);
