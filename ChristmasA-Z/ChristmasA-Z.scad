// Christmas from A to Z.scad
//
// Version 1
// November 14, 2024
// By: Stone Age Sculptor
// License: CC0 (Public Domain)
 
$fn = 50;
spacing = 3;      // spacing between characters
 
// Each character can consist of multiple curves.
// At this moment, the script needs at least 
// three points for a curve.
// When a character is not found in the list,
// then the first one is used (it is a block).
// Data:
//   The character
//   The width
//   A list of one or more curves
alphabet =
[
  [chr(127),8,[[[0,0],[0,0],[0,10],[0,10],[8,10],[8,10],[8,0],[8,0],[0,0],[0,0]]]],
  ["A",8,[[[0,0],[4,10],[4,10],[8,0]],[[1.6,4],[4,4],[6.4,4]]]],
  ["B",6,[[[0,0],[0,5],[0,10]],[[0,10],[5,10],[5,5],[0,5]],[[0,5],[6,5],[6,0],[0,0]]]],
  ["C",6,[[[6,0],[0,0],[0,10],[6,10]]]],
  ["D",6,[[[0,0],[0,5],[0,10]],[[0,10],[6,10],[6,0],[0,0]]]],
  ["E",6,[[[0,0],[0,5],[0,10]],[[0,10],[3,10],[6,10]],[[0,5],[3,5],[5,5]],[[0,0],[3,0],[6,0]]]],
  ["F",6,[[[0,0],[0,5],[0,10]],[[0,10],[3,10],[6,10]],[[0,5],[3,5],[5,5]]]],
  ["G",8,[[[7,8],[6,10],[0,10],[0,0],[6,0],[7,4]],[[5,4],[6,4],[8,4]]]],
  ["H",6,[[[0,0],[0,5],[0,10]],[[6,0],[6,5],[6,10]],[[0,5],[3,5],[6,5]]]],
  ["I",2,[[[1,0],[1,5],[1,10]],[[0,10],[1,10],[2,10]],[[0,0],[1,0],[2,0]]]],
  ["J",6,[[[6,10],[6,0],[1,0],[0,3]]]],
  ["K",6,[[[0,0],[0,5],[0,10]],[[0,5],[3,7.5],[6,10]],[[0,5],[3,2.5],[6,0]]]],
  ["L",6,[[[0,10],[0,0],[0,0],[6,0]]]],
  ["M",8,[[[0,0],[0,10],[0,10],[4,5],[4,5],[8,10],[8,10],[8,0]]]],
  ["N",6,[[[0,0],[0,5],[0,10]],[[0,8],[1,10],[5,10],[6,8],[6,0]]]],
  ["O",7,[[[3.5,0],[1.5,0],[0,2],[0,8],[1.5,10],[5.5,10],[7,8],[7,2],[5.5,0],[3.5,0]]]],
  ["P",6,[[[0,0],[0,5],[0,10]],[[0,10],[6,10],[6,5],[0,5]]]],
  ["Q",8,[[[4,1],[0,1],[0,10],[8,10],[8,1],[4,1]],[[3,2],[5,0],[8,0]]]],
  ["R",6,[[[0,0],[0,5],[0,10]],[[0,10],[6,10],[6,5],[0,5]],[[0,5],[3,2.5],[6,0]]]],
  ["S",7,[[[7,9],[6,10],[0,10],[0,5],[7,5],[7,0],[1,0],[0,1]]]],
  ["T",7,[[[0,10],[3,10],[7,10]],[[3.5,10],[3.5,5],[3.5,0]]]],
  ["U",7,[[[0,10],[0,0],[7,0],[7,0],[7,10]]]],
  ["V",8,[[[0,10],[4,0],[4,0],[8,10]]]],
  ["W",10,[[[0,10],[2.5,0],[2.5,0],[5,6],[5,6],[7.5,0],[7.5,0],[10,10]]]],
  ["X",7,[[[0,10],[3.5,5],[7,0]],[[0,0],[3.5,5],[7,10]]]],
  ["Y",7,[[[0,10],[3.5,5],[3.5,5],[7,10]],[[3.5,5],[3.5,2],[3.5,0]]]],
  ["Z",7,[[[0,10],[7,10],[7,10],[0,0],[0,0],[7,0]]]],
  [".",2,[[[0.5,0],[0,0],[0,1],[1,1],[1,0],[0.5,0]]]],
  [",",2,[[[0.5,1],[0,1],[0,2],[1,2],[1,1],[0.5,0]]]],
  ["!",2,[[[0.5,0],[0,0],[0,1],[1,1],[1,0],[0.5,0]],[[0.5,10],[0.5,6],[0.5,3]]]],
  [" ",7,[]],          // a space
  ["0",7,[[[3.5,0],[2,0.2],[0,3],[0,7],[2,10],[5,10],[7,7],[7,3],[5,0.2],[3.5,0]]]],
  ["1",6,[[[3,0],[3,5],[3,10]],[[2,0],[3,0],[4,0]],[[3,10],[2,9],[1.5,8.5]]]],
  ["2",6,[[[0,9],[1,10],[6,10],[6,6],[3,3],[0,0],[0,0],[6,0]]]],
  ["3",6,[[[0,10],[0,10],[6,10],[6,10],[2,5],[2,5],[6,5],[6,0],[1,0],[0,1]]]],
  ["4",7,[[[7,4],[0,4],[0,4],[5,10],[5,10],[5,0],[5,0]]]],
  ["5",6,[[[6,10],[0,10],[0,10],[0,5],[0,5],[6,5],[6,0],[0,0]]]],
  ["6",6,[[[4,10],[1,7],[0,5],[0,0],[6,0],[6,5],[0,5],[0,3]]]],
  ["7",6,[[[0,10],[6,10],[6,10],[2,0]]]],
  ["8",7,[[[3.5,5],[0,5.4],[0,10],[7,10],[7,5.4],[3.5,5]],[[3.5,5],[0,4.6],[0,0],[7,0],[7,4.6],[3.5,5]]]],
  ["9",6,[[[2,0],[3.5,1.2],[6,5],[6,10],[0,10],[0,5],[5,5],[5.8,6]]]],
  ["♥",10,[[[5,0],[0,5],[0,10],[4,10],[5,7],[5,7],[6,10],[10,10],[10,5],[5,0]]]],
  ["$",8,[[[8,9],[0,9],[0,5],[8,5],[8,1],[0,1]],[[3,10],[3,5],[3,0]],[[5,10],[5,5],[5,0]]]],
  ["€",8,[[[8,9],[7,10],[2,9],[2,1],[7,0],[8,1]],[[0,4],[3,4],[6,4]],[[0,6],[3,6],[6,6]]]],
];
 
