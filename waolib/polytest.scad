displayquad([[0,10,0], [0,0,0], [10,0,0], [10,10,0]]);

function VSUM(v1, v2) = [v1[0]+v2[0], v1[1]+v2[1], v1[2]+v2[2]]; 

function quad_translate(quad, trans) = [ 
VSUM(quad[0], trans), 
VSUM(quad[1], trans),
VSUM(quad[2], trans),
VSUM(quad[3], trans)];

module DisplayTriShard(shard) 
{
	polyhedron(
		points=[
			shard[0][0], shard[0][1],shard[0][2], // Top
			shard[1][0], shard[1][1], shard[1][2]], // Bottom
		faces=[
			[0,2,1],
			[3,4,5],
			[1,5,4],
			[1,2,5],
			[2,3,5],
			[2,0,3],
			[0,4,3],
			[0,1,4]
			]);
}


module displayquad(top)
{
	bot = quad_translate(top, [0,0,-10]);

	polyhedron(
		points = [
			top[0], top[1], top[2],
			bot[0], bot[1], bot[2]],
		faces =[
			[0,2,1],
			[0,1,4],
			[4,3,0],
			[2,5,4],
			[4,1,2],
			[3,4,5]
			]);
		
	polyhedron(
		points = [
			top[0], top[2], top[3],
			bot[0], bot[2], bot[3]],
		faces =[
			[0,2,1],
			[0,3,2],
			[3,5,2],
			[1,2,4],
			[2,5,4],
			[3,4,5]
			]);

}
