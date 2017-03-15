include <../waolib/imaging.scad>
include <../waolib/Mesh_Renderer.scad>

//include <tetra_80_60.scad>
//include <tetra_160_120.scad>
include <tbuser_height_map.scad>
include <tbuser_bitmap.scad>
include <3dtech0_3.scad>

//dpmm = 3.62205; // == 92 dpi 
//dpmm = 2.835; // == 72 dpi
//dpmm = 1/0.40;	// == 0.40mm thickness
//dpmm = 1/0.35;	// == 0.35mm thickness
//dpmm = 1/0.25;	// == 0.25mm thickness
dpmm = 1;
//dpmm = .5;

// Using bitmaps
test_text();

//shell_extrude_height_map([20,20], [dpmm,dpmm], heightmap=tbuser_height_map, sfactor = 10, solid=true);
//shell_extrude_height_map([32,32], [dpmm,dpmm], heightmap=checker_image);

//display_mesh_height([20,20], [dpmm,dpmm], heightmap=tbuser_height_map, sfactor=5);

//shell_extrude_color_map([48,48], [dpmm,dpmm], heightmap=3dtech0_3, sfactor=16, solid=true);

//display_mesh([20,20], [dpmm,dpmm], heightmap=tetra_160_120, thickness = 5);
//display_mesh([20,20], [dpmm,dpmm], heightmap=tetra_80_60);



function quadheight(img, s1, t1, s2, t2) = [
	image_gettexel(img, s1,t1),
	image_gettexel(img, s1,t2),
	image_gettexel(img, s2,t2),
	image_gettexel(img, s2,t1),
	];

function quadtexture(img, s1, t1, s2, t2) = [
	image_gettexel(img, s1,t1),
	image_gettexel(img, s1,t2),
	image_gettexel(img, s2,t2),
	image_gettexel(img, s2,t1),
	];

function qtexgray(qtex, range=1) = [
	luminance(qtex[0])*range,
	luminance(qtex[1])*range,
	luminance(qtex[2])*range,
	luminance(qtex[3])*range
	];

function quadavg(qtex) = (qtex[0]+qtex[1]+qtex[2]+qtex[3])/4;

function quadbump(img, s1, t1, s2, t2, thickness=1) = 
	gtexgray(quadtexture(img, s1, t1, s2, t2), thickness);




module print_text(text, cnt, size=[8,8], resolution=[1,1], solid=false)
{
joinfactor = 0.001;

	for (c=[0:cnt-1])
	{
		translate([c*size[0], 0, 0])
		shell_extrude_height_map([size[0],size[1]],resolution, heightmap=text[c], solid=solid);
	}
}

module test_text()
{
joinfactor = 0.001;

//display_mesh_height([10,10], [dpmm,dpmm], heightmap=C0);
//display_mesh_height([10,10], [dpmm,dpmm], heightmap=C1);
//display_mesh_height([10,10], [dpmm,dpmm], heightmap=C3);
//display_mesh_height([10,10], [dpmm,dpmm], heightmap=C5);
//display_mesh_height([10,10], [dpmm,dpmm], heightmap=C6);
//shell_extrude_height_map([20,20], [dpmm,dpmm], heightmap=C9, solid=true);

rowheight = 10;

charsize=[8, 8];

difference()
{
color([1,0,0])
translate([0,0*rowheight, 0])
print_text(text=[Cheart], cnt=1, 
	size=[12,12], solid=true);

	translate([-joinfactor, -joinfactor, 0])
	cube(size=[60+joinfactor*2,60+joinfactor*2,4+joinfactor*2]);
}


//translate([0,0*rowheight, 0])
//print_text(text=[CW], cnt=1, 
//	size=[60,60], solid=true);
//
//translate([0,0*rowheight, 0])
//print_text(text=[CW,CO,CR,CL,CD,Cbang], cnt=5, 
//	size=charsize, solid=true);

//translate([0,1*rowheight, 0])
//print_text(text=[CH,CE,CL,CL,CO], cnt=5, 
//	size=charsize, solid=true);


//translate([0,1*rowheight, 0])
//print_text(text=[C0,C1,C2,C3,C4,C5,C6,C7,C8,C9], cnt=10, 
//	size=charsize, solid=true);
//
//
//translate([0,2*rowheight, 0])
//print_text(text=[CA,CB,CC,CD,CE,CF,CG,CH,CI,CJ,CK,CL,CM,CN,CO,CP,CQ,CR,CS,CT,CU,CV,CW,CX,CY,CZ], cnt=26,
//	size=charsize, solid=true);
//
//translate([0,3*rowheight, 0])
//print_text(text=[Ca,Cb,Cc,Cd,Ce,Cf,Cg,Ch,Ci,Cj,Ck,Cl,Cm,Cn,Co,Cp,Cq,Cr,Cs,Ct,Cu,Cv,Cw,Cx,Cy,Cz], cnt=26,
//	size=charsize, solid=true);
}