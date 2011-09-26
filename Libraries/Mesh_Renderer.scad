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
