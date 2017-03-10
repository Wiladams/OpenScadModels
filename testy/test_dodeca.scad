/*
    test_dodeca.scad
*/

Cphi = (sqrt(5)+1)/2;

/*
    Cartesian coordinates for a dodecahedron
*/
dodeca_cart = [ 
[+1, +1, +1], // 0, 0
[+1, -1, +1], // 0, 1
[-1, -1, +1], // 0, 2
[-1, +1, +1], // 0, 3

[+1, +1, -1], // 1, 4
[-1, +1, -1], // 1, 5
[-1, -1, -1], // 1, 6
[+1, -1, -1], // 1, 7

[0, +1/Cphi, +Cphi], // 2, 8
[0, -1/Cphi, +Cphi], // 2, 9
[0, -1/Cphi, -Cphi], // 2, 10
[0, +1/Cphi, -Cphi], // 2, 11

[-1/Cphi, +Cphi, 0], // 3, 12
[+1/Cphi, +Cphi, 0], // 3, 13
[+1/Cphi, -Cphi, 0], // 3, 14
[-1/Cphi, -Cphi, 0], // 3, 15

[-Cphi, 0, +1/Cphi], // 4, 16
[+Cphi, 0, +1/Cphi], // 4, 17
[+Cphi, 0, -1/Cphi], // 4, 18
[-Cphi, 0, -1/Cphi], // 4, 19
];



dodecahedron = [
    // points
    dodeca_cart,
    
    // faces
    [
        [1,9,8,0,17],
        [9,1,14,15,2],
        [9,2,16,3,8],
        [8,3,12,13,0],
        [0,13,4,18,17],
        [1,17,18,7,14],
        [15,14,7,10,6],
        [2,15,6,19,16],
        [16,19,5,12,3],
        [12,5,11,4,13],
        [18,4,11,10,7],
        [19,6,10,11,5]
    ]
];

polyhedron(points = dodecahedron[0], faces = dodecahedron[1]);