// (re)start the random with the same sequence.
q = rands(0,0,0,123);
 
texts =
[
  "MERRY CHRISTMAS",
  "HAPPY NEW YEAR",
  "   ♥ 2025 ♥"
];
 
// Timing:
//   10 seconds of the sticks forming a text
//    2 seconds pause with red/green/white
//    3 seconds pause with gold.
// With a gif file of 20 frames per second, set FPS to 300.
 
time = $t * len(texts)*(15);
textindex = floor(time / 15);
sub       = time % 15;
jit = sub < 10 ? 10-sub : 0;
override = sub > 12 ? "Gold" : "";
weight   = sub > 12 ? 2.0 : 1.3;
ShowString(string=texts[textindex],jitter=jit,coloroverride=override);
 
module ShowString(string,jitter=0,coloroverride=0,index=0,xoffset=0)
{
  if(index < len(string))
  {
    // If the character was not found, then the index 0 is used.
    found = search(string[index],alphabet,1,0);
    dataindex = len(found) > 0 ? found[0] : 0;
 
    points = alphabet[dataindex][2];
    if(len(points) > 0)  // are there any points ?
    {
      for(j=[0:len(points)-1])
      {
        // The "1path" is the 1,1 weighted subdivision.
        // That is the fasted and most basic subdivision.
        path = Subdivision(points[j],3,method="1path");
        translate([xoffset,0])
          for(i=[0:len(path)-2])
          {
            colortable = ["LimeGreen","Red","White"];
            newcolor = coloroverride == "" ? colortable[floor(rands(0,2.99,1)[0])] : coloroverride; 
            color(newcolor)
              hull()
              {
                translate(Jitter(path[i],jitter))
                  circle(d=weight,$fn=12);
                translate(Jitter(path[i+1],jitter))
                  circle(d=weight,$fn=12);
              }
          }
      }
    }
 
    // Call this function recursively for the next character.
    // That way the variable font width is used.
    ShowString(string=string,jitter=jitter,coloroverride=coloroverride,index=index+1,xoffset=xoffset+alphabet[dataindex][1]+spacing);
  }
}
 
