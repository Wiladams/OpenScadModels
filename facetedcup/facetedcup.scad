OD = 80;
ID = 60;
minkor = 2;

BaseThickness = 6;
ShellFacets = 8;
CupHeight = 100;
InnerCupOffset = 3;

overlap = 0.01;

module cupBase() {
    cylinder(h=BaseThickness, d=OD, $fa=5);
}

/*
    outerShape
    Determines the outer countours of the cup.
    The number of faces and twist angle determine 
    how faceted it becomes.

    Good numbers for twist are multiples of 30, and 45
*/
module outerShape() {
    linear_extrude(height=CupHeight, twist=90)
        circle(d=OD, $fn=ShellFacets);
}

module innerShape() {
    minkowski() {
        cylinder(d=ID, h = CupHeight*1.618, $fa=5);
        sphere(r=minkor, $fn = 36);
    }
}

module fullCup() {
    difference() {
        union() {
            cupBase();
        
            translate([0,0,BaseThickness-overlap])
            outerShape();
         }
         
         translate([0,0,InnerCupOffset])
            innerShape();
    }
}


//cupBase();
//innerShape();
//outerShape();
fullCup();
