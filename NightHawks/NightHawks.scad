  // License: CC0 (aka CC Zero) - To the extent possible under law,
 // Ulrich Bär has waived all copyright and related or neighboring rights to this work.
// https://creativecommons.org/publicdomain/zero/1.0/

// Night Hawks https://en.wikipedia.org/wiki/Nighthawks_(painting)

//*
$vpr=[ 89.4, +0.00, 53.5 ];
$vpt=[ 46, 14, 18 ];
$vpd=200;
$vpf=15;//22.5;
//*/



colors=[
"DarkSeaGreen",
"Tan",
"lightskyblue",
"SaddleBrown",
"CadetBlue", 
"ForestGreen", // 5
"MediumSeaGreen",// Column highlight
"Tomato",//,"FireBrick" House
"DimGrey",
"Maroon",// Bar
"orange", // 10
"Chocolate",// 11 Door
[.1,.1,.1]//DarkSlateGrey"
];



translate([-20,-20])rotate(-11)House();
Street();
color(colors[8]){
  Extrude()Wall();
  translate([55,0])Coffer();
  for(i=[50,105])translate([i,0,5])cube([0.5,.1,22]);//Window seperator
  }
color(colors[10])Extrude()translate([.1,+0.0])Wall(h=[6.9,20.2,4],thick=4,frills=0); // inside Wall
color(colors[5])Extrude()translate([0.9,6.3])square([3,.75]); // Window board
color(colors[9]) translate([45,0,32])cube([70,1,5.5]);// Phillies
color(colors[3]) translate([63,0.9,33.75])rotate([90])linear_extrude(1)offset(0.10)scale([1,0.5])text("PHILLIES",size=4,spacing=2,font="TimesNewRoman");// Phillies

translate([15,99.5])Door();
color(colors[1])translate([0.1,0.1,0])Floor();
color(colors[1])translate([0.1,0.1,30])Floor();
color(colors[9])for(i=[0:6])translate([i*8 + 30,+30])Stool();
color(colors[5])rotate(45)translate([32,0])Column();
if($preview)color(colors[6])rotate(45)translate([32.1,0])Column(d=1.01);
// BackWall
color(colors[10])translate([0,100])cube([200,130,37]);
color(colors[10])translate([0,84])cube([4.1,50,37]);// window wall

// Bar
  bar_height=8;
  color(colors[9]) translate([15,35]) Extrude(r=3,s=[85,50])square([2.99,bar_height]);
  color(colors[9])translate([20,70])cube([20,3,bar_height]);
  color(colors[9])translate([20,81])rotate(-30)cube([70,3,bar_height]);
  translate([33,74,bar_height])Kettle();
  translate([27,73,bar_height])Kettle();


  translate([16,69,bar_height])rotate(-90)Mug();
  translate([16,62,bar_height])rotate(-90)Mug();

  translate([16,54,bar_height])Napkins();
  translate([16,53.9,bar_height])Shaker(opt=1,hFill=1.0,h=1.1);
  translate([16,53,bar_height])Shaker(opt=1,hFill=0.9,h=1.5,deg=-2);// sugar

  translate([34,37,bar_height])rotate(-90)Mug();
  translate([35.3,36.7,bar_height])Shaker(opt=1,hFill=0.6);
  translate([31,37,bar_height])Tumbler(deg=2,hFill=0.4);

  translate([53,36.7,bar_height])Shaker(opt=1);
  translate([53,37.2,bar_height])Shaker(opt=0);
  translate([52.0,36,bar_height])rotate(90)Napkins();
  translate([49,36,bar_height])Tumbler(deg=2,hFill=0);
// Window
color(colors[2],alpha=.2)Extrude()Glas();

module House(windowW=7.0){
color("black")translate([-135,1])cube([10,350,80]);
 translate([-206,+0,30]){
 color("black")translate([82,1])cube([10,350,80]);
 
  difference(){
    color(colors[7])cube([100,400,100]); // House Upper
    color(colors[12])for(i=[0:2*windowW:350])translate([80,i+1,8])cube([100,windowW,18]);//window
  }
    color(colors[8])for(i=[0:2*windowW:350])translate([100,i+1,6])cube([2,windowW,2]);//board
    color(colors[4])for(i=[0:2*windowW:350])translate([97,i+1,i==windowW*8?20:15])cube([2,windowW,12]);
  }
 translate([-207,+0,0]){
  difference(){
    color(colors[4])cube([100,400,35]); // House Lower
    color(colors[4])translate([80,1,1])cube([100,100,30]); // House Lower
  }
  color(colors[4])translate([100,0,27])cube([2,400,5]);
  color(colors[8])translate([100,0,29])cube([3,400,1.5]);
  color(colors[4])translate([100,0,31])cube([4,400,1]);
  color(colors[1])translate([50,60,0])cube([51,13,1.1]);//front column
  color(colors[4])translate([100,60,0])cube([2,2,30]);//front column
  color(colors[4])translate([100,72,0])cube([2,2,30]);//front column
  color(colors[8])translate([90,73,0])cube([2,2,30]);// back column
  
  color(colors[4])translate([100,31,0])cube([1,30,4]);//front bottom left
  color(colors[4])translate([100,74,0])cube([1,100,4]);//front bottom right  
  color(colors[11])translate([80,45,0])cube([10,20,10]);//desk left
  color(colors[11])translate([87,75,0])cube([5,20,10]);//desk right
  
}
}

