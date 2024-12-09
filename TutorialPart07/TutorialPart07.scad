/*
 * Welcome to the Advent Calendar - Tutorial Edition - Part 07
 */

// In part 7, we will extend the understanding of using functions with a slight
// diversion, guiding you through the stepwise process for reasoning about
// the functional shape of objects.
//
// Let us begin with the greatest secret of the art:  Play around.
// Finding a good functional description for a shape is best done by starting
// with some approximate insight, and then rapidly making little tweaks to
// values until you gradually get yourself closer and closer to the sort
// of shape you see in your mind.
//
// We will explore this with polygon and list comprehensions for simplicity
// and focus, but this same reasoning process can be used for defining
// OpenSCAD functions that define shapes.

step = 8; // [1:8]

$fa = 1;
$fs = 0.4;

candle_r = 5;
candle_h = 40;
wick_h = 5;
flame_h = 8;

/*** STEP 1 ***/

// We are setting out to make a candle!  We know candles are round, so we
// can use rotate_extrude later to make a good candle, if only we can define
// the right shape for the top of a burning candle.  We want it to dip
// smoothly in the middle, rise up, then sort of level off with a rounded
// edge.
//
// First, let's plot a basic function, x^2 starting at height candle_h,
// with polygon, since x^2 has our dip in the middle!

if (step == 1) {
  candle_top = [for (x=[0:1/16:candle_r]) [x, candle_h + x^2]];
  echo(candle_top);
  // Here we make a polygon of the points for our mathematical function using
  // "each" to insert them into this list, then we add in the bottom right
  // and bottom left corner to complete the polygon.
  polygon([each candle_top, [candle_r, 0], [0, 0]]);
}

/*** STEP 2 ***/

// The polygon from step 1 clearly goes way too far up!  Let us use the
// insight that x^2 grows up, but for large numbers, x^3 grows faster.  So
// if we add x^2, but subtract x^3, this should turn around and go back down.

if (step == 2) {
  candle_top = [for (x=[0:1/16:candle_r]) [x, candle_h + x^2 - x^3]];
  echo(candle_top);
  polygon([each candle_top, [candle_r, 0], [0, 0]]);
}

/*** STEP 3 ***/

// Okay, it goes down too far, too fast.  But here is where the playing around
// starts.  We try different numbers.  We want x^3 to go down slower, so we
// start multiplying it by smaller numbers.  But then we see that x^2 still
// goes too far up for a candle dip, so we reduce that a little too, and we
// keep tweaking these values until we get some numbers that look to us like
// the dip and curve for the top of a candle.

if (step == 3) {
  candle_top = [for (x=[0:1/16:candle_r]) [x, candle_h + 0.4*x^2 - 0.064*x^3]];
  echo(candle_top);
  polygon([each candle_top, [candle_r, 0], [0, 0]]);
}

/*** STEP 4 ***/

// Now we can see this with rotate_extrude!  And we can color it white, and
// translate into place a tiny cylinder for the wick, colored black.
// This is starting to look a lot like a candle!

if (step == 4) {
  candle_top = [for (x=[0:1/16:candle_r]) [x, candle_h + 0.4*x^2 - 0.064*x^3]];
  color("white")
    rotate_extrude()
    polygon([each candle_top, [candle_r, 0], [0, 0]]);

  color("black")
    translate([0, 0, candle_h-1])
    cylinder(r=0.5, h=wick_h, $fn=8);
}

/*** STEP 5 ***/

// Now we should probably light our candle.  Let's get rid of the rest of the
// mode, and just focus on making a flame.  We can try to repeat the same
// trick, but if we imagine a flame, from the top down, it has a bigger
// turnaround from getting bigger to shrinking again.  So let's maybe try
// x^2 minus x^4 this time.
//
// To model from the "top down" of the flame, let's iterate over y, and
// define a y2 with "let" which is just distance from the top.

if (step == 5) {
  flame_side = [for (y=[0:1/16:flame_h]) let(y2=flame_h-y)
    [y2^2-y2^4, y]
  ];
  polygon([each flame_side, [0,0]]);
}

/*** STEP 6 ***/

// Well that escalated quickly.  If we zoom in around the y-axis for step 5,
// apparently it starts positive, but x^4 drags it very negative very fast.
// So let's play around with small coefficients on the y2^4 which bring this
// into the shape of a candle flame.  Here I balance it out, then I multiply
// the whole x coordinate by coefficients until I'm happy with 0.15 feeling
// "candle flame" in shape.

if (step == 6) {
  flame_side = [for (y=[0:1/16:flame_h]) let(y2=flame_h-y)
    [0.15*(y2^2-0.015*y2^4), y]
  ];
  polygon([each flame_side, [0,0]]);
}

/*** STEP 7 ***/

// We're getting close!  Let's bring back the rest of the candle model,
// rotate_extrude the flame, color it orangish-yellow with color #FFC800
// (by trying color values for red, green, blue, until it gets to a candle
// color I'm happy with), and give it an alpha of 0.7 to make it slightly
// transparent.  And then we'll translate it into place, overlapping the top
// 40% of the wick.

if (step == 7) {
  candle_top = [for (x=[0:1/16:candle_r]) [x, candle_h + 0.4*x^2 - 0.064*x^3]];
  color("white")
    rotate_extrude()
    polygon([each candle_top, [candle_r, 0], [0, 0]]);

  color("black")
    translate([0, 0, candle_h-1])
    cylinder(r=0.5, h=wick_h, $fn=8);

  flame_side = [for (y=[0:1/16:flame_h]) let(y2=flame_h-y)
    [0.15*(y2^2-0.015*y2^4), y]
  ];
  color("#FFC800", alpha=0.7)
    translate([0, 0, candle_h + wick_h*0.6])
    rotate_extrude()
    polygon([each flame_side, [0,0]]);
}

/*** STEP 8 ***/

// Well, seeing it in place helps us see some final tweaks to make!
// I think the flame looks a little short and fat for a candle flame, so
// I narrow it a little, 0.15 to 0.11 on x, and stretch it a little taller,
// with 1.3 multiplied onto the y coordinate.
//
// Now we have a beautiful candle and flame, with smooth outlines defined
// by mathematical functions that could not possibly be expressed with
// operations on fundamental primitives.
//
// Try exploring on your own with other functions, and build an intuition
// for various ways that you can define the outlines of shapes.
// Hint: You could make some beautiful candle holders with trig functions
// or many other functions similarly to the approach used here.

if (step == 8) {
  candle_top = [for (x=[0:1/16:candle_r]) [x, candle_h + 0.4*x^2 - 0.064*x^3]];
  color("white")
    rotate_extrude()
    polygon([each candle_top, [candle_r, 0], [0, 0]]);

  color("black")
    translate([0, 0, candle_h-1])
    cylinder(r=0.5, h=wick_h, $fn=8);

  flame_side = [for (y=[0:1/16:flame_h]) let(y2=flame_h-y)
    [0.11*(y2^2-0.015*y2^4), 1.3*y]
  ];
  color("#FFC800", alpha=0.7)
    translate([0, 0, candle_h + wick_h*0.6])
    rotate_extrude()
    polygon([each flame_side, [0,0]]);
}

/*** THE END ***/

/*********************************************************************/

// Written in 2024 by Ryan A. Colyer.
//
// To the extent possible under law, the author(s) have dedicated all
// copyright and related and neighboring rights to this software to the
// public domain worldwide. This software is distributed without any
// warranty.
//
// You should have received a copy of the CC0 Public Domain
// Dedication along with this software.
// If not, see <http://creativecommons.org/publicdomain/zero/1.0/>.


