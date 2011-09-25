include <imaging.scad>
//include <tetra_80_60.scad>
//include <tetra_160_120.scad>
include <tbuser_height_map.scad>

//dpmm = 3.62205; // == 92 dpi 
dpmm = 2.835; // == 72 dpi
//dpmm = .5;
//dpmm = 1;


display_mesh_height([10,10], [dpmm,dpmm], heightmap=tbuser_height_map);

//display_mesh_image([20,20], [dpmm,dpmm], img=tbuser_height_map, thickness = 5);
//display_mesh([20,20], [dpmm,dpmm], img=tetra_160_120, thickness = 5);
//display_mesh([20,20], [dpmm,dpmm], img=tetra_80_60);
//display_mesh([20,20], [dpmm,dpmm], img=checker_image);


//function fxy(x,y) = x*y;
function fxy(x,y) = x+y;
function fnxy(u,v, min=1, max=10) = min + ((u+v)*max);

function quadheight(img, s1, t1, s2, t2) = [
	image_gettexel(img, s1,t1),
	image_gettexel(img, s2,t1),
	image_gettexel(img, s2,t2),
	image_gettexel(img, s1,t2)];

function quadtexture(img, s1, t1, s2, t2) = [
	image_gettexel(img, s1,t1),
	image_gettexel(img, s2,t1),
	image_gettexel(img, s2,t2),
	image_gettexel(img, s1,t2)];

function qtexgray(qtex, range=1) = [
	luminance(qtex[0])*range,
	luminance(qtex[1])*range,
	luminance(qtex[2])*range,
	luminance(qtex[3])*range
	];

function quadavg(qtex) = (qtex[0]+qtex[1]+qtex[2]+qtex[3])/4;

function quadbump(img, s1, t1, s2, t2, thickness=1) = 
	gtexgray(quadtexture(img, s1, t1, s2, t2), thickness);


module display_mesh_height(size, resolution, thickness=1, heightmap=checker_image ) 
{
	qcolor = [0.75, 0.75, 0.75];

	width = size[0];
	height = size[1];

	cellwidth = 1/dpmm;
	cellheight = 1/dpmm;

	yiter = height/cellheight;
	xiter = width/cellwidth;

echo("CellSize: ", cellwidth, cellheight);
echo("Iteration: ", xiter, yiter);

	for (ycnt =[0:yiter-1])
	{
		assign(y1frac = ycnt/yiter)
		assign(y2frac = (ycnt+1)/yiter)
		for(xcnt=[0:xiter-1])
		{
			assign(x1frac = xcnt/yiter)
			assign(x2frac = (xcnt+1)/xiter)

			assign(qheight = quadheight(heightmap, x1frac, y1frac, x2frac, y2frac))

			assign(x1=xcnt*cellwidth)
			assign(y1=ycnt*cellheight)
			assign(x2=(xcnt+1)*cellwidth)
			assign(y2=(ycnt+1)*cellheight)
			assign(z1=qheight[0][0])
			assign(z2=qheight[1][0])
			assign(z3=qheight[2][0])
			assign(z4=qheight[3][0])
			assign(quad=[
				[x1, y1, z1],
				[x2, y1, z2],
				[x2, y2, z3],
				[x1, y2, z4]])

			{
//echo(quad);
				//color(qcolor)
				polyhedron(points = quad,
					triangles = [[0,1,2,3]]);
			}
		}
	}
}


module display_mesh_image(size, resolution, thickness=1, img=checker_image ) 
{
	width = size[0];
	height = size[1];

	cellwidth = 1/dpmm;
	cellheight = 1/dpmm;

	yiter = height/cellheight;
	xiter = width/cellwidth;

echo("CellSize: ", cellwidth, cellheight);
echo("Iteration: ", xiter, yiter);

	for (ycnt =[0:yiter-1])
	{
		assign(y1frac = ycnt/yiter)
		assign(y2frac = (ycnt+1)/yiter)
		for(xcnt=[0:xiter-1])
		{
			assign(x1frac = xcnt/yiter)
			assign(x2frac = (xcnt+1)/xiter)

			assign(qtex = quadtexture(img, x1frac, y1frac, x2frac, y2frac))
			assign(qgray = qtexgray(qtex,thickness))
			assign(qcolor = quadavg(qtex))

			assign(x1=xcnt*cellwidth)
			assign(y1=ycnt*cellheight)
			assign(x2=(xcnt+1)*cellwidth)
			assign(y2=(ycnt+1)*cellheight)
			assign(z1=qgray[0])
			assign(z2=qgray[1])
			assign(z3=qgray[2])
			assign(z4=qgray[3])
			assign(quad=[
				[x1, y1, z1],
				[x2, y1, z2],
				[x2, y2, z3],
				[x1, y2, z4]])

			{
//echo(quad);
				color(qcolor)
				polyhedron(points = quad,
					triangles = [[0,1,2,3]]);
			}
		}
	}
}
