  // License: CC0 (aka CC Zero) - To the extent possible under law,
 // Ulrich Bär has waived all copyright and related or neighboring rights to this work.
// https://creativecommons.org/publicdomain/zero/1.0/

/*[Dual Baubel]*/
size=50;
part=0;//[0:both,1:A,2:B]


if(part==1||!part) color("tan") Part(1);
if(part==2||!part) color("cornflowerblue")Part(2);

 
 module Part(num,$fs=.5,$fa=1){
 intersection(){
   linear_extrude(size,twist=90,convexity=10,scale=.95)
     difference(){
      if(num==2)circle(size);
      offset(num==1?-.1:.1)offset(1)offset(-1)union()for(rot=[0,60])rotate(rot)circle(d=size-1,$fn=3);
     }
   translate([0,0,size/2])difference(){
    sphere(d=size); 
    if(num==2)rotate_extrude()translate([size * .55,0])circle(d=size/4);
    cylinder(size*2,d1=2.5,d2=2,center=true);
    
    }
   }
   
 }