module Street(){
  difference(){
    color(colors[0])translate([0,0,-5])cube([5000,5000,10],true);
    color(colors[4])translate([-90,-170])Extrude(r=300,s=1000*[1,1])translate([0,-1])square([70,2]);
  }
}

module Extrude(r=50,s=[200,200],angle=90,$fn=120){
  translate([r,r])render(convexity=5){
    translate([-r,s.y-r])rotate([90,0])linear_extrude(s.y-r,convexity=5)children();
    rotate_extrude(angle=angle,convexity=5)translate([-r,0])children();
    rotate(angle)translate([-r,0])rotate([90,0])linear_extrude(s.x-r,convexity=5)children();
  }
}

module Column(h=30,d=1){
  linear_extrude(h)for(i=[0,40,80])rotate(i)circle(d=d,$fn=3);
}

module Coffer(e=5,h=5,dist=18,cof=[3,2,1.0]){
linear_extrude(h){

for(i=[0:e-1])translate([i*dist,0])polygon([
[cof[0]/2,cof[2]],
[-cof[0]/2,cof[2]],
[-cof[1]/2,0],
[cof[1]/2,0],
]);

}


}

module Wall(h=[7,20,6],thick=1,frills=1){


if(frills)translate([0,h[0]+h[1]+1.2]){ //top
  square([thick +0,2.7],true);
  translate([0,2.7])square([thick +1,2.6],true);
  translate([0,4.1])square([thick +3,1.0],true);
  //translate([0,6.5])square([thick ,5.0],true);

}

if(frills)translate([-0.5,h[0]-0.9])square([thick +2,0.75]);// board
  
  difference(){// lower
    square([thick,h[0] ]); 
    hull(){
      translate([0,h[0]/4*2.5])circle(thick/2,$fn=4);
      translate([0,h[0]/3.5])circle(thick/2,$fn=4);
    }
  }
  translate([0,h[1]+h[0]])square([thick,h[2] ]);// upper
}

module Glas(h=[7,20,10],thick=.3){
  translate([.75,h[0]])square([thick,h[1] ]);
}

module Floor(r=60,s=[200,200],thick=1){
  Extrude(r=r,s=s)square([r -0.001,thick]);
  translate([r,r])cube(concat(s-[r,r],thick));
}

module Door(h=22){
color(colors[11])cube([h/4.0,0.3,h]);
color(colors[8])translate([h/4/2,.1,h/1.4])cube([2,0.3,2],true);

}

module Stool(h=5.2,r=2,$fs=0.1){

  translate([0,0,h])minkowski(){
    cylinder(.5,r=r);
    sphere(.1);
  }
  for(i=[0:3])rotate([0,-5,i*90])translate([r,0])cylinder(h,d=.5);
}


module Kettle(h=9,d=4.0,$fs=0.2)color("lightSteelBlue"){
dTop=d*1.3;
feet=h/8;
  translate([0,0,feet]){
    rotate_extrude(){
      square([d/2,h-dTop/2]);
      translate([0,h-dTop/2])intersection(){
        square(500);
        offset(-1)offset(1)translate([0,-dTop/6])union(){
          circle(dTop/2);
          translate([0,dTop/2.5])circle(dTop/4);
        }
      }
    }
  translate([0,-d/2*1.3,h/10])cylinder(h-dTop/1.3,r=d/15);
  }
  for(i=[0:4])rotate(i*360/5)translate([d/2*.9,0])rotate([0,-12])cylinder(feet,d1=d/15,d2=d/10);
  
}


module Mug(h=1,$fn=24) color("white"){
 difference(){
   cylinder(h=h,d=h);
   translate([0,0,.1])cylinder(h=h,d=h*0.8);
   }
  translate([h/1.8,0,h/2])rotate([90])scale([1,1.75])difference(){
    cylinder(.1,d=h*.5,center=true);
    cylinder(30,d=h*.4,center=true);
    }
}

module Shaker(h=0.7,d1,opt=1,hFill=0.4,deg=-7.5){
d1=is_undef(d1)?h/2:d1;
 translate([0,0,h/15]) color(opt?"white":"brown")scale(.8)cylinder(hFill,r1=d1/2,r2=d1/2+tan(deg)*hFill,$fn=5);
  color("lightblue",alpha=0.3)cylinder(h,r1=d1/2,r2=d1/2+tan(deg)*h,$fn=5);
  
 color("lightSteelBlue")translate([0,0,h])sphere(d1/2*1.2+tan(deg)*h,$fn=5);
}

module Tumbler(h=0.8,d=0.6,deg=7.5,hFill=0.4,$fs=0.08,$fa=1){

if(hFill)color("lightblue",alpha=0.25)translate([0,0,h/15]) scale(.8)cylinder(hFill,r1=d/2,r2=d/2+tan(deg)*hFill);

  color("lightblue",alpha=0.7)difference(){
    cylinder(h,r1=d/2,r2=d/2+tan(deg)*h);
    translate([0,0,h/15]) scale(.8)cylinder(h*2,r1=d/2,r2=d/2+tan(deg)*h*2);
  }

}


module Napkins(s=[1.8,1.0,1.5],$fs=0.1)color("lightsteelblue"){
sc=[0.5,0.7,0.9];
  translate(sc/2)minkowski(){
    cube(s-sc*1);
    scale(sc)sphere(d=1);
  }


}