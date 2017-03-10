include <maths_poly.scad>

for (i=[3:16])
{
	echo("");
	echo(str("Sides: ", i));
	echo(str("        Sum: ", poly_sum_interior_angles(i)));
	echo(str("    Interior: ", poly_interior_angle(i)));
	echo(str("    Exterior: ", poly_exterior_angle(i)));
}