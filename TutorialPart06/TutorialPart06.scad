/*
 * Welcome to the Advent Calendar - Tutorial Edition - Part 06
 */

// In part 6, we will look at functions and how to calculate values in
// general. OpenSCAD provides quite a number of builtin math functions,
// so we can't introduce all of them in this tutorial.

// A reference of what is available as builtin, not just in regard to
// math functions but for all areas of functionality, the GUI provides a
// link to the cheat sheet via Help -> Cheat Sheet which opens the link
// https://openscad.org/cheatsheet/index.html

step = 1; // [1:5]

/*** STEP 1 ***/

// The easiest way of displaying data is in the console window using
// echo(), but we can also add text to the model using the text() module.
//
// => Use Window -> Console to make sure the console window is visible

// First lets assign a numeric value to a variable "a" and create a
// second variable "b" calculated based on "a". We'll show this in both
// the console window and the 3D View.

// Normal variables in OpenSCAD just have normal names, no special
// character is used to mark them. This is different from the special
// variables like $fa we have seen earlier.

// It is important to understand that OpenSCAD variables behave like in
// math, you can assign them a value for one calculation (one evaluation
// of a script). For a later evaluation it can be changed, but it can
// not have multiple values for a single evaluation.

if (step == 1) {

a = 9;
b = 9 * 4 / 3;

// This outputs "ECHO: 3, 6" to the console window
echo(a, b);

// This adds the names to the output too
echo(variable_a = a, variable_b = b);

// The text() module can't output numbers, only strings, so we use the
// str() function that converts the number value in our variable a to
// a string
text(str(a));

translate([0, -20]) text(str(b));

}

/*** STEP 2 ***/

// Now lets use some math to generate a pentagon. Looking at a regular
// pentagon as explained in https://en.wikipedia.org/wiki/Pentagon we
// need 5 points on a circle separated by 72 degrees.

// We introduce a function called point, which will take a radius and an
// angle. Using the builtin functions sin() and cos() we can calculate
// the X/Y coordinates of the associated point on a circle.

function circle_point(r, a) = r * [-sin(a), cos(a) ];

if (step == 2) {

polygon([
	circle_point(15, 0),
	circle_point(15, 72),
	circle_point(15, 144),
	circle_point(15, 216),
	circle_point(15, 288),
]);

}

/*** STEP 3 ***/

// Functions can be recursive, one of the simplest recursive functions
// is the Factorial - https://en.wikipedia.org/wiki/Factorial

// We have a defined result of 1 for a value of 0, the result
// for all other (positive) values is defined of the value
// itself multiplied with the result of the previous value In
// OpenSCAD, we can write this condition using the so called ternary
// conditional operator which is common to many programming languages
// https://en.wikipedia.org/wiki/Ternary_conditional_operator

function factorial(v) = v <= 0 ? 1 : v * factorial(v - 1);

if (step == 3) {

v = 7;
text(str(v, "! = ", factorial(v)), halign="center");

}

/*** STEP 4 ***/

if (step == 4) {

}

/*** STEP 5 ***/

if (step == 5) {

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
