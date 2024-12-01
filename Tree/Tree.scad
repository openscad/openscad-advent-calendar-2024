n = 20;

function p(i, a, d) = (d + d * (i % 2)) * [ sin(a), cos(a) ];

module poly(d) polygon([for (i = [0:n-1]) let(a = i * 360 / n) p(i, a, d)]);

module level(d) {
	linear_extrude(15, scale = 0.1) poly(d);
	mirror([0, 0, 1]) linear_extrude(5, scale = 0.1) poly(d);
}

module tree() {
	for (i = [2:14]) {
		 d = 4e-2*(21-i)^2-1e-7*(21-i)^6;
		translate([0, 0, 4 * i])
			rotate(360/n * (i % 2))
			level(d);
	}
}

color("brown") cylinder(d = 8, h = 10);
color("green") tree();

$fa = 1; $fs = 0.2;

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
