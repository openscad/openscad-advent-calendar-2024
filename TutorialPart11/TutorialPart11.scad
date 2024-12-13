/*
 * Welcome to the Advent Calendar - Tutorial Edition - Part 11
 */
 
 // In programming there are often multiple solutions
// we will look at some to create a rounded square


step = 1; // [1:8]

size=[20,10];
radius=2.5;

/*** STEP 1 ***/
// Starting with minkowski which is moving one object along another
// to ensure the right size we need to make the square smaller and translate it (or the circle) by the radius.

if (step==1){
  color("cornflowerBlue")minkowski(){
    translate([radius,radius])square (size-[radius,radius]*2);
    circle(radius);
  }
}

/*** STEP 2 ***/
// Another way is to construct it from parts.
// First we place the corner circles.


module Circles(){
     translate([radius,radius])circle(radius);
     translate([size.x, 0] + [-radius,radius])circle(radius);
     translate([0, size.y] + [radius,-radius])circle(radius);
     translate(size - [radius,radius])circle(radius);
 }

if (step==2){
   color("lightslateGrey")Circles();

// and fill the space in between with two squares
   color("slateGrey"){
     translate([radius,0])square([size.x-radius*2,size.y]);
     translate([0,radius])square([size.x,size.y-radius*2]);
   }

}





 /*** STEP 3 ***/ 
 // Or more elegant put the hull() around which will encase the objects
if (step==3)
   color("slateGrey")hull()Circles();




 /*** STEP 4 ***/ 
// we can make this shorter by using a loop
if (step==4)
  color("thistle")hull()
    for(tx=[radius,size.x-radius],ty=[radius,size.y-radius])
      translate([tx,ty])circle(radius);




 /*** STEP 5 ***/
// Or we can apply an offset() which adds to a 2D object while the r parameter adds an arc to each corner by expanding.
if (step==5)color("lavender")
  translate(radius*[1,1])
    offset(radius)
      square(size-[radius,radius]*2);





 /*** STEP 6 ***/
// As the offset() can be negative too we can shorten this by using it twice to shrink and then expand the square.

if (step==6)color("maroon")
  offset(radius)offset(-radius)square(size);

 /*** STEP 7 ***/

// Then we can create a polygon, which is a bit more complex, first we create a function to make an arc with parameter to rotate and translate. And a resolution fn

function arc(r,deg=90,rot=0,t=[0,0],fn=10)= [
  for (i=[0:fn])
    [cos(deg/fn*i + rot),sin(deg/fn*i + rot)]*r + t
];

if(step==7){
  echo (arc(radius));
  color("teal")polygon(arc(radius));
}

// it is not visible but the points are counter clockwise 
// starting at x=radius y=0 and drawing the arc to x=0 y=radius
// and obviously we need 4 of them

 /*** STEP 8 ***/
// creating the points by putting 4 arc after each other,
// this can be done with each or by putting them into a concat(arc(),arc()…)
// we just need to keep in mind how to order them also counter clockwise


p= [
  each arc(radius,rot=0, t= size - radius*[1,1]), // upper right
  each arc(radius,rot=90,t= [0 + radius, size.y - radius]), //upper left
  each arc(radius,rot=180,t=[0 + radius, 0 + radius]), // lower right
  each arc(radius,rot=-90,t=[size.x - radius, 0 + radius]) // lower left
];

if(step==8){
  echo (p) // that is a lot of points
  color("cadetBlue")polygon (p);
}



/*** THE END ***/

/*********************************************************************/




  // License: CC0 (aka CC Zero) - To the extent possible under law,
 // Ulirch Bär has waived all copyright and related or neighboring rights to this work.
// https://creativecommons.org/publicdomain/zero/1.0/

$fa = 1; $fs = 0.2;
