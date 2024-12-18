  // License: CC0 (aka CC Zero) - To the extent possible under law,
 // Ulrich Bär has waived all copyright and related or neighboring rights to this work.
// https://creativecommons.org/publicdomain/zero/1.0/

module Star(rec=3,start=[0,0,0],end=[0,0,0],d=20,r=300){

tip=5;
deg=[-55,-25,0,25,55];

iEnd=[
for(i=[0:tip-1],z=[0:len(deg)-1])
  end +
  [sin(360/tip*i + (z%2?180/tip:0))*cos(deg[z]),
   cos(360/tip*i + (z%2?180/tip:0))*cos(deg[z]),
   sin(deg[z])] * r,
    
  end+[0,0, r], // single top tip
  end+[0,0,-r], // single bottom tip
];

if(rec) for(i=[0:(len(iEnd)-1)]) Star(rec=rec-1,d=d/max(1.5,(3.5-rec)),start=end,end=iEnd[i],r=r/(5-rec/2));

if(rec<3)color([1,0.95,0.2]-[1,1,0]*rec/4)
  hull(){
    translate(start)sphere(d=d);
    translate(end)sphere(d=d/1.5);
  }

if(!rec){
  ran=floor(rands(0,4,1)[0]);
  color(ran==0?"midnightBlue":ran==1?"Azure":ran==2?"Red":"Lime")translate(end)sphere(d=floor(rands(0,2,1)[0])?d*2:d);
 }

}


$vpd=1900+sin($t*180)*150;

rotate([1,1,1]*sin($t*180)*30)Star(rec=3);
color("midnightBlue")sphere(3000,$fa=1);
