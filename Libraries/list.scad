function list_add(n1, n2) = [n1[0], n2];
function list_delete_child(n1) = [n1[0], undef];

function list_node(v) = [v, undef];

node1 = list_node("william");
node2 = list_node("mubeen");

node3 = list_add(node1, node2);

echo(node1);
echo(node3);

echo(node3[0], node3[1], node3[2]);

module printnodelist(head)
{
	
}