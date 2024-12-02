/*
 * Welcome to the Advent Calendar - Tutorial Edition - Part 02
 */

// In part 2, we'll introduce the geometric primitives OpenSCAD provides.
// Combining those shapes is the main way of constructing models. This
// is called CSG, Constructive Sold Geometry which is the topic of a
// later part.
//
// https://en.wikipedia.org/wiki/Constructive_solid_geometry

// There are 2 main categories of primitives: 2D and 3D. OpenSCAD only
// provides a very minimalistic list of primitives in those 2 categories.

step = 1; // [1:8]

/*** STEP 1 ***/

// Lets start with 2D primitives. OpenSCAD only has 3 of those. The
// first 2D primitive is the square().
//
// 2D primitives are limited to live in the X/Y plane, it's not possible
// to position them in 3D space.
//
// => The preview (F5) shows 2D primitives with 1 unit thickness which
// can be a bit confusing when working with very small objects.
// => Use the render (F6) display for a different view that clearly
// shows the 2D shapes.

if (step == 1) {

square(12);

}

/*** STEP 2 ***/

// Just like with the cube(), square() can not just generate square
// shapes but also rectangles by specifying a different value for the
// X and Y axes. The center parameter is also available, causing the
// primitive to be generated centered in the X/Y plane.

if (step == 2) {

square(size=[30, 10], center = true);

}

/*** STEP 3 ***/

// The second 2D primitive is the circle() which can be specified by
// radius "r=" or diameter "d=". The circle() primitive is always centered at the
// origin in the X/Y plane.

if (step == 3) {

circle(d = 30);

}

/*** STEP 4 ***/

// The third 2D primitive is the polygon which can generate even pretty
// complex shapes by listing all the point of the shape. Polygons
// are always closed, it's not needed to give an identical start and
// end point. As this can get very complex it may help to write the points in different lines.

if (step == 4) {

polygon([
	[ 0,  0], [ 0, 20],
	[20,  0], [20, -5],
	[ 5, 10], [ 5,  0] 
]);

}

/*** STEP 5 ***/

// Now we come to the 3D primitives, OpenSCAD has 4 of those, the cube()
// we have already seen, so lets move on to the sphere(). Similar to
// the circle(), we can give the size as radius or as diameter.

if (step == 5) {

sphere(r = 12);

}

/*** STEP 6 ***/

// The third 3D primitive is the cylinder() which can not just generate
// cyliders, but also (optionally truncated) cones. Cylinders are always
// centered around the Z axis, and by default are sitting on top of
// the X/Y plane. Using center = true, it's possible to also center the
// generated primitive in Z direction.

if (step == 6) {

cylinder(d = 20, h = 5);

}

/*** STEP 7 ***/

// For generating a truncated cone, you can give either r1 and r2 as
// radius or d1 and d2 as diameter. The values r1 or d1 are used for
// the size of the bottom and r2 or d2 for the top.

if (step == 7) {

cylinder(r1 = 10, r2 = 2, h = 20, center = true);

}

/*** STEP 8 ***/

// The fourth and last 3D primitive is the polyhedron() which is not
// easy to define as it needs both a list of all the points and a list
// of faces which are required to fo´llow a number of rules.
// We will only show an example here but skip it for this tutorial,
// it's complicated and powerful enough to deserve it's own tutorial.

if (step == 8) {

polyhedron(
	[
		[10, 10, -8], [10, -10, -8], [-10, -10, -8], [-10, 10, -8],
		[12, 12,  0], [12, -12,  0], [-12, -12,  0], [-12, 12,  0],
		[ 6,  6,  8], [ 6,  -6,  8], [ -6,  -6,  8], [ -6,  6,  8]
	], [
		[3, 2, 1, 0], // bottom
		[0, 1, 5, 4], [1, 2,  6, 5], [2, 3,  7,  6], [3, 0, 4,  7],
		[4, 5, 9, 8], [5, 6, 10, 9], [6, 7, 11, 10], [7, 4, 8, 11],
		[8, 9, 10, 11] // top
	]
);

}

/*** THE END ***/

// With that, we have all the building blocks for generating more complex
// models, but so far the primitives (except polygon() and polyhedron()
// are always in the same place and orientation.
// Tomorrow we'll see how to move things around.

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
