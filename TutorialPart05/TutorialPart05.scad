/*
 * Welcome to the Advent Calendar - Tutorial Edition - Part 05
 */

// In part 4, we saw how to combine geometry. With more complex models
// it sometimes can get difficult to see where specific geometry appears
// in the model.

step = 1; // [1:8]

/*** STEP 1 ***/

// Consider this example which is supposed to be a cube with a horizontal
// hole. But it appears to not work at all, only showing the cube.

if (step == 1) {

difference() {
	translate([0, 10, 0]) cube(10);
	translate([5, 9, 5]) rotate([90, 0, 0]) cylinder(r = 3, h = 12);
}

}

/*** STEP 2 ***/

// Using the # modifier infront of geometry will highlight it is
// transparent red, even if it is subtracted from somewhere.  With that
// modifier added, we can see the cylinder ended up in the wrong place. We
// can fix the issue by changing the rotation from 90 degrees around
// the X axis to -90 degrees.

// => Change the value of the rotation and preview (F5) again.

// With the rotation corrected, the cylinder correctly shows up in the
// middle of the cube, still highlighted.

// => Run the render step (F6), that now shows the model as it is supposed
// to look like. The highlight only happens in preview.

if (step == 2) {

difference() {
	translate([0, 10, 0]) cube(10);
	#translate([5, 9, 5]) rotate([-90, 0, 0]) cylinder(r = 3, h = 12);
}

}

/*** STEP 3 ***/

// Once satisfied with the model, we can remove the modifier again and
// the preview is showing the model as expected.

if (step == 3) {

difference() {
	translate([0, 10, 0]) cube(10);
	translate([5, 9, 5]) rotate([-90, 0, 0]) cylinder(r = 3, h = 12);
}

}

/*** STEP 4 ***/

// Another way if focusing on detail of a model is using the ! modifier
// that will cause only the marked geometry to be shown. In our example
// we have a simple box with a sphere mostly hidden inside.

if (step == 4) {

difference() {
	translate([0, 0, 3]) cube([20, 20, 10]);
	translate([1, 1, 2]) cube([18, 18, 10]);
}

union() {
	cube([20, 20, 1]);
	translate([1, 1, 0]) cube([18, 18, 2]);
	translate([10, 10, 3]) sphere(3);
}

}

/*** STEP 5 ***/

// Adding the ! modifier infront of the union() will keep only this
// geometry, skipping all the other declared geometry even though it's
// unchanged in the file.

// Note that the ! can be given only once, as it is supposed to mark
// the single code block to be shown and rendered.

if (step == 5) {

difference() {
	translate([0, 0, 3]) cube([20, 20, 10]);
	translate([1, 1, 2]) cube([18, 18, 10]);
}

!union() {
	cube([20, 20, 1]);
	translate([1, 1, 0]) cube([18, 18, 2]);
	translate([10, 10, 3]) sphere(3);
}

}

/*** STEP 6 ***/

// The third modifier is %. This can be used to add some informational
// geometry that will show up in the preview as transparent gray but
// will not get added to the final model.

// => Preview (F5) shows the small cubes at the corners of the model

// => Render (F6) shows only the first cuboid of the model

if (step == 6) {

cube([20, 20, 1]);

%union() {
	cube(2);
	translate([ 0, 18, 0]) cube(2);
	translate([18,  0, 0]) cube(2);
	translate([18, 18, 0]) cube(2);
}

}

/*** STEP 7 ***/

// The fourth and last modifier is * which acts as a structure aware
// comment and will comment out the whole section of statements it is
// marking. So by just adding the * infront of the difference, it will
// remove the whole content of that code block regardless of the number
// of lines it spans.

if (step == 7) {

cylinder(r = 4, h = 4);

*difference() {
	translate([0, 10, 0]) cube(10);
	translate([5, 9, 5]) rotate([-90, 0, 0]) cylinder(r = 3, h = 12);
}

}

/*** STEP 8 ***/

// Another important topic when generating models is the resolution the
// mesh will be generated with. OpenSCAD using mesh output means that
// the output files can't represent ideal circles or spheres.

// The mesh resolution is controlled by special variables $fa, $fs
// and $fn.

// All 3 variables control a different way of defining resolution
// $fa = angular resolution in degrees
// $fs = segment resolution in OpenSCAD units
// $fn = fixed number of subdivision

// In general, it's advisable to use $fa and $fs as those scale with
// the objects generated, where $fn can cause a resolution too low for
// big objects, but much too high for small ones.

// The values for those variables can be given in almost all places
// affecting the part of the design generated at this point.

// The higher the resolution for mesh generation is set, the longer it
// will take to render the mesh, so keeping a reasonable low resolution
// is key for working efficiently. Usually it's better to look for the
// needed output resolution, e.g. for 3D printing and not trying to make
// the preview look perfect.

// Default values for $fa and $fs, can easily be set at the beginning of
// the main file. Those will affect all places that do not specifically
// override the values.

if (step == 8) {

// fixed number of segments, regardless of size
translate([-3, 0, 5]) rotate([90, 0, 0])
	cylinder(r = 5, h = 1, $fn = 5);

// $fa takes precedens as it allows fewer subdivisions than $fs
// Angular resolution of 60 degress means we are getting a hexagon
translate([9, 0, 5]) rotate([90, 0, 0])
	cylinder(r = 5, h = 1, $fa = 60, $fs = 0.1);

// $fs takes precedens as it allows fewer subdivisions than $fa
// Segment length is calculated as: s = ceil(r * 2 * PI / $fs) so with
// a radius of 5, the circumference of the circle is ~31.42, dividing
// by our $fs value of 5, we get ~6.3 and therefor 7 segments.
translate([21, 0, 5]) rotate([90, 0, 0])
	cylinder(r = 5, h = 1, $fa = 1, $fs = 5);

}

/*** THE END ***/

// More details on the modifiers can be found in the user manual at
// https://en.wikibooks.org/wiki/OpenSCAD_User_Manual/Modifier_Characters

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
