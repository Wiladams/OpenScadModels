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
		faces=[
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
			faces=[
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
			faces=[
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
			faces=[
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
			faces=[
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


module shell_extrude_height_map(size, resolution, sfactor=1, heightmap=checker_image, solid=false ) 
{
	base = 4;
	qcolor = [0.75, 0.75, 0.75];

	// What is the overall size of the mesh
	width = size[0];
	height = size[1];

	// How big is each quad in the mesh
	cellwidth = 1/dpmm;
	cellheight = 1/dpmm;

	// How many iterations
	yiter = height/cellheight;
	xiter = width/cellwidth;

	// Pull out the height map values so we don't have to 
	// do array lookups later, as sometimes the array 
	// will be copied.
	hmwidth = heightmap[0];
	hmheight = heightmap[1];
	hmsize = [hmwidth, hmheight];
	hmvalues = heightmap[3];

	for (ycnt =[0:yiter-1])
	{
		y1frac = ycnt/yiter;
		y2frac = (ycnt+1)/yiter;
		for(xcnt=[0:xiter-1])
		{
			assign(x1frac = xcnt/xiter)
			assign(x2frac = (xcnt+1)/xiter)

			assign(x1=xcnt*cellwidth)
			assign(y1=ycnt*cellheight)
			assign(x2=(xcnt+1)*cellwidth)
			assign(y2=(ycnt+1)*cellheight)
			
			
			assign(z1 = hmvalues[heightfield_getoffset(hmsize, image_gettexelcoords(hmsize,x1frac,y1frac))])
			assign(z2 = hmvalues[heightfield_getoffset(hmsize, image_gettexelcoords(hmsize,x1frac,y2frac))])
			assign(z3 = hmvalues[heightfield_getoffset(hmsize, image_gettexelcoords(hmsize,x2frac,y2frac))])
			assign(z4 = hmvalues[heightfield_getoffset(hmsize, image_gettexelcoords(hmsize,x2frac,y1frac))])
			
			assign(quad=[
			[x1, y1, z1],
			[x1, y2, z2],
			[x2, y2, z3],
			[x2, y1, z4]
			])
			{
				//color(qcolor)
				if (solid)
				{
					nquad = [
						quad, 
						[
							[0,0,1], 
							[0,0,1],
							[0,0,1],
							[0,0,1]
						]
					];
					DisplayQuadShard(nquad, 
						thickness=base, 
						edgefaces=[
						xcnt==0, 
						ycnt==yiter-1, 
						xcnt==xiter-1, 
						ycnt==0]);
				} else
				{
					polyhedron(points = quad, faces = [[0,1,2,3]]);
				}
			}
		}
	}
}

module shell_extrude_color_map(size, resolution, sfactor=1, heightmap=checker_image, solid=false ) 
{
	base = 4;
	qcolor = [0.75, 0.75, 0.75];

	// What is the overall size of the mesh
	width = size[0];
	height = size[1];

	// How big is each quad in the mesh
	cellwidth = 1/dpmm;
	cellheight = 1/dpmm;

	// How many iterations
	yiter = height/cellheight;
	xiter = width/cellwidth;

	// Pull out the height map values so we don't have to 
	// do array lookups later, as sometimes the array 
	// will be copied.
	hmwidth = heightmap[0];
	hmheight = heightmap[1];
	hmsize = [hmwidth, hmheight];
	hmvalues = heightmap[3];
	hmmaxvalue = heightmap[2];
	hmcpe = heightmap[4];

//echo(size);
//echo(hmsize);

	for (ycnt =[0:yiter-1])
	{
		assign(y1frac = ycnt/yiter)
		assign(y2frac = (ycnt+1)/yiter)
		for(xcnt=[0:xiter-1])
		{
			assign(x1frac = xcnt/xiter)
			assign(x2frac = (xcnt+1)/xiter)

			assign(x1=xcnt*cellwidth)
			assign(y1=ycnt*cellheight)
			assign(x2=(xcnt+1)*cellwidth)
			assign(y2=(ycnt+1)*cellheight)
			
			assign(zoff1 = image_getoffset(hmsize, image_gettexelcoords(hmsize,x1frac,y1frac), cpe=hmcpe))
			assign(zoff2 = image_getoffset(hmsize, image_gettexelcoords(hmsize,x1frac,y2frac), cpe=hmcpe))
			assign(zoff3 = image_getoffset(hmsize, image_gettexelcoords(hmsize,x2frac,y2frac), cpe=hmcpe))
			assign(zoff4 = image_getoffset(hmsize, image_gettexelcoords(hmsize,x2frac,y1frac), cpe=hmcpe))

			assign(z1 = sfactor*hmvalues[zoff1]/hmmaxvalue)
			assign(z2 = sfactor*hmvalues[zoff2]/hmmaxvalue)
			assign(z3 = sfactor*hmvalues[zoff3]/hmmaxvalue)
			assign(z4 = sfactor*hmvalues[zoff4]/hmmaxvalue)

			assign(quad=[
			[x1, y1, z1],
			[x1, y2, z2],
			[x2, y2, z3],
			[x2, y1, z4]
			])
			{
				//color(qcolor)
				if (solid)
				{
					assign(nquad = [quad, 
					[[0,0,1], 
					[0,0,1],
					[0,0,1],
					[0,0,1]]])
					DisplayQuadShard(nquad, 
					thickness=base, 
					edgefaces=[
						xcnt==0, 
						ycnt==yiter-1, 
						xcnt==xiter-1, 
						ycnt==0]);
				} else
				{
					polyhedron(points = quad, faces = [[0,1,2,3]]);
				}
			}
		}
	}
}
