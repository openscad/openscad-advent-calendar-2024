#!/bin/bash

set -euo pipefail

img() {
(
	N="$1"
	C="$2"
	cd "$N"
	openscad --imgsize 1600,1600 --view axes,scales --camera "$C" -o "$N".tmp.png "$N".scad
	gm convert "$N".tmp.png -scale 50% "$N".png
	rm -f "$N".tmp.png
)
}

img Tree	0,0,35,72,0,60,220
img Nessie	-20,10,10,65,0,300,260
