include <imaging.scad>
include <tetra_160_120.scad>
//include <tetra_80_60.scad>
//include <tetra_10_8.scad>

rgb_image_array = [255,0,0, 0,255,0, 0,0,255, 255,0,0, 0,255,0, 0,0,255, 
255,255,0, 255,255,255, 0,0,0, 255,255,0, 255,255,255, 0,0,0];


//rgb_image = image(6,2,255, rgb_image_array); 
//rgb_image = checker_image; 
//rgb_image = tetra_80_60;
//rgb_image = tetra_160_120;

//test_texel();
//test_display_image(32,24, tetra_160_120);
//test_display_image(80,60, tetra_80_60);
//test_display_image(10,8, tetra_10_8);
test_display_image(80,60, checker_image);

//test_surface_image(160, 120, 80, 60, rgb_image);
//test_surface_image(160, 120, 16, 16, checker_image);
//test_surface_image(160, 120, 16, 16, tetra_160_120);


//==================================================
//	Renderer
//==================================================
module DisplayQuadShards( outer, inner, edgefaces=[true, true, true, true] ) 
{
	// First put out the top and bottom
	polyhedron(
		points=[
			outer[0], outer[1],outer[2], outer[3], // Top
			inner[0], inner[1], inner[2], inner[3]], // Bottom
		triangles=[
			[0,2,1], // top
			[0,3,2], // top
			[4,5,6], // bottom
			[6,7,4] // bottom
		]);


	// Now, only lay in the sides that are associated with outside faces, leaving
	// interior faces empty
	// ustep == 0
	if (edgefaces[0])
	{
		polyhedron(
			points=[
				outer[0], outer[1],outer[2], outer[3], // Top
				inner[0], inner[1], inner[2], inner[3]], // Bottom
			triangles=[
				[0,5,4],
				[0,1,5],
				]); 
	}

// v == 0
if (edgefaces[1])
{
polyhedron(
points=[
outer[0], outer[1],outer[2], outer[3], // Top
inner[0], inner[1], inner[2], inner[3]], // Bottom
triangles=[
[1,6,5],
[1,2,6],
]); 
}

// u == 1
if (edgefaces[2])
{
polyhedron(
points=[
outer[0], outer[1],outer[2], outer[3], // Top
inner[0], inner[1], inner[2], inner[3]], // Bottom
triangles=[
[2,7,6],
[2,3,7],
]); 
}

// v == 1
if (edgefaces[3])
{
polyhedron(
points=[
outer[0], outer[1],outer[2], outer[3], // Top
inner[0], inner[1], inner[2], inner[3]], // Bottom
triangles=[
[3,4,7],
[3,0,4],
]); 
}
}

//quad is an array of four points and an an array of four normals 
module DisplayQuadShard(quad, 
	thickness=1, 
	edgefaces=[true, true, true, true]) 
{ 
	inner = quad[0] + (quad[1]*thickness*-1);

	if( thickness < 0)
	{
		DisplayQuadShards(quad[0],quad[0] + quad[1]*thickness, 
			edgefaces = edgefaces);
	} else
	{
		DisplayQuadShards(quad[0] + quad[1]*thickness,quad[0], 
			edgefaces = edgefaces);
	}
}

//============================================ 
// TEST  Modules
//============================================

module test_getpixel()
{
echo("0,0", image_getpixel(rgb_image, 0,0));
echo("1,0", image_getpixel(rgb_image, 1,0));
echo("2,0", image_getpixel(rgb_image, 2,0));

echo("0,1", image_getpixel(rgb_image, 0,1));
echo("1,1", image_getpixel(rgb_image, 1,1));
echo("2,1", image_getpixel(rgb_image, 2,1));
}

module test_texel()
{
echo(nearest(rgb_image[0]-1, 0));
echo(nearest(rgb_image[0]-1, 0.2));
echo(nearest(rgb_image[0]-1, 0.3));
echo(nearest(rgb_image[0]-1, 0.5));
echo(nearest(rgb_image[0]-1, 1.0));

echo("0.0,0", image_gettexel(rgb_image, 0,0));
echo("0.5,0", image_gettexel(rgb_image, 0.5,0));
echo("1.0,0", image_gettexel(rgb_image, 1.0,0));

echo("0.0,1", image_gettexel(rgb_image, 0,1));
echo("0.5,1", image_gettexel(rgb_image, 0.5,1));
echo("1.0,1", image_gettexel(rgb_image, 1.0,1));

}

module test_display_image(width, height, img)
{
	z = 0;

	for (x=[0:width-1])
	{
		for (y=[height-1:0])
		{
			assign(rgb = image_gettexel(img, x/(width-1), y/(height-1)))
			translate([x,y,0])
			assign(z=luminance(rgb))
			color(rgb)
			cube(size=[1,1,(z*3)+1]);
		}
	}
}

module test_surface_image(width, height, xsteps, ysteps, texture)
{
	base = 8;
	extent=12;

	xstepsize = width/xsteps;
	ystepsize = height/ysteps;

	for (x=[0:xsteps-1])
	{
		for (y=[0:ysteps-1])
		{
			assign(uv = [(x*xstepsize)/width, (y*ystepsize)/height])
			assign(facetcolor = texture[0] == 0 ? [1,1,0,1] : 
				image_gettexel(texture, uv[0], uv[1]))
			assign(luma=luminance(facetcolor))
			assign(thick = base + luma*extent)
			assign(nquad = [
				[[x*xstepsize, height-(y*ystepsize),0],
				[(x+1)*xstepsize, height-(y*ystepsize), 0],
				[(x+1)*xstepsize, height-((y+1)*ystepsize), 0],
				[x*xstepsize, height-((y+1)*ystepsize), 0]],
				[[0,0,1], [0,0,1],[0,0,1],[0,0,1]]
				])
			{
				color(facetcolor)
				DisplayQuadShard(nquad, 
					thickness=base, 
					edgefaces=[
						y==0, 
						x==xsteps-1, 
						y==ysteps-1, 
						x==0]);
			}
		}
	}
}