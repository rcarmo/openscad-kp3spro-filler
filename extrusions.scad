
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