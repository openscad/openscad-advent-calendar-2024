/*
 * Welcome to the Advent Calendar - Tutorial Edition - Part 12
 */
 
// We will have a look how to create models using loops.

step = 1; // [1:8]

/*** STEP 1 ***/

// First we understand a FOR loop that is creating instances for each
// iteration. In this example, we create 5 cubes in a loop but translate
// them based on the loop variable so they end up in different places.

if (step == 1) {

for (i = [0:4]) translate([i, i]) cube();

}

/*** STEP 2 ***/

// That can also count in different increments, like 2 - notice the
// last number reached is now 6 so we get 4 cubes with a bit of spacing
// between them.

if (step == 2) {

for (i = [0:2:7]) translate([i, i]) cube();

}


/*** STEP 3 ***/

// We can also use a defined list. The order of the values in the list
// does not matter for the generation of the 3D geometry.

if (step == 3) {

for (i=[-2, 0, 3, 1, 5]) translate([i, i]) cube();

}

/*** STEP 4 ***/

// Now let us make this a bit more interesting, we rotate the element.
// Keep in mind that 0 and 360 is the same position so we just need
// the step before (360-5) else we get one element twice.

if (step == 4) {

for (rot=[0:5:355])
	rotate([0, rot, 0])
		translate([10, 0])
			cylinder(h = 1, d = 10, $fn = 3, center = true);

}


/*** STEP 5 ***/

// We also have learned last time that hull() can be used to enclose
// two 2D objects, that works also in 3D.

// So what happens here? We enclosed two objects of our loop in a way
// that the second one is at the position of the next loop instance. While
// rot = 0 the second is at 5, when rot = 5 the second is 10 and so on.

// This gives us a hull sequence or chain hull. Using this technique,
// we can fill the gaps between 2 pieces while still generating model
// that is not convex. Using a single hull() around the whole ring of
// objects would also fill the hole in the middle.

if (step == 5) {

increment = 5;

for (rot = [0:increment:360-increment]) {
	hull() {
		rotate([0, rot, 0])
			translate([10, 0])
				cylinder(h = 1, d = 10, $fn = 3, center = true);
		rotate([0, rot + increment, 0])
			translate([10, 0])
				cylinder(h = 1, d = 10, $fn = 3, center = true);
	}
}

}

/*** STEP 6 ***/

// As our cylinder has some height this will leave some small
// imperfections but we can improve that so only the base edges are in
// contact. Also we using an separate parameter "j" for the second hull
// object. With offset() we can round the corners.

if (step == 6) {

increment = 5;

for (i = [0:increment:360-increment]) {
	hull() {
		j = i + increment;
		rotate([0, i, 0])
			translate([10, 0])
				linear_extrude(0.1, scale = 0.1)
					offset(2)
						circle(5 - 2, $fn = 3);
		rotate([0, j, 0])
			translate([10, 0])
				linear_extrude(0.1, scale = 0.1)
					offset(2)
						circle(5 - 2, $fn = 3);
	}
}

}

/*** STEP 7 ***/

// Finally we intruduce another rotation (twist) also we replace the
// two hull objects with a loop that instantiate both. For some extra
// visuals, we add some color too.

if (step == 7) {

increment=5;
twist = 360 * 3;

for (i = [0:increment:360-increment])
	color([abs(sin(i)), abs(cos(i)), 0.2])
		hull()
			for (h = [i, i + increment])
				rotate([0, h, 0])
					translate([10, 0])
						rotate(h / 360 * twist)
							linear_extrude(0.1, scale = 0.1)
								offset(2)
									circle(5 - 2, $fn = 3);

}





/*** STEP 8 ***/

// As the hull() is always a convex hull, we need to work around that
// if we want a concave profile. The color of the negative part is shifted

// Note that this generates a relative complex geometry that can be slow
// to display.

// If you get a warning like "Normalized tree is growing past 200000
// elements.  Aborting normalization.", you can increase that value in
// the Preferences -> Advanced -> Turn of rendering at X elements. This
// setting is a guard against too complex models causing a very slow
// display. Modern computers should be able to handle a value of
// 1 million safely.

if (step == 8) {

increment = 3;
twist = 240;

difference() {
	union()
		for (i = [0:increment:360-increment])
			color([abs(sin(i)), abs(cos(i)), 0.2])
				hull()
					for (h = [i, i + increment])
						rotate([0,h,0])
							translate([10, 0])
								rotate(h / 360 * twist)
									linear_extrude(0.1, scale = 0.1)
										offset(2)
											circle(5 - 2, $fn = 3);
	//negative part 3× (rot)
    for (i = [0:increment:360-increment], rot=[60,180,300])
		color([abs(cos(i)),0,abs(sin(i))])
			hull()
				for(h = [i, i + increment])
					rotate([0, h, 0])
						translate([10, 0])
							rotate(h / 360 * twist)
								rotate(rot)
									translate([5, 0])
										linear_extrude(0.1, scale = 0.1)
											circle(3, $fn = 24);
}

}

/*** THE END ***/

/*********************************************************************/


  // License: CC0 (aka CC Zero) - To the extent possible under law,
 // Ulirch Bär has waived all copyright and related or neighboring rights to this work.
// https://creativecommons.org/publicdomain/zero/1.0/

$fa = 1; $fs = 0.2;
