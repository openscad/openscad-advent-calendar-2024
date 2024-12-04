  // License: CC0 (aka CC Zero) - To the extent possible under law,
 // Ulrich Bär has waived all copyright and related or neighboring rights to this work.
// https://creativecommons.org/publicdomain/zero/1.0/

/*[Baby Toy]*/
d=20;



difference(){
  color("silver")minkowski(){
    cube([d*3+20,d+10,10-2]);
    translate([0,0,2])sphere(2,$fs=.2);
  }
 
 color("lavender")minkowski(convexity=5){
   translate([0,0,2])union(){
    translate([2.5 + (d/2+2.5)   ,(d/2+5)    , 2+d/2])cube(d-4,center=true);
    translate([2.5 + (d/2+2.5) *3,(d/2+5) * 1, 4])rotate(90)cylinder(h=20,d=d-4,$fn=3);
    translate([2.5 + (d/2+2.5) *5,(d/2+5) * 1, 4])cylinder(h=20,d=d-4,$fs=.2,$fa=1);
  }
  sphere(d=8,$fs=.5,$fa=1);
  }
  
}

color("steelblue")
translate([0,d+10])minkowski(){
  union(){

    color("blue")translate([2.5 +(d/2+2.5)   ,(d/2+5)    , (d-4)/2])cube(d-4,center=true);
    color("red")translate([2.5 + (d/2+2.5) *3,(d/2+5) * 1, 0])rotate(90)cylinder(h=d-4,d=d-4,$fn=3);
    color("green")translate([2.5 + (d/2+2.5) *5,(d/2+5) * 1, 0])cylinder(h=d-4,d=d-4,$fs=.2,$fa=1);
    
  }
  sphere(d=4,$fs=.5);
}