// Jitter 2D coordinates of 'a' with amount of 'b'.
function Jitter(a,b) = 
  [a.x + rands(-b,b,1)[0], a.y + rands(-b,b,1)[0]];
 
// ------------------------------------------------
// Subdivision functions
// ------------------------------------------------
// Version 1
// November 13, 2024
// By: Stone Age Sculptor
// License: CC0 (Public Domain)
//
// To do: Accept a path of two points.
 
// Subdivision
// -----------
// Parameters:
//   list:      A list of coordinates in 2D or 3D. 
//              But not a 3D surface.
//   divisions: The number of divisions.
//              0 for no smoothing, 5 is extra smooth.
//   method:    The subdivision method:
//              "1"        A basic 1,1 weighted subdivision
//                         for a closed shape.
//              "weighted" A weighted average subdivision
//                         for a closed shape.
//              "1path"    A basic 1,1 weighted subdivision
//                         for a path.
//              "weightedpath"
//                         A weighted average subdivision
//                         for a path.
// Return:
//   A new list with a smoother shape.
//   The new list is often used with the polygon() function.
function Subdivision(list,divisions,method) = 
  divisions > 0 ? 
    Subdivision( 
      method=="1"            ? _Subdivision11(list) :
      method=="1path"        ? _SubdivisionPath11(list) :
      method=="weighted"     ? _SubdivisionWeighted(list) : 
      method=="weightedpath" ? _SubdivisionPathWeighted(list) : 
      assert(false,"Unknown method in Subdivision"),
      divisions - 1,method) : 
      list;
 
// This is the most basic subdivision with 1,1 weighting.
// It will work in 2D and 3D.
//
// The average in OpenSCAD is: (current_point + next_point) / 2
// The index of the list wraps around for the next point.
//
// The 'list2' is the average points between the original points.
// The returned list is the new average between the average points
// and the original points.
function _Subdivision11(list) =
  let (n = len(list)-1)
  let (list2 = [ for(i=[0:n]) (list[i] + list[(i+1) > n ? 0 : i+1])/2 ])
  [ for(i=[0:n]) each [ (list[i] + list2[i])/2, (list2[i] + list[(i+1) > n ? 0 : i+1])/2 ]];
 
// My own attempt with variable weighting.
// The goal was a smoothing algoritme that feels
// like NURBS.
// Explanation:
//   The average points between the original
//   points are calculated. These are kept.
//   A second set of average points between 
//   those average points are temporarely calculated.
//   A new point is created on the line between
//   an original point and the temporarely point.
//   The position on that line is defined by
//   a 'weight' variable.
//   The result is the combination of the
//   kept points and the new points.
//
// When the 'weight' variable is set to
// sqrt(2) - 1, then the result approximates 
// a circle when the control points is a square.
// It is some kind of cubic B-spline, but I don't 
// know if it matches with one of the known algoritmes.
function _SubdivisionWeighted(list) =
  let (weight = sqrt(2) - 1)
  let (n = len(list)-1)
  let (list2 = [ for(i=[0:n]) (list[i] + list[(i+1) > n ? 0 : i+1])/2 ])
  let (list3 = [ for(i=[0:n]) (weight*list[i] + (1-weight)/2*(list2[i] + list2[(i-1) < 0 ? n : i-1])) ])
  [ for(i=[0:n]) each [list3[i], list2[i]] ];
 
// The basic subdivision with 1,1 weighting.
// But now for a path with a open begin and end.
function _SubdivisionPath11(list) =
  let (n = len(list)-2)
  let (list2 = [ for(i=[0:n]) (list[i] + list[i+1])/2 ])
  [ list[0], for(i=[1:n]) each [ (list[i] + list2[i-1])/2, (list[i] + list2[i])/2 ], list[n+1]];
 
// My own attempt with variable weighting.
// But now for a path with a open begin and end.
function _SubdivisionPathWeighted(list) =
  let (weight = sqrt(2) - 1)
  let (n = len(list)-2)
  let (list2 = [ for(i=[0:n]) (list[i] + list[i+1])/2 ])
  let (list3 = [ list[0], for(i=[1:n]) (weight*list[i] + (1-weight)/2*(list2[i] + list2[i-1])), list[n+1] ])
  [ for(i=[0:n]) each [list3[i], list2[i]], list3[n+1] ];
