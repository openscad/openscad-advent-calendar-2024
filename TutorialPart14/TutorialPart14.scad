/*
 * Welcome to the Advent Calendar - Tutorial Edition - Part 14
 */
 
// The Polygon and Polyhedron, can be created manually but we using
// loops to automate that.

step = 1; // [1:8]

/*** STEP 1 ***/

// We already have seen loops, so we start with creating points for a
// polygon.

function points(r = 20, fn = 10) = [
	let (chg = 360 / fn)
		for (i = [0:fn-1])
			[cos(i * chg), sin(i * chg)] * r
];

if (step == 1) {

echo(points());
polygon(points());

}

/*** STEP 2 ***/

// When having multiple shapes within one polygon we need to define the
// path that groups the points and orders them. It is just a list of
// the point number.

if (step == 2) {

p2 = concat(points(r = 20), points(r = 10));

echo(p2);

// This one does not look quite right.
color("red")
	translate([0, 30])
		polygon(p2);

// Adding the separate paths as 2 lists of indexes into the list of
// points produces the expected result.
color("green")
	translate([0, -20])
		polygon(points = p2, paths = [[for (i = [0:9]) i], [for (i = [10:19]) i]]);

}

/*** STEP 3 ***/

// We now use modulo to change every second point.  With i % 2, the
// remainder of i divided by 2, is 0 (false) for even numbers, and 1
// (true) for odd numbers.

function star(r = [10, 5], tips = 4) = [
	let (chg = 360 / (tips * 2))
		for (i = [0:tips * 2 - 1])
			[cos(i * chg), sin(i * chg)] * (i % 2 ? r[0] : r[1])
];

if (step == 3) {

for (tips=[4:8]) translate([(tips - 4) * 20 - 40,  0]) polygon (star(r = [10, 4], tips = tips));
for (tips=[4:8]) translate([(tips - 4) * 20 - 40, 20]) polygon (star(r = [ 5, 8], tips = tips));

}

/*** STEP 4 ***/

// To build a polyhedron we need points and faces, faces are similar
// to the paths in polygons But now we group them to form a triangle
// or connect multiple points in a plane.  And we are now in 3D so we
// need Z.
// Keep in mind these example are just One face and not valid closed
// polyhedrons.

// Let's make a short example.

// We can see every point in p has 3 values [x,y,z] while the faces is
// just one face that covers the shape by using all surounding point
// indices.
// The point index is the list position of a point starting with 0 for
// the first point.
// E.g.  p=[[0,0,0],[1,1,1],[2,2,2]];  then p[0]=[0,0,0] so the
// face [0,1,2] is using the 3 points in that order to make a face
// [p[0],p[1],p[2]].  If you now press F12 (thrown together) you see the
// face has a purple and white side while F10 is the normal (surface)
// view.  This is very importand as purple is the inside of a polyhedron
// and determined by the order of the points.

if (step == 4) {

p = [[0, 0, 0], [30, 0, 0], [0, 30, 0]];

polyhedron(p, faces = [[0, 1, 2]]);
translate([0, 0, 20]) polyhedron(p, faces = [[2, 1, 0]]);
 
// ‼ With just a single face, these are invalid polyhedrons - but
// you can see how it starts to form an object if all faces are in
// one polyhedron.

}

/*** STEP 5 ***/

// Let's make a valid polyhedron by defining all 5 sides of our prism, you
// may notice that you can change the values of each point after without
// the need to change the faces.  We now use the 6 points multiple times
// in different faces - but we could also define points for each face.

function p(z = 0) = [[0, 0, z], [30, 0, z], [0, 30, z]];

if (step == 5) {

points = [ 
	each p(0), // points 0,1,2 at Z = 0
	each p(20) // points 3,4,5 at Z = 20
];

echo(amount = len(points)); // total of 6 points

// The order of the points for each face is clockwise when seeing from
// the outside - and counterclockwise form the inside.
faces = [
	[0, 1, 2],    // bottom
	[5, 4, 3],    // top
	[1, 0, 3, 4], // side A as quad face
	[0, 2, 5, 3], // side B
	[2, 1, 4, 5], // side C (hypotenuse)
];

// A valid polyhedron, not showing any of the purple sides with F12 as the
// object is solid and the purple sides are all oriented to the inside.
color ("tan") polyhedron(points, faces);

}

