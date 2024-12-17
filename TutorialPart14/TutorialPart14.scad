/*
 * Welcome to the Advent Calendar - Tutorial Edition - Part 14
 */
 
 // The Polygon and Polyhedron, can be created manually but we using loops to automate that.



step = 1; // [1:8]

/*** STEP 1 ***/
// We already have seen loops, so we start with creating points for a polygon.


function points(r=10,fn=10) = [
let(chg=360/fn)
  for(i=[0:fn-1])
    [cos(i*chg),sin(i*chg)]*r
];

if (step==1){
echo(points());
polygon(points());
}

/*** STEP 2 ***/
//When having multiple shapes within one polygon we need to define the path that groups the points and orders them. It is just a list of the point number.

if (step==2){
p2=concat(points(r=10),points(r=5));

echo(p2);

translate([0,20])polygon(p2);
polygon(points=p2,paths=[[for(i=[0:9])i],[for(i=[10:19])i] ]);

}

/*** STEP 3 ***/
//We now use modulo to change every second point.  i%2, the remainder of i divided by 2, is 0 (false) for even numbers, and 1 (true) for odd numbers.

function star(r=[10,5],tips=4) = [
let(chg=360/(tips*2))
  for(i=[0:tips*2-1])
    [cos(i*chg),sin(i*chg)]* (i%2?r[0]:r[1])
];
if (step==3){

for (tips=[4:8]) translate([(tips-4)*20-40,0]) polygon (star(r=[10,4],tips=tips));
for (tips=[4:8]) translate([(tips-4)*20-40,20]) polygon (star(r=[5,8],tips=tips));
}

/*** STEP 4 ***/
//To build a polyhedron we need points and faces, faces are similar to the paths in polygons
// But now we group them to form a triangle or connect points in a plane.
// And we are now in 3D so we need Z
// Keep in mind these are One face and not valid closed polyhedrons.

// lets make a short example.

// we can see every point in p has 3 values [x,y,z]
  // while the faces is just one face that covers the shape. 
  //If you now press F12 (thrown together) you see the face has a purple and white side while  F10 is the normal (surface) view.
  // This is very importand as purple is the inside of a polyhedron and determined by the order of the points.

if (step==4){
 p=[ [0,0,0], [10,0,0], [0,10,0] ];

polyhedron(p,faces=[[0,1,2]]); 
translate([0,0,10])polyhedron(p,faces=[[2,1,0]]); 
// these are two invalid one face polygons

}

/*** STEP 5 ***/
//lets make a valid polyhedron, you may notice that you can change the values of each point without the need to change the faces.

function p(z=0) = [ [0,0,z], [10,0,z], [0,10,z] ];
if (step==5){
points = [ 
each p(0), // points 0,1,2 at Z = 0
each p(10) // points 3,4,5 at Z= 10
];

echo( amount = len(points) ); // total of 6 points

faces = [
[0,1,2], // bottom
[5,4,3], // top
[1,0,3,4], // side A as quad face - the order is clockwise when seeing from the outside - and counterclockwise form the inside.
[0,2,5,3],// side B
[2,1,4,5], // side C (hypotenuse)
];

color ("tan") polyhedron(points,faces); 
// A valid polyhedron
}

/*** STEP 6 ***/
// lets use the same faces with one changed point

if (step==6){

points = [ 
each p(0), // points 0,1,2 at Z = 0
each [[0,0,5], p(10)[1],p(10)[2]] // points 3,4,5 at Z= 5, 10 and 10
];

faces = [
[0,1,2], // bottom
[5,4,3], // top
[1,0,3,4], // side A as quad face - the order is clockwise when seeing from the outside - and counterclockwise form the inside.
[0,2,5,3],// side B
[2,1,4,5], // side C (hypotenuse)
];

color("cadetBlue")polyhedron(points,faces); 
// A valid polyhedron
}



/*** STEP 7 ***/
// remember our Star - lets use that to go 3D, we add a Z variable


function star3D(r=[10,5],tips=4,z=0) = [
let(chg=360/(tips*2))
  for(i=[0:tips*2-1])
    concat([cos(i*chg),sin(i*chg)]* (i%2?r[0]:r[1]) , z )
];
if (step==7){

tips=5;
loop=tips*2-1; // the length or number points of a star3D

points=[
each star3D(r= [10,5],z=0,tips=tips),// base
each star3D(r= [10,5],z=5,tips=tips) // top
];

faces= [
[for(i=[0:loop])i ], // base face
[for(i=[loop:-1:0])i + tips*2 ], // top face in reverse order

for(i=[0:loop])[(i+1)%(tips*2),i,i+ tips*2 ,(i +1)%(tips*2) + tips*2]// sides creates a quad group for each side and modulo is used to connect the last face to the first point

];

  echo (points,faces); // yes that is becoming quite complex 
  color("azure")polyhedron(points,faces=faces);
}

/*** STEP 8 ***/
// ok that was something we could do with a linear_extrude, too
// Let's change the radii of the base and add a 3rd level that is smaller and lower

if (step==8){
tips=5;
loop=tips*2-1; // the length or number points of a star3D

points=[
each star3D(r= [15,9],z=0,tips=tips),// base
each star3D(r= [10,5],z=5,tips=tips), // 2nd level
each star3D(r= [1,3],z=2,tips=tips) // 3rd level
];

faces= [
[for(i=[0:loop])i ], // base face
[for(i=[loop:-1:0])i + tips*4 ], // 3rd level face in reverse order

for(i=[0:loop])[(i+1)%(tips*2),i,i+ tips*2 ,(i +1)%(tips*2) + tips*2],// 1st level sides creates a quad group for each side
for(i=[0:loop])[(i+1)%(tips*2),i,i+ tips*2 ,(i +1)%(tips*2) + tips*2] +[1,1,1,1]*tips*2// 2nd level sides just add the number of tips*2

];

  color("gold")polyhedron(points,faces=faces);
}


/*** THE END ***/

/*********************************************************************/


  // License: CC0 (aka CC Zero) - To the extent possible under law,
 // Ulirch Bär has waived all copyright and related or neighboring rights to this work.
// https://creativecommons.org/publicdomain/zero/1.0/

$fa = 1; $fs = 0.2;
