/*
 * Welcome to the Advent Calendar - Tutorial Edition - Part 03
 */

// In part 3, we'll start moving things around.

// For transforming our primitives, OpenSCAD has the 2 most basic
// operations translate() and rotate(), there is mirror() and also
// scale() and resize() for changing the geometry.

// We will leave mirror() for tomorrow, but there's still quite a
// lot of operations, so lets get started.

step = 1; // [1:7]

/*** STEP 1 ***/

// The maybe simplest operation is translation which can move geometry
// in any axis or multiple axes at the same time.
//
// 2D shapes can only moved in the X/Y plane, be giving a translation
// value for each or the 2 axes.
//
// The operation is written directly before the geometry it is supposed
// to affect.

if (step == 1) {

translate([5, 2]) square(10);

}

/*** STEP 2 ***/

// Rotation in 2D is always done around the Z axis, so the shapes remain
// in the X/Y plane as expected. OpenSCAD uses angles in degrees, so a
// 8th rotation needs a value of 45. The rotation is always around the
// origin of the coordinate system in anti-clockwise direction.

if (step == 2) {

rotate(45) square(10);

}

/*** STEP 3 ***/

// When combining translation and rotation, the order of the operations
// is important. In this example, we first do a 45 degree rotation and
// then a translation of 5 units in the positive Y direction.

// Find the small axis cross at the left bottom of the 3D view to see
// which axis goes into which direction. The lines of the axis cross
// denote the positive directions.

if (step == 3) {

translate([0, 5]) rotate(45) square(10);

}

/*** STEP 4 ***/

// Now lets step up things a bit by going into 3-dimensional space.

// => Move and rotate the 3D view for a better look at where the sphere()
// ended up.

// There are also 6 buttons in the toolbar below the 3D view which make
// the camera look straight along any of the axes in positive or negative
// direction.

// In addition it's possible to switch between perspective and orthogonal
// view, perspective mode is looking more realistic as things farther away
// are shown smaller. Orthogonal view can help aligning things as things
// are always shown in their defined size, regardless of the distance to
// the camera.

if (step == 4) {

translate([10, 10, 8]) sphere(5);

}

/*** STEP 5 ***/

// Yesterday we have seen that cylinders or cones are always created in
// the same orientation. But with rotate() we can transform a cylinder()
// so it's located around the X axis.

// To achieve that, we have to rotate() 90 degress around the Y axis.

if (step == 5) {

rotate([0, 90, 0]) cylinder(d = 5, h = 30, center = true);

}

/*** STEP 6 ***/

// Scaling and resizing are similar but different in an important way,
// using scale() a relative size change will be applied, giving a value
// of 1 for an axis means the geometry is not changed in that direction.

if (step == 6) {

scale([3, 1, 0.25]) sphere(5);

}

/*** STEP 7 ***/

// When using resize, the values are absolute target values, basically
// giving the new size of the object in that axis.

// The special value of 0 will leave the axis with that value unchanged.

if (step == 7) {

resize([3, 40, 0]) sphere(5);

}


/*** THE END ***/

// Now that we can create primitives and move them around, it's time
// to start combining them.

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
