$fa=1;
$fs=0.4;

leaf_width = 3;
ball_density = 0.3;
ball_rad = 2;
height = 45;
diam = 20;

seed = 1;  // Select tree

function r(s) = rands(-s,s,1)[0];
function rp(s) = rands(0,s,1)[0];

if (seed >= 0) {
  _ = rands(0,1,0,seed);
}


// Perform an affine transformation of matrix M on coordinate v.
//
// [Scale X]          [Shear X along Y] [Shear X along Z] [Translate X]
// [Shear Y along X]  [Scale Y]         [Shear Y along Z] [Translate Y]
// [Shear Z along X]  [Shear Z along Y] [Scale Z]         [Translate Z]
// or rotation matrix [[cos,-sin],[sin,cos]] in the 2 axes for a plane.
function Affine(M, v) = M * [v[0], v[1], v[2], 1];

// Combine a list of affine transformation matrices into one.
function AffMerge(Mlist) = let(
    AffMergeRec = function(Mlist, i) i >= len(Mlist) ?
      [[1,0,0,0],[0,1,0,0],[0,0,1,0]] :
      let (
        rest = AffMergeRec(Mlist, i+1),
        prod = Mlist[i] * [rest[0], rest[1], rest[2], [0,0,0,1]]
      )
      [prod[0], prod[1], prod[2]]
  )
  AffMergeRec(Mlist, 0);

// Prepare a matrix to rotate around the x-axis.
function RotX(a) =
  [[     1,      0,       0, 0],
   [     0, cos(a), -sin(a), 0],
   [     0, sin(a),  cos(a), 0]];

// Prepare a matrix to rotate around the y-axis.
function RotY(a) =
  [[ cos(a), 0, sin(a), 0],
   [     0,  1,      0, 0],
   [-sin(a), 0, cos(a), 0]];

// Prepare a matrix to rotate around the z-axis.
function RotZ(a) =
  [[cos(a), -sin(a), 0, 0],
   [sin(a),  cos(a), 0, 0],
   [     0,       0, 1, 0]];

// Prepare a matrix to rotate around x, then y, then z.
function Rotate(rotvec) =
  AffMerge([RotZ(rotvec[2]), RotY(rotvec[1]), RotX(rotvec[0])]);

// Prepare a matrix to translate by vector v.
function Translate(v) =
  [[1, 0, 0, v[0]],
   [0, 1, 0, v[1]],
   [0, 0, 1, v[2]]];


function ApplyBreeze($m, amp, x, tf) = let(
    end = Affine(tf, [x,0,0]),
    apply = AffMerge([$m, tf]),
    coord = [apply[0][3], apply[1][3], apply[2][3]],
    breeze = RotZ(amp*((coord[2]+40)/100)*(coord[1]+20)*(end[1]/norm(end))*(1.5+0.7*sin(360*$t+apply[2][3])+0.15*(1+sin(360*2*$t-45))*sin(360*3*$t+2*apply[2][3]+2*apply[1][3])+0.1*(apply[2][3]/60)*(1+sin(360*$t))*sin(360*7*$t+3*apply[0][3]-3*apply[2][3])))
  )
  AffMerge([Translate(coord), breeze, Translate(-coord), apply]);



module Needle(needle_len, needle_thick, y, ang) {
  needle_fluff = 15;
  rnd_len = needle_len/4;
  $m = ApplyBreeze($m, 4, needle_len, AffMerge([
    Translate([0, y, 0]),
    Rotate([0, r(needle_fluff), ang])]));
  multmatrix($m)
    cube([needle_len-rp(rnd_len), needle_thick, needle_thick]);
}

module Leaf(length, width) {
  needle_ang = 45;
  needle_len = (width/2)/cos(needle_ang);
  needle_thick = needle_len/24;
  needle_count = round(length/(3*needle_thick));
  needle_step = (length)/needle_count;
  rnd_fact = needle_thick/2;
  color("green") {
    for (i=[0:needle_count-1]) {
      py=needle_step*i + needle_thick;
      Needle(needle_len, needle_thick, py+r(rnd_fact), needle_ang+r(5));
      Needle(needle_len, needle_thick, py+r(rnd_fact), 180-needle_ang+r(5));
    }

    Needle(needle_len, needle_thick, length, 90-(90-needle_ang)/2 + r(5));
    Needle(needle_len, needle_thick, length, 90+needle_ang/2 + r(5));
  }

  for (context = ["separate"]) {
    $m = AffMerge([$m,
      RotZ(90), Translate([0, 0, 0.01])]);
    color("brown")
      multmatrix($m)
      cube([length, needle_thick, needle_thick-0.02]);
  }
}

module Branch(length) {
  color("brown")
    multmatrix($m)
    cylinder(r1=0.01*length, r2=0.005*length, h=length);
  leaf_count = length * 1.3;
  for (i=[0:leaf_count-1]) {
    leaf_len = length / 8 + (1-i/leaf_count) * length / 8;
    $m = ApplyBreeze($m, 2, leaf_len, AffMerge([
      Translate([0, 0, length*(i+1-rp(1))/leaf_count]),
      RotZ(rp(360)), RotX(r(15)+55), RotY(rp(360))]));
    Leaf(leaf_len, leaf_width);
  }
}

module Tree(height, diam) {
  color("brown")
    cylinder(r1=0.05*diam, r2=0.01*diam, h=height);
  branch_count = height * 1.4;
  trunk_base = round(height / 10);
  $m = [[1,0,0,0],[0,1,0,0],[0,0,1,0]];
  for (i=[trunk_base:branch_count-1]) {
    branch_h = diam*(1-0.5*i/branch_count);
    branch_a = asin(i/(branch_count)) + rp(15);
    $m = ApplyBreeze($m, 1, branch_h, AffMerge([
      Translate([0, 0, height*(i+1-rp(1))/branch_count]),
      Rotate([90-branch_a, 0, (i%4)*90+rp(90)])]));
    Branch(branch_h);
  }
}


Tree(height, diam);


// Written in 2024 by Ryan A. Colyer
// Derived from the 2019 OpenSCAD Advent Calendar model Detailed Tree.
//
// To the ext1ent possible under law, the author(s) have dedicated all
// copyright and related and neighboring rights to this software to the
// public domain worldwide. This software is distributed without any
// warranty.
//
// You should have received a copy of the CC0 Public Domain
// Dedication along with this software.
// If not, see <http://creativecommons.org/publicdomain/zero/1.0/>.

