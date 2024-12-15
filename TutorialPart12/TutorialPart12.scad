/*
 * Welcome to the Advent Calendar - Tutorial Edition - Part 11
 */
 
 // We will have a look how to create Objects by using a loop



step = 1; // [1:8]

/*** STEP 1 ***/
// First we understand a FOR loop that is creating instances for each count

if (step==1){

for (i=[0:4]) translate ([i,0]) cube();

}

/*** STEP 2 ***/
// That can also count in different increments, like 3 - notice the last number reached is now 9

if (step==2){

for (i=[0:3:10]) translate ([i,0]) cube();

}


/*** STEP 3 ***/
// We can also use a defined list 

if (step==3){

for (i=[0,1,5,8,10]) translate ([i,0]) cube();

}

/*** STEP 4 ***/
// Now let us make this a bit more interessting, we rotate the element. Keep in mind that 0 and 360 is the same position so we just need the step before (360-5) else we get one element twice.

if (step==4){

for (rot=[0:5:355]) rotate([0,rot,0])translate ([10,0]) cylinder(h=1,d=10,$fn=3,center=true);

}


/*** STEP 5 ***/
// We also have learned last time that hull() can be used to enclose two 2D objects, that works also for 3D

if (step==5){
increment=5;
for (rot=[0:increment:360-increment])hull(){
  rotate([0,rot,0])translate ([10,0]) cylinder(h=1,d=10,$fn=3,center=true);
  rotate([0,rot+increment,0])translate ([10,0]) cylinder(h=1,d=10,$fn=3,center=true);
  }

}

// So what happened here, we enclosed two objects of our loop in a way that the second one is at the position of the next loop instance.
// While rot = 0 the second is at 5, when rot = 5 the second is 10 and so on
// this gives us a hull sequence or chain hull 





/*** STEP 6 ***/
// As our cylinder has some height this will leave some small imperfections but we can improve that so only the base edges are in contact. Also we using an own parameter for the second hull object. And using an offset to round it.

if (step==6){
increment=5;
for (i=[0:increment:360-increment])hull(){
 j=i+increment;
  rotate([0,i,0])translate ([10,0]) linear_extrude(.1,scale=0.1)offset(2)circle(5-2,$fn=3);
  rotate([0,j,0])translate ([10,0]) linear_extrude(.1,scale=0.1)offset(2)circle(5-2,$fn=3);
  }

}





/*** STEP 7 ***/
// Finally we intruduce another rotation (twist) also we replace the two hull objects with a loop that instantiate both. And add some color

if (step==7){
increment=5;
twist=360*3;
for (i=[0:increment:360-increment])color([abs(sin(i)),abs(cos(i)),0.2])hull(){
 j=i+increment;
  for(h=[i,j])rotate([0,h,0])translate ([10,0])rotate(h/360*twist) linear_extrude(.1,scale=0.1)offset(2)circle(5-2,$fn=3);
  }

}





/*** STEP 8 ***/
// As the hull() is always a convex hull, we need to work around that if we want a concave profile. The color of the negative part is shifted

if (step==8){
increment=3;
twist=240;

difference(){
    union()for (i=[0:increment:360-increment])color([abs(sin(i)),abs(cos(i)),0.2]) hull(){
      j=i+increment;
      for(h=[i,j])rotate([0,h,0])translate ([10,0])rotate(h/360*twist)
          linear_extrude(.1,scale=0.1)offset(2)circle(5-2,$fn=3);
     }
  //negative  part 3× (rot)
     for (i=[0:increment:360-increment],rot=[60,180,300])
      color([abs(cos(i)),0,abs(sin(i))]) hull(){
      j=i+increment;
        for(h=[i,j])rotate([0,h,0])translate([10,0])rotate(h/360*twist)
          rotate(rot)translate([5,0])linear_extrude(.1,scale=0.1)circle(3,$fn=24);
      }
}
    
    
}




/*** THE END ***/

/*********************************************************************/


  // License: CC0 (aka CC Zero) - To the extent possible under law,
 // Ulirch Bär has waived all copyright and related or neighboring rights to this work.
// https://creativecommons.org/publicdomain/zero/1.0/

$fa = 1; $fs = 0.2;