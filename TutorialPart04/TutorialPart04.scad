/*
 * Welcome to the Advent Calendar - Tutorial Edition - Part 04
 */

// In part 4, we can finally see how to create more complex things using
// the geomeric primitive. For that we don't just need to transform
// those primitives but also define how they interact with each other.
//
// For that we are going to use the three basic operations of Constructive
// Solid Geometry (CSG): Union, Difference and Intersection.

step = 1; // [1:4]

/*** STEP 1 ***/

// Union combine multiple geometric objects into a single one. In this
// case, we combine a rectangular plate with a cylinder.

if (step == 1) {

union() {
	cube([20, 10, 2], center = true);
	cylinder(r = 4, h = 10);
}

}

// Both primitives sit on the X/Y plane, the union() combines the,
// removing the overlapping geometry of the cylinder inside the cuboid.

/*** STEP 2 ***/

// The next operation is difference() which uses it's first geometry as
// basis and removes all following objects from it.

if (step == 2) {

difference() {
	union() {
		cube([20, 10, 2], center = true);
		cylinder(r = 4, h = 10);
	}
	
	translate([ 0, 0, -2]) cylinder(r = 3, h = 14);
	translate([-8, 0, -2]) cylinder(r = 1, h = 4);
	translate([ 8, 0, -2]) cylinder(r = 1, h = 4);
}

}

/*** STEP 3 ***/

// The third operation is intersection() which retains only the
// overlapping geometry. In the example, we keep the overlapping parts
// of a cube and a sphere. This creates a dice like shape with flat
// sides from the cube and rounded corners from the sphere.

if (step == 3) {

intersection() {
	cube(14, center = true);
	sphere(10);
}

}

/*** STEP 4 ***/

// Combining all this, we can create the visualization that is shown on
// the CSG Wikipedia page.
// https://en.wikipedia.org/wiki/Constructive_solid_geometry

// A more detailed model of that can be found via the menu entry
// File -> Examples -> Basics -> CSG-modules.scad

if (step == 4) {

translate([0, 0, 20]) {
	difference() {
		intersection() {
			cube(12, center = true);
			sphere(8);
		}
		cylinder(h=20, r=4, center=true);
		rotate([90, 0, 0]) cylinder(h=20, r=4, center=true);
		rotate([0, 90, 0]) cylinder(h=20, r=4, center=true);
	}
}

translate([-20, 0, 0]) {
	intersection() {
		cube(6, center = true);
		sphere(4);
	}
}

translate([-30, 0, -20]) {
	cube(6, center = true);
}

translate([-18, 0, -20]) {
	sphere(4);
}

translate([16, 0, 0]) {
	union() {
		cylinder(h=10, r=2, center=true);
		rotate([90, 0, 0]) cylinder(h=10, r=2, center=true);
		rotate([0, 90, 0]) cylinder(h=10, r=2, center=true);
	}
}

translate([2, 0, -20]) cylinder(h=10, r=2, center=true);
translate([12, 0, -20]) rotate([0, 90, 0]) cylinder(h=10, r=2, center=true);
translate([22, 0, -20]) rotate([90, 0, 0]) cylinder(h=10, r=2, center=true);

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

$fa = 4; $fs = 0.2;
