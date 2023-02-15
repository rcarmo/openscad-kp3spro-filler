radius = 2;
width = 40;
depth = 20;
$fn = 20;

include <filler-profile-brace.scad>;
include <extrusions.scad>;

module plate(radius = 1, thickness = 2, width = width, depth = depth) {
  // plate for top of printer
  hull() {
    for (x = [ radius, width - radius ], y = [ radius, depth - radius ]) {
      translate([ x, y, 0 ]) cylinder(thickness, radius, radius);
    }
  }
}

module load_bearing_corner() {
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
}

// arm segments
segments = [
  [ [ 2, 2, 4 ], [ 2, -18, 4 ], [ 42, -18, 4 ], [ 42, 2, -18 ] ],
  [ [ 18, 0, 50 ], [ 18, 17, 50 ], [ 46, -3, 35 ], [ 46, 15, 30 ] ],
  [ [ 40, 25, 78 ], [ 40, 8, 78 ], [ 60, 25, 58 ], [ 60, 7, 62 ] ],
  [ [ 75, 38, 117 ], [ 75, 38, 79 ], [ 75, 7, 117 ], [ 75, 7, 79 ] ]
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
  translate([ -20, -10, 1.5 ]) for (x = [ 10, 30 ]) {
    translate([ x, 10, 2 ]) cylinder(50, 5, 5);
    translate([ x, 10, 0 ]) cylinder(90, 2.5, 2.5);
  }
}

module base_plate() {
  translate([ -20, -10, 2 ])
      plate(thickness = 4, width = 44, depth = 24, radius = 2);
}

// Full Assembly
module assembly() {
  difference() {
    union() {
      base_plate();
      load_bearing_corner();
      arm();
      translate([ 55, 50, 80 ]) rotate([ 0, 0, 90 ]) brace(screw_dia = 0);
    }
    union() {
      screw_insets();
      // cutouts to both save on material and add some rigidity (via the internal outlines)
      for (p = [ [ 8, 30, 31, 108 ], [ 25, 40, 64, 119 ], [ 46, 50, 93, 128 ] ])
        translate([ p[0], p[1], p[2] ]) rotate([ 90, p[3], 0 ]) hull() {
          cylinder(50, 6.5, 6.5);
          translate([ 15, 0, 0 ]) cylinder(50, 6.5, 6.5);
        }
    }
    translate([ -20, -10, -38 ]) cube([ 40, 20, 40 ]);
  }
}

assembly();

// auxiliary stuff
*color("#404040") translate([ 0, 0, -15 ]) linear_extrude(15) 2040_profile();
