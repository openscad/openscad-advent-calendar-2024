  // License: CC0 (aka CC Zero) - To the extent possible under law,
 // Ulirch Bär has waived all copyright and related or neighboring rights to this work.
// https://creativecommons.org/publicdomain/zero/1.0/


$fs=.1;
/*[SCADadvent Coaster]*/
size=[90,90];
w=1;
nx=8;
ny=25;

color("tan")linear_extrude(1)
for(iy=[0:ny-1])let(h=size.y/(ny)-w*2)translate([0,(h+w*2)*iy])
offset(-h/2)offset(h/2){
let(nx=nx+iy%2)
    for(ix=[0:nx])translate([ix*size.x/nx+sin(ix*360/(nx-1))*-1,0])square([w,h+2*w]);
    square([size.x,w]);
    translate([0,h+2*w])square([size.x,w]);
}
//bottom&rim
color("lightblue")translate([0,w/2]){
  linear_extrude(2)difference(){
    offset(size.y/ny/2)square(size);
    offset(-.01)square(size);
    }
  linear_extrude(.2)offset(size.y/ny/2)square(size);
}