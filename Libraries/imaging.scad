function max(x,y) = x>y ? x : y;
function min(x,y) = x<y ? x : y;

function mix(x, y, a) = x(1-a)+y*a;
function mix3(x, y,a) = [mix(x[0],y[0],a), mix(x[1],y[1],a), mix(x[2],y[2],a)];

function clamp(x, minValue, maxValue) = min(max(x,minValue),maxValue);
function clamp3(x, minValue, maxValue) = [clamp(x[0]), clamp(x[1]), clamp(x[2])];

function dot(v1,v2) = v1[0]*v2[0]+v1[1]*v2[1]+v1[2]*v2[2]; 

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
function image(width, height, maxvalue, rgb_triplets, cpe=3) = [width, height, maxvalue, rgb_triplets, cpe];
function image_getoffset(img, x,y) = ((img[0]*(y))+x)*img[4];

function _image_getpixel(img, offset) = [img[3][offset], img[3][offset+1], img[3][offset+2]];

function image_pixel_normalize(img, pixel) = [pixel[0]/img[2], pixel[1]/img[2], pixel[2]/img[2]];
function image_getpixel(img, x, y) = _image_getpixel(img, image_getoffset(img, x,y));

 
function image_gettexel(img, u, v) = image_pixel_normalize(img, image_getpixel(img, map_to_array(img[0],u), map_to_array(img[1],v)));


/*
	checker_image

	This is a useful image to be used if no other image is available.
	It is a simple black/white image that is 8x8 pixels
*/
checker_array = [ 
0,0,0, 255,255,255, 0,0,0, 255,255,255, 0,0,0, 255,255,255, 0,0,0, 255,255,255,
255,255,255, 0,0,0, 255,255,255, 0,0,0, 255,255,255, 0,0,0, 255,255,255, 0,0,0,
0,0,0, 255,255,255, 0,0,0, 255,255,255, 0,0,0, 255,255,255, 0,0,0, 255,255,255,
255,255,255, 0,0,0, 255,255,255, 0,0,0, 255,255,255, 0,0,0, 255,255,255, 0,0,0,
0,0,0, 255,255,255, 0,0,0, 255,255,255, 0,0,0, 255,255,255, 0,0,0, 255,255,255,
255,255,255, 0,0,0, 255,255,255, 0,0,0, 255,255,255, 0,0,0, 255,255,255, 0,0,0,
0,0,0, 255,255,255, 0,0,0, 255,255,255, 0,0,0, 255,255,255, 0,0,0, 255,255,255,
255,255,255, 0,0,0, 255,255,255, 0,0,0, 255,255,255, 0,0,0, 255,255,255, 0,0,0
];

checker_image = image(8,8,255, checker_array); 

//====================================
// COLOR MAPPING
//====================================

// For modern day monitor luminance
function luminance(rgb) = dot([0.2125, 0.7154, 0.0721], rgb);

// For non-linear luminance, and old NTSC
function luminance_ntsc(rgb) = dot([0.299, 0.587, 0.114], rgb);
