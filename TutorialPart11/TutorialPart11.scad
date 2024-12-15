/*
 * Welcome to the Advent Calendar - Tutorial Edition - Part 11
 */

// In programming there are often multiple solutions to a given goal.
// We will look at some to create a rounded square.

step = 1; // [1:8]

radius = 2.5;

/*** STEP 1 ***/

// Starting with minkowski which is moving one object along another.
// To ensure the right size, we need to make the square smaller and
// translate it (or the circle) by the radius.

if (step == 1) {

size = [20, 10];

minkowski() {
	translate([radius, radius]) square(size - [radius,radius] * 2);
	circle(radius);
}

}

/*** STEP 2 ***/

// Another way is to construct it from parts. With the advantage to use
// different radii for each corner. First we place the corner circles
// via the user defied module corner_circles(). Then and fill the space
// in between with two squares.

module corner_circles(size, radius = [1,1,1,1] * radius) {
     translate([radius[0],radius[0]]) circle(radius[0]);
     translate([size.x, 0] + [-radius[1], radius[1]]) circle(radius[1]);
     translate([0, size.y] + [radius[2], -radius[2]]) circle(radius[2]);
     translate(size - [radius[3], radius[3]]) circle(radius[3]);
}

if (step == 2) {

size = [10, 30];

corner_circles(size);

translate([radius, 0]) square([size.x - radius * 2, size.y]);
translate([0, radius]) square([size.x, size.y - radius * 2]);

}

/*** STEP 3 ***/

// Instead of calculating how to fill the space between the corner
// circles, we can use hull() that will automatically calculate the
// convex hull around the geometry given as child modules.  This also
// makes it much easier when the radius of the corners is not the same
// for all 4 corners.

if (step == 3) {

size = [25, 25];

hull() {
	corner_circles(size, radius=[radius, radius, radius / 2, radius * 2]);
}

}

/*** STEP 4 ***/

// We can make the code much more concise when we have the same radius
// for all cornets. In this case we can use a loop to generate the 4
// corner circles.

if (step == 4) {

size = [20, 30];

hull()
	for(tx = [radius, size.x - radius], ty = [radius, size.y - radius])
		translate([tx, ty])
			circle(radius);

}

/*** STEP 5 ***/

// Another different approach is using offset() which moves the outline
// of a 2D shape outward (for positive values) or inward (for negative
// values).  The r parameter adds an arc to each corner when expanding
// the shape.

if (step == 5) {
	
size = [30, 20];

translate(radius * [1, 1])
	offset(radius)
		square(size - [radius, radius] * 2);

}

/*** STEP 6 ***/

// As mentioned in the previous step, offset() can use negative values
// too, so we can remove the calculation by using it twice to shrink
// and then expand the square.

if (step == 6) {

size = [15, 25];

offset(radius)
	offset(-radius)
		square(size);
	
}

/*** STEP 7 ***/

// Another way of creating the target shape is by creating a polygon
// directly.  This is a bit more complex, first we create a function
// to make an arc with parameter to rotate and translate. And we need
// to handle the resolution fn ourselves as when calculating all points
// already, the built-in $fa, $fs and $fn values don't apply.

// It is not easily visible but the points are counter clockwise starting
// at x = radius, y = 0 and drawing the arc to x = 0, y = radius and
// obviously we need 4 of them combined in the next step.

function arc(r, deg = 90, rot = 0,t = [0, 0], fn = 10) = [
	for (i = [0:fn])
		[cos(deg / fn * i + rot), sin(deg / fn * i + rot)] * r + t
];

if (step == 7) {

echo(arc(radius)); // show points in console window
polygon(arc(radius)); // draw the arc geometry

}

/*** STEP 8 ***/

// We are creating the points by putting 4 arc after each other.  This can
// be done with "each" or by calling the concat() function with all the
// 4 arc point lists.  We just need to keep in mind how to order them, so
// all points are ordered counter clockwise.

if (step == 8) {

size = [10, 20];

points = [
  each arc(radius, rot =   0, t = size - radius * [1, 1]),        // upper right
  each arc(radius, rot =  90, t = [0 + radius, size.y - radius]), // upper left
  each arc(radius, rot = 180, t = [0 + radius, 0 + radius]),      // lower right
  each arc(radius, rot = -90, t = [size.x - radius, 0 + radius])  // lower left
];

echo(points) // that is a lot of points in the console
polygon(points); // and generate the rounded rectangle

}

/*** THE END ***/

// So why show all those different ways for generating essentially the
// same geometry? This exercise is mainly trying to convey the idea
// that even though OpenSCAD does not provide a huge amount of built-in
// functions and modules, there are often still many different ways of
// reaching a spcific goal. In most cases they have slightly different
// properties, e.g. in our example that could be in regard to extension
// to n-gons (Pentagons, Hexagons, ...) or maybe allowing each of the
// corners to have a different radius.
// When writing a module that may be reused later, it helps thinking
// about which parameters should be available for a user to be changed.

/*********************************************************************/

  // License: CC0 (aka CC Zero) - To the extent possible under law,
 // Ulirch Bär has waived all copyright and related or neighboring rights to this work.
// https://creativecommons.org/publicdomain/zero/1.0/

$fa = 1; $fs = 0.2;
