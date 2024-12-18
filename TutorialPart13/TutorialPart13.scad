/*
 * Welcome to the Advent Calendar - Tutorial Edition - Part 13
 */

step = 1; // [1:7]

/*** STEP 1 ***/

// In this tutorial, we will use module recursion to create a snowflake
// generator!  First let us consider a few properties of snowflakes.
// Snowflakes are fractal in nature, branching off at 60 degree angles.
// To do module recursion, we must call the same module, but we want to
// do it only a finite number of times. So we will call Step1 with the
// variable i increasing by 1 each time, and not call it anymore if i
// is 2 or more.  We will also draw a cube in each call, and translate
// all the other calls to the end of the cube.
//
// Important note!  Notice how the rotate and translate combine when we
// use recursion.  Each subsequent recursion is rotated and translated
// onto the end of the one that called it, in a branching manner!
// Try to understand this carefully before proceeding.

module Step1(length, width, i=0) {
  color("white") color("white") cube([length, width, 0.1]);
  if (i < 2) {
    translate([length, 0, 0]) {
      Step1(length, width, i+1);
      rotate([0, 0, 60]) Step1(length, width, i+1);
      rotate([0, 0, -60]) Step1(length, width, i+1);
    }
  }
}

if (step == 1) {
  Step1(10, 2);
}

/*** STEP 2 ***/

// Another important property of snowflakes is that they, on average,
// tend to have pieces get shorter and thinner as they branch away.
// Not always, but on average, so let's start there.  We can just make
// the length and width shrink a bit for each call.  And let's add one
// more depth level.

module Step2(length, width, i=0) {
  length = 0.7*length;
  width = 0.7*width;
  color("white") color("white") cube([length, width, 0.1]);
  if (i < 3) {
    translate([length, 0, 0]) {
      Step2(length, width, i+1);
      rotate([0, 0, 60]) Step2(length, width, i+1);
      rotate([0, 0, -60]) Step2(length, width, i+1);
    }
  }
}

if (step == 2) {
  Step2(10, 2);
}

/*** STEP 3 ***/

// Now, real snowflakes start out from the center in all 6 directions,
// again at those 60 degree steps, so let's just loop over the initial
// angle.  It's starting to look snowflake-like!

if (step == 3) {
  for (a=[0:60:359]) {
    rotate([0, 0, a]) Step2(10, 2);
  }
}

/*** STEP 4 ***/

// One small defect is clear if you look at the center of step 3.
// The cubes are off-center, so we want to translate them down by half
// of their width.  Also, we want more variation in our snowflakes.
// Real snowflakes have their length and width of elements changing
// over time as they grow by changing atmospheric conditions as they
// fall and continue growing!
//
// So let's generate a long sequence (200 should be enough) of random
// values from 0 to just under 1, and at each step, we'll use these to
// raise or lower the length, and raise or lower the width.  For random
// values from 0 to 1, 10*random_value-5 will give us numbers from -5 to
// just under 5.  And with that 0.7 multiplied, we're still on average
// shrinking them at each depth.
//
// Let's also add some more recursion, and go to depth 6.
//
// Preview this step a bunch of times.  Each one will be different!
// Some will look great.  Some will be weirdly clunky.  And some will
// have gaps.  The gaps are because we didn't stop values from going
// negative...

randvals = rands(0,1,200);

module Step4(randvals, length, width, i=0) {
  length = 0.7*(length + 10*randvals[i] - 5);
  width = 0.7*(width + 2*randvals[i+1] - 1);
  translate([0, -width/2, 0]) color("white") cube([length, width, 0.1]);
  if (i < 6) {
    translate([length, 0, 0]) {
      Step4(randvals, length, width, i+2);
      rotate([0, 0, 60]) Step4(randvals, length, width, i+2);
      rotate([0, 0, -60]) Step4(randvals, length, width, i+2);
    }
  }
}

