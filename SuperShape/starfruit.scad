// http://www.thingiverse.com/thing:12889

include <supershape.scad> 

scale([10,10,10])
RenderSuperShape(
shape1 = supershape(m=58, n1=.9, n2=.9, n3=.9, a=.9, b=.9), 
shape2=supershape(m=119, n1=.190, n2=9, n3=.1, a=1, b=1), 
phisteps = 32,
thetasteps = 32,
points=false,
pointcolor=[1,1,1],
wireframe=true,
faces=true,
pattern=[32,32]); 