/*** STEP 6 ***/

// lets use the same faces but with one changed point

if (step == 6) {

points = [ 
	// points 0,1,2 at Z = 0
	each p(0),
	// points 3,4,5 at Z = 5, 20 and 20
	each [p(5)[0], p(20)[1], p(20)[2]]
];

faces = [
	[0, 1, 2],    // bottom
	[5, 4, 3],    // top
	[1, 0, 3, 4], // side A as quad face
	[0, 2, 5, 3], // side B
	[2, 1, 4, 5], // side C (hypotenuse)
];

color("CadetBlue") polyhedron(points, faces);

}

/*** STEP 7 ***/

// Remember our Star? Let's use that to go 3D, for that we need to add a
// Z value.  We will now use a for loop to create all sides as the face
// generation is following a pattern the bottom and top are just all
// points indices listed the sides consist of 4 points counter clockwise,
// so when the i counter starts with 0 the point indices are [1,0,10,11]
// 10 and 11 are from the upper star when using 5 tips so each star
// is generated with 9 points which is our loop parameter.  For the
// next point i=1 will be [i+1, i, i+tips*2,i+tips*2+1] or [1+1 = 2, 1,
// 1+5*2=11, 1+5*2+1=12] so that is [2,1,11,12] you also could make a 5
// tip star with 10 points so the last point is the same as the first.
// This would change how you generate the faces.

function star3D(r = [30, 15], tips = 4, z = 0) = [
	let (chg = 360 / (tips * 2))
		for (i = [0:tips * 2 - 1])
			concat([cos(i * chg), sin(i * chg)] * (i % 2 ? r[0] : r[1]), z)
];

if (step == 7) {

tips = 5;
loop = tips * 2 - 1; // the length or number points of a star3D

points=[
	each star3D(r = [30, 15], z = 0, tips = tips), // base
	each star3D(r = [30, 15], z = 5, tips = tips)  // top
];

faces= [
	// base face
	[for(i=[0:loop])i ],
	// top face in reverse order
	[for(i=[loop:-1:0])i + tips*2 ],
	// sides creates a quad group for each side and modulo is used
	// to connect the last face to the first point
	for(i = [0:loop]) [(i + 1) % (tips * 2), i, i + tips * 2, (i + 1) % (tips * 2) + tips * 2]
];

echo(points, faces); // Yes, that is becoming quite complex
color("azure") polyhedron(points, faces = faces);

}

/*** STEP 8 ***/

// Ok that was something we could do with a linear_extrude and a polygon,
// too Let's now change the radii of the base and add a 3rd level that
// is smaller and lower You may notice that our quad faces are now
// broken into 2 triangles because they are not in a plane anymore.
// And the internal correction of openSCAD is at work here.

if (step == 8) {

tips = 5;
loop = tips * 2 - 1; // the length or number points of a star3D

points=[
	each star3D(r = [40, 20], z = 0, tips = tips), // base
	each star3D(r = [25, 12], z = 5, tips = tips), // 2nd level
	each star3D(r = [ 2,  5], z = 2, tips = tips)  // 3rd level
];

faces= [
	// base face
	[for (i = [0:loop]) i],
	// 3rd level face in reverse order
	[for (i = [loop:-1:0]) i + tips * 4],
	// 1st level sides creates a quad group for each side
	for (i = [0:loop]) [(i + 1) % (tips * 2), i, i + tips * 2, (i + 1) % (tips * 2) + tips * 2],
	// 2nd level sides just add the number of tips*2
	for (i = [0:loop]) [(i + 1) % (tips * 2), i, i + tips * 2, (i + 1) % (tips * 2) + tips * 2] + [1, 1, 1, 1] * tips * 2
];

color("gold") polyhedron(points, faces = faces);

}

/*** THE END ***/

/*********************************************************************/

  // License: CC0 (aka CC Zero) - To the extent possible under law,
 // Ulirch Bär has waived all copyright and related or neighboring rights to this work.
// https://creativecommons.org/publicdomain/zero/1.0/

// In this Tutorial we define every point by our own functions so these
// parameters have no effect.
$fa = 1; $fs = 0.2;