if (step == 4) {
  for (a=[0:60:359]) {
    rotate([0, 0, a]) Step4(randvals, 10, 2);
  }
}

/*** STEP 5 ***/

// Here, we'll add in a max at length and width, to keep the values
// positive.  We'll set a minimum length or width of 0.3.  Also, let's
// add a bit more asymmetry to look more real.  An easy trick is to
// just change the offset i for calls to the left or right recursion,
// so they are grabbing different random values from our list!

module Step5(randvals, length, width, i=0) {
  length = max(0.3, 0.7*(length + 10*randvals[i] - 5));
  width = max(0.3, 0.7*(width + 2*randvals[i+1] - 1));
  translate([0, -width/2, 0]) color("white") cube([length, width, 0.1]);
  if (i < 8) {
    translate([length, 0, 0]) {
      Step5(randvals, length, width, i+2);
      rotate([0, 0, 60]) Step5(randvals, length, width, i+3);
      rotate([0, 0, -60]) Step5(randvals, length, width, i+4);
    }
  }
}

if (step == 5) {
  for (a=[0:60:359]) {
    rotate([0, 0, a]) Step5(randvals, 10, 2);
  }
}

/*** STEP 6 ***/

// Stopping at a hard-stop of depth 8 was not an ideal way to stop, as
// it left the i+4 path getting there before the i+3 path, and so on.
// We can try some cleverer expression to stop.  For example, we first
// make sure we don't go past the length of our random values (although
// we have plenty), then we make sure that we keep iterating at least
// 10 times.  But then after that, we stop at random!  We just check a
// value, and 1/5th of the time, we stop.
//
// We can also move the randvals generation into a module call, so that
// we have a self-contained "Snowflake" module that generates a random
// snowflake each time it is called.

module SnowflakeRec(randvals, length, width, i=0) {
  length = max(0.3, 0.7*(length + 10*randvals[i] - 5));
  width = max(0.3, 0.7*(width + 2*randvals[i+1] - 1));
  translate([0, -width/2, 0]) color("white") cube([length, width, 0.1]);
  if ((i+10 < len(randvals)) && (i<10 || randvals[i+2] < 0.2)) {
    translate([length, 0, 0]) {
      SnowflakeRec(randvals, length, width, i+3);
      rotate([0, 0, 60]) SnowflakeRec(randvals, length, width, i+4);
      rotate([0, 0, -60]) SnowflakeRec(randvals, length, width, i+5);
    }
  }
}

module Snowflake() {
  randvals = rands(0,1,200);
  for (a=[0:60:359]) {
    rotate([0, 0, a]) SnowflakeRec(randvals, 10, 2);
  }
}

if (step == 6) {
  Snowflake();
}

/*** STEP 7 ***/

// And for the last step, let's just show the variety of what we can
// make with this.  Let's make a 3x3 grid of snowflakes (taking up the
// same area).

if (step == 7) {
  scale([1/3, 1/3, 1/3]) {
    for (x=[-80:80:80]) {
      for (y=[-80:80:80]) {
        translate([x, y, 0]) Snowflake();
      }
    }
  }
}

// Suggestions:  Try playing around.  If you compare these snowflakes
// to macro photos of real snowflakes, you'll notice these have more
// spiral asymmetry than real ones.  A next-step fix to account for
// this would have a covarying random variation on the side branches,
// plus a smaller separately varying asymmetry.  Perhaps think about
// how to modify this approach to add this property in!
//
// Then think about the numerous other things you could try making with
// recursive modules, and have fun!

/*** THE END ***/

/*********************************************************************/

// Written in 2024 by Ryan A. Colyer.
//
// To the extent possible under law, the author(s) have dedicated all
// copyright and related and neighboring rights to this software to
// the public domain worldwide. This software is distributed without
// any warranty.
//
// You should have received a copy of the CC0 Public
// Domain Dedication along with this software.  If not, see
// <http://creativecommons.org/publicdomain/zero/1.0/>.

