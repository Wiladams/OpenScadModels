include <bitops.scad>

echo("5 :", BTEST(5,2), BTEST(5,1), BTEST(5,0));
echo("5 :", BIT(5,2), BIT(5,1), BIT(5,0));

echo("bit(4): ", bit(4));


echo("getdigit(788, 1): ", getdigit(788, 1));
echo("getdigit(788, 2): ", getdigit(788, 2));
echo("getdigit(788, 3): ", getdigit(788, 3));
