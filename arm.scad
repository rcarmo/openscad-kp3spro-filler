radius = 2;
width = 40;
depth = 20;
$fn = 20;

include <filler-profile-brace.scad>;

module plate(radius = 1, thickness = 2, width = width, depth = depth) {
  // plate for top of printer
  hull() {
    for (x = [ radius, width - radius ], y = [ radius, depth - radius ]) {
      translate([ x, y, 0 ]) cylinder(thickness, radius, radius);
    }
  }
}

translate([ 20, -10, 2 ]) hull() {
  translate([ 2, 2, 0 ]) sphere(2);
  translate([ 2, 22, 0 ]) sphere(2);
  translate([ 2, 22, -22 ]) sphere(2);
}

translate([ -20, 10, 2 ]) hull() {
  translate([ 2, 2, 0 ]) sphere(2);
  translate([ 42, 2, 0 ]) sphere(2);
  translate([ 42, 2, -22 ]) sphere(2);
}

segments = [
  [ [ 2, 2, 4 ], [ 2, -18, 4 ], [ 42, -18, 4 ], [ 42, 2, -2 ] ],
  [ [ 18, -8, 50 ], [ 18, 10, 50 ], [ 46, -8, 35 ], [ 46, 10, 30 ] ],
  [ [ 40, 16, 78 ], [ 40, 0, 82 ], [ 60, 16, 58 ], [ 60, -4, 62 ] ],
  [ [ 75, 28, 117 ], [ 75, 28, 79 ], [ 75, -2.5, 117 ], [ 75, -2.5, 79 ] ]
];

// arm
module arm() {
  translate([ -20, 10, 2 ]) for (s = [0:2]) {
    hull() {
      for (p = segments[s])
        translate(p) sphere(2);
      for (p = segments[s + 1])
        translate(p) sphere(2);
    }
  }
}

module screw_insets() {
  translate([ -20, -10, 2 ]) for (x = [ 10, 30 ]) {
    translate([ x, 10, 2 ]) cylinder(100, 5, 5);
    translate([ x, 10, 0 ]) cylinder(100, 2, 2);
  }
}

module base_plate() {
  translate([ -20, -10, 2 ])
      plate(thickness = 4, width = 44, depth = 24, radius = 2);
}

difference() {
  union() {
    base_plate();
    arm();
  }
  union() {
    screw_insets();
    for (p = [ [ 8, 30, 31, 108 ], [ 25, 30, 64, 119 ], [ 45, 50, 93, 125 ] ])
      translate([ p[0], p[1], p[2] ]) rotate([ 90, p[3], 0 ]) hull() {
        cylinder(50, 7, 7);
        translate([ 15, 0, 0 ]) cylinder(50, 7, 7);
      }
  }
  translate([ -20, -10, -38 ]) cube([ 40, 20, 40 ]);
}

*color("#404040") translate([ -20, -10, 0 ]) plate();

*color("#404040") translate([ 0, 0, -15 ]) linear_extrude(15) 2040_profile();

translate([ 55, 40, 80 ]) rotate([ 0, 0, 90 ]) brace(screw_dia = 0);

module 2040_profile() {
  union() {
    translate([ -10, 0, 0 ]) 2020_profile();
    translate([ 10, 0, 0 ]) 2020_profile();
  }
}
module 2020_profile() {
  difference() {

    square([ 20, 20 ], center = true);
    square([ 17, 17 ], center = true);

    square([ 40, 5.26 ], center = true);
    rotate([ 0, 0, 90 ]) square([ 40, 5.26 ], center = true);
  }

  difference() {
    union() {
      square([ 7.32, 7.32 ], center = true);
      rotate([ 0, 0, 45 ]) square([ 1.5, 25 ], center = true);
      rotate([ 0, 0, -45 ]) square([ 1.5, 25 ], center = true);
    }
    circle(d = 5, $fn = 16);
  }

  translate([ 7.9975, 7.9975, 0 ]) square([ 4.005, 4.005 ], center = true);
  translate([ -7.9975, 7.9975, 0 ]) square([ 4.005, 4.005 ], center = true);
  translate([ 7.9975, -7.9975, 0 ]) square([ 4.005, 4.005 ], center = true);
  translate([ -7.9975, -7.9975, 0 ]) square([ 4.005, 4.005 ], center = true);
}