/*
 * Welcome to the Advent Calendar - Tutorial Edition - Part 08
 */

// In part 7, we saw rotate_extrude() being used for creating a candle.
// In // this part, we look at both extrude modules available in OpenSCAD.
//
// Extrusion in geometry is an operation that increases the dimensions
// of an object. In OpenSCAD, that is specifically from 2D shapes into
// 3D objects.

step = 1; // [1:7]

/*** STEP 1 ***/

// Let's look at rotate_extrude() in more detail. As the name implies, it
// uses the 2D shape and rotates it to form a 3D object, but how exactly?

// First we need a 2D shape so we create a small triangle.  As 2D shape,
// it lives on the X/Y plane. We translate it a bit on the X axis so
// it's not touching the Y axis anymore.

if (step == 1) {

translate([10, 0])
	polygon([[0, 0], [0, 12], [8, 0]]);

}

/*** STEP 2 ***/

// Now we apply the rotate_extrude().In OpenSCAD, the rotation is always
// around the Z axis. But it did not just rotate the 2D shape. Before the
// rotation, the shape was flipped from the X/Y plane to the X/Z plane
// or we could also say it was rotated around the X axis by 90 degrees.

// The result of the rotate_extrude() is then a ring with triangular
// cross section.

if (step == 2) {

rotate_extrude()
	translate([10, 0])
		polygon([[0, 0], [0, 12], [8, 0]]);

}

/*** STEP 3 ***/

// The rotate_extrude() module has an optional parameter that allows
// the extrusion to stop at a given angle. In the example we use
// 90 degrees giving only a quarter of the ring in the first octant of
// the coordinate system.

if (step == 3) {

rotate_extrude(angle = 90)
	translate([10, 0])
		polygon([[0, 0], [0, 12], [8, 0]]);

}

/*** STEP 4 ***/

// When using rotate_extrude(), all the 2D geometry needs to be on one
// side positive or negative of the X axis.

// If the 2D shape is located on the negative X side, the extrusion will
// start there, which can be observed in case an angle < 360 degrees
// is given.

if (step == 4) {

// square on positive X
translate([0, 5, 0])
	rotate_extrude(angle = 180)
		translate([10, 0])
			square([5, 10], center = true);

// square on negative X
translate([0, -5, 0])
	rotate_extrude(angle = 180)
		translate([-10, 0])
			square([10, 5], center = true);

}

/*** STEP 5 ***/

// The second extrude module is linear_extrude(). As the name implies,
// this moves a 2D shape on a linear (straight) path to create the
// 3D object.

// For linear_extrude() the 2D shape is not changed in orientation,
// the extrusion moves by default into positive Z direction or with the
// parameter center = true into both positive and negative Z.

if (step == 5) {
	
translate([10, 0, 0])
	linear_extrude(10)
		circle(5);

translate([-10, 0, 0])
	linear_extrude(10, center = true)
		circle(5);

}

/*** STEP 6 ***/

// Linear extrusion in OpenSCAD has a number of additional parameters
// that allow for changing the scale and rotation of the 2d shape while
// the extrusion.

// Both scaling and twisting use the origin as reference point for the
// operation, so the location of the 2D shape relative to the coordinate
// origin is important.

// Scaling can be given as both a single number which is applied to
// both X and Y dimension. Giving separate X and Y values can create
// some very useful shapes.

if (step == 6) {

linear_extrude(20, scale = [0.2, 0.8])
	circle(15);

}

/*** STEP 7 ***/

// The twist parameter specifies how much (in degrees) the 2D shape is
// rotated around the Z axis along the extrusion.

if (step == 7) {
	
linear_extrude(20, twist = 90)
	square([12, 5´], center = true);

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

$fa = 1; $fs = 0.2;
