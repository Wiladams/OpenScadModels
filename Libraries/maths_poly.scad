// The sum of all the interior angles of a regular polygon
function poly_sum_interior_angles(p) = (p-2)*180;

//  A single interior angle
function poly_interior_angle(p) = poly_sum_interior_angles(p)/p;

function poly_exterior_angle(p) = 180 - poly_interior_angle(p);

//poly_centroid_x(ptr, npts) = [
//]
//
//poly_centroid(pts, npts) = [
//	poly_centroid_x(pts, npts),
//	poly_centroid_y(pts, npts)
//	];