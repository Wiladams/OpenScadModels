



module display_mesh(size, resolution)
{
	width = size[0];
	height = size[1];

	//xres = resolution[0];
	//yres = resolution[1];

	//cellwidth = width/xres;
	//cellheight = height/yres;
	cellwidth = 1/dpmm;
	cellheight = 1/dpmm;

	yiter = height/cellheight;
	xiter = width/cellwidth;

echo("CellSize: ", cellwidth, cellheight);
echo("Iteration: ", xiter, yiter);

	for (ycnt =[0:yiter-1])
	{
		for(xcnt=[0:xiter-1])
		{
			z=0;
			quad=[
				[xcnt*cellwidth, ycnt*cellheight, z],
				[(xcnt+1)*cellwidth, ycnt*cellheight, z],
				[(xcnt+1)*cellwidth, (ycnt+1)*cellheight, z],
				[xcnt*cellwidth, (ycnt+1)*cellheight, z]];

			
//echo(quad);
				color([ycnt*xcnt/(xiter*yiter), ycnt*xcnt/(xiter*yiter), ycnt*xcnt/(xiter*yiter)])
				polyhedron(points = quad,
					faces = [[0,1,2,3]]);
			
		}
	}
}
