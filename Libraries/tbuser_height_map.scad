
tbuser_height = [
1,1,0,0,1,1,0,0,1,1,
1,1,1,1,1,1,1,1,1,1,
0,1,2,2,1,1,2,2,1,0,
0,1,2,1,1,1,1,2,1,0,
1,1,1,1,3,3,1,1,1,1,
1,1,1,1,3,3,1,1,1,1,
0,1,2,1,1,1,1,2,1,0,
0,1,2,2,1,1,2,2,1,0,
1,1,1,1,1,1,1,1,1,1,
1,1,0,0,1,1,0,0,1,1
];


tbuser_height_map = image(
	width = 10,
	height = 10, 
	maxvalue=3,
	values = tbuser_height,
	cpe=1);