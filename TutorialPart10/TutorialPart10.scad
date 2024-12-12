/*
 * Welcome to the Advent Calendar - Tutorial Edition - Part 10
 */

step = 1; // [1:2]

/*** STEP 1 ***/

// With all the things we have learned so far, we can create a first
// model composed from multiple pieces.

// Let's grab the candle and the candle holder from the previous parts
// and put those into modules.

// From the candle holder we drop the cases for one or two candles to keep
// the module simpler for today. To make combining the two modules easier,
// we change the holder to use the candle radius instead of the diameter.

// As we obviously want to position the candle in the same place as the
// holders, we can extract this calculation as separate module. But
// OpenSCAD does not allow geometry to be given as module parameter.
// Instead there is a special module named children() that can access
// geometry written after a module just like in:
//
// translate([1, 0, 0]) cube(1);
//
// From perspective of the translate() module, the cube() is a child
// module.

// We can also use that to pass the candle module into the holder so
// the module can fully take care of the positioning while keeping the
// definition of the candle separat.

module candle_pos(n, r, z = 0) {
	for (a = [0:n-1])
		rotate(a * 360 / n)
			translate([8 * r, 0, z])
				children();
}

module candle(candle_r, candle_h = 30, wick_h = 5, flame_h = 8) {
  candle_top = [for (x=[0:1/16:candle_r]) [x, candle_h + 0.4*x^2 - 0.064*x^3]];
  color("white")
    rotate_extrude()
    polygon([each candle_top, [candle_r, 0], [0, 0]]);

  color("black")
    translate([0, 0, candle_h-1])
    cylinder(r=0.5, h=wick_h, $fn=8);

  flame_side = [for (y=[0:1/16:flame_h]) let(y2=flame_h-y)
    [0.11*(y2^2-0.015*y2^4), 1.3*y]
  ];
  color("#FFC800", alpha=0.7)
    translate([0, 0, candle_h + wick_h*0.6])
    rotate_extrude()
    polygon([each flame_side, [0,0]]);
}

module candle_holder(n, r, h = 10) {
	wall = 2; // fixed wall thickness

	color("PapayaWhip")
	difference() {
		union() {
			// Changing to the rotate_extrude() gives the base
			// rounded sides while not making it more difficult
			// to 3d-print.
			rotate_extrude() hull() {
				translate([10 * r - wall / 2, wall/ 2]) circle(d = wall);
				translate([ 6 * r + wall / 2, wall/ 2]) circle(d = wall);
			}
			candle_pos(n, r)
				cylinder(r = r + wall, h = h);
		}
		translate([0,0, wall/2])candle_pos(n, r)
			cylinder(r = r, h = h);
	}
	// Place the candles passed as child module but mark for preview
	// only, so on render (F6) the candles are not included.
	%candle_pos(n, r, h)
		children();
}

if (step == 1) {

n = 3;
candle_r = 5;

candle_holder(n, candle_r) candle(candle_r);

}

/*** STEP 2 ***/

// Because we used parameters in the modules, we can generate
// different models by simply changing those parameters.

if (step == 2) {

n = 4;
candle_r = 4;

candle_holder(n, candle_r) candle(candle_r, candle_h = 10);

}

/*** THE END ***/

/*********************************************************************/

// Written in 2024 by Torsten Paul <Torsten.Paul@gmx.de>
//
// To the extent possible under law, the author(s) have dedicated all
// copyright and related and neighboring rights to this software to the
// public domain worldwide. This software is distributed without any
// warranty.
//
// You should have received a copy of the CC0 Public Domain
// Dedication along with this software.
// If not, see <http://creativecommons.org/publicdomain/zero/1.0/>.

$fa = 2; $fs = 0.2;
