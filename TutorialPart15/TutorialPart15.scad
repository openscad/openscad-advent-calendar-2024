/*
 * Welcome to the Advent Calendar - Tutorial Edition - Part 15
 */

// In this part of the tutorial we will look at one way of handling
// assemblies. This means the model is composed from multiple parts and
// we want to have both the single parts in an orientation that works for
// producing the part (e.g. flat on the X/Y plane for easy 3D printing
// with minimal or no support) and also a view that shows how the parts
// are meant to fit together, including some additional objects that will
// be provided separately like PCBs with electronics, sockets or buttons.

// To keep things simple, this is not going to be an actual model with
// all the details, but a very simplified lamp so we can focus on the
// management of the parts.

// So far OpenSCAD can not assign geometry to variables, or pass it
// into modules as parameter. But we have seen it's possible to access
// child modules, so we can use that for our assembly. Instructions on
// placement of the parts comes from a separate data structure that can
// hold as much information as needed. In our simple case that's going
// to be translation, rotation and color.

step = 1; // [1:6]

show = 0; // [0: assembly, 1: base, 2: tube, 3: lamp]

wall = 2;

tube_h = 70;
tube_id = 28; // Inner diameter of the tube

lamp_h = 100;
lamp_od = 90;

battery_c_h = 50;
battery_c_d = 26.2;

tolerance = 0.2;

/*** STEP 1 ***/

// We start with a simple cylindrical base with a countersunk hole in
// the middle.

module base() {
	difference() {
		union() {
			cylinder(d = 3 * tube_id, h = wall);
			cylinder(d = tube_id - 2 * tolerance, h = 2 * wall);
		}
		cylinder(d = 3.2, h = 10 * wall, center = true);
		cylinder(d1 = 10, d2 = 3, h = 4, center = true);
	}
}

if (step == 1) {

base();

}

/*** STEP 2 ***/

// The second part is just simple tube, fitting on the base and with an
// hole for a screw to fix it to the base.

module tube() {
	linear_extrude(tube_h) difference() {
		circle(d = tube_id + 2 * wall);
		circle(d = tube_id);
	}
	difference() {
		translate([0, 0, wall]) linear_extrude(3 * wall, convexity = 3) {
			square([tube_id, 2 * wall], center = true);
			square([2 * wall, tube_id], center = true);
		}
		cylinder(d = 3, h = 10 * wall, center = true);
	}
}

if (step == 2) {

tube();

}

/*** STEP 3 ***/

// The top part is the diffuser of the lamp, a simple shape that is just
// a solid object, with the intention to print it in this upside-down
// orientation for better bed adhesion. Making it hollow and removing
// the top cap (in print orientation) is supposed to be handled by the
// slicing software.

module lamp() {
	cylinder(d1 = 0.6 * lamp_od, d2 = lamp_od, h = lamp_h / 3 - wall);
	translate([0, 0, lamp_h / 3]) rotate_extrude() hull() {
		translate([0, -wall]) square(2 * wall + 0.2);
		translate([lamp_od / 2, 0]) scale([0.6, 1]) circle(wall + 0.1);
	}
	translate([0, 0, lamp_h / 3 + wall])
		cylinder(d1 = lamp_od, d2 = tube_id - 2 * tolerance, h = lamp_h / 3 * 2 - wall);
	translate([0, 0, 10])
	cylinder(d = tube_id - 2 * tolerance, h = lamp_h);
	
}

if (step == 3) {

%lamp();

}

/*** STEP 4 ***/

// Lets first just stack all the model parts, so we see how it looks
// finished.  We translate and rotate the parts from their "printing"
// position into place of the fully assembled model. Adding some color can
// make it easier to distinguish the parts or visualize an approximation
// of the final look.

module full_model() {
	color("tan")
		base();
	color("tan")
		translate([0, 0, wall])
			tube();
	color("gray", 0.6)
		translate([0, 0, wall + tube_h + lamp_h])
			rotate([0, 180, 0])
				lamp();
}

if (step == 4) {

full_model();

}

/*** STEP 5 ***/

// You may have already seen that "show" parameter in the customizer
// which did not do anything so far. We'll change that now.

// As we created the parts in their printable orientation, the single
// part selection is trivial. The full model module took care of color
// and locations so we can also just use that for now.

// A simple switch statement takes care of deciding what to show based
// on the (customizer) variable "show". This works but is a bit tedious
// to manage.

// -> Change the value of the "show" variable to see the other views

if (step == 5) {

if (show == 0) {
	full_model();
} else if (show == 1) {
	base();
} else if (show == 2) {
	tube();
} else if (show == 3) {
	lamp();
}

}

/*** STEP 6 ***/

// We add some simple modules for the models for the extra parts,
// a screw and a battery and let assembly_extra_parts() take care
// of positioning the extra parts.
// Another option would be to add those to the data structure too.

module screw() {
	color("DimGray") {
		cylinder(h = 10, d = 3);
		cylinder(h = 2, d1 = 6, d2 = 3);
	}
}

module battery() {
	color("DodgerBlue")
		cylinder(d = battery_c_d, h = battery_c_h);
	color("White")
		translate([0, 0, 0.01])
			cylinder(d = battery_c_d - 2, h = battery_c_h);
	color("Silver")
		translate([0, 0, -0.01])
			cylinder(d1 = battery_c_d - 2, d2 = battery_c_d / 3, h = battery_c_h + 1);
}

module assembly_extra_parts() {
	translate([0, 0,  -40]) screw();
	translate([0, 0,  100]) battery();
}

parts = [
    [ "assembly",  [ 0, 0,                            0], [   0,   0, 0],         undef],
    [ "base",      [ 0, 0,                            0], [   0,   0, 0], ["tan",    1]],
    [ "tube",      [ 0, 0,                   wall +  20], [   0,   0, 0], ["tan",    1]],
    [ "lamp",      [ 0, 0, wall + tube_h + lamp_h + 100], [   0, 180, 0], ["gray", 0.6]],
];

// This is the core module handling the part selection. It iterates
// through all the child modules and in case the "show" variable is set
// to 0, it uses the data structure "parts" for rotating, translating
// and/or coloring the part.  For "show" values > 0, it will simply
// ignore all child modules that are not at the same index as that value.
module part_select() {
    for (idx = [0:1:$children-1]) {
        if (show == 0) {
            col = parts[idx][3];
            translate(parts[idx][1])
                rotate(parts[idx][2])
                    if (is_undef(col))
                        children(idx);
                    else
                        color(col[0], col[1])
                            children(idx);
        } else {
            if (show == idx)
                children(idx);
        }
    }
}

if (step == 6) {

// Now we only need to call the part selection module with all the
// parts as child modules in the order we have them defined in the
// data structure.
part_select() {
	assembly_extra_parts();
	base();
	tube();
	lamp();
}

}

/*** THE END ***/

/*********************************************************************/

// Written in 2024 by Torsten Paul <Torsten.Paul@gmx.de>
//
// To the extent possible under law, the author(s) have dedicated all
// copyright and related and neighboring rights to this software to the
// public domain worldwide. This software is distributed without any
// warranty.
//
// You should have received a copy of the CC0 Public Domain
// Dedication along with this software.
// If not, see <http://creativecommons.org/publicdomain/zero/1.0/>.

$fa = 2; $fs = 0.4;
