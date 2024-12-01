/*
 * Welcome to the Advent Calendar - Tutorial Edition - Part 01
 */

// This part will introduce how the tutorial is structured,so
// please hang in there for more interesting things to come over
// the following days.

// The tutorial has 15 parts, with each part containing multiple
// steps introducing features, or tips & tricks on how to use
// OpenSCAD.

// In the top of the script there's going to be a "step" variable
// that allows selecting the step that should be shown in the
// 3D View (or maybe sometimes in the Console Window).

step = 1;

/*** STEP 1 ***/

// In step 1 of this introduction, we will start with the classic
// "Hello World" example most computer language introductions start
// with (https://en.wikipedia.org/wiki/%22Hello,_World!%22_program).
//
// As we are in the world of 3D geometry, we will not actually use
// words, but one of the simplest geometric primitive, The Cube.
//
// OpenSCAD does not define any real world units, so we don't have
// millimeters, inches and so on. It's just a number, or maybe call
// it OpenSCAD units.
//
// Note that our cube is touching the origin (the point where all
// 3 coordinates are zero) with one corner. The cube is fully in
// the first octant with all positive coordinates.
// https://en.wikipedia.org/wiki/Octant_(solid_geometry)
//
// => Press the F5 key (Preview) to show the cube.
// => Use the mouse in the 3D view to move and rotate the camera
// => Try the zoom and reset-view buttons below the 3D view

if (step == 1) {

cube(10); // A cube with edges of 10 units.

}

/*** STEP 2 ***/

// In step 2, we again have a cube, but it is a bit smaller, the
// edges are only 5 units long, but instead of touching the origin
// with one corner, it's centered around the origin, so each of
// the corners of the cube is in a different octant.
//
// => Change the "step = 1" to "step = 2" at the top of the file
// => Press F5 to show the cube of step 2

if (step == 2) {

cube(5, center = true); // A centered cube with edges of 5 units.

}

/*** THE END ***/

// That's it already for today. Now that you know how to follow
// the steps through the tutorial parts, we will start creating
// some more interesting things than just cubes.

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
