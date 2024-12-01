#!/bin/bash

set -euo pipefail

img() {
(
	N="$1"
	shift
	cd "$N"
	openscad --imgsize 1600,1600 --view axes,scales "$@" -o "$N".tmp.png "$N".scad
	gm convert "$N".tmp.png -scale 50% "$N".png
	rm -f "$N".tmp.png
)
}

tut() {
(
	N="$1"
	CNT="$2"
	shift 2
	cd "$N"
	for step in $(seq 0 $CNT)
	do
		T=$(printf "${N}.tmp-%04d.png" $step)
		I=$(printf "${N}.%04d.png" $step)
		if [ $step -eq 0 ]; then
			TEXT=""
			openscad -Dstep=$step --imgsize 1600,1500 --view axes,scales "$@" -o "$T" /dev/null
		else
			TEXT="Step $step"
			openscad -Dstep=$step --imgsize 1600,1500 --view axes,scales "$@" -o "$T" "$N".scad
		fi
		convert "$T" -background gray80 -font Open-Sans -gravity South -pointsize 60 -splice 0x100 -annotate +0+10 "$TEXT" -gravity Center -append -scale 50% "$I"
	done
	DELAY=500
	MORPHDELAY=8
	MORPHFRAMES=19
	convert \( "$N".????.png \) \( -clone 0 \) -loop 0 -morph $MORPHFRAMES -delete -1 -set delay "%[fx:(t%($MORPHFRAMES+1)==0)?$DELAY:$MORPHDELAY]" -layers Optimize "$N.gif"
	rm -f "$N".*.png
)
}

img Tree		--camera 0,0,35,72,0,60,220
img Nessie		--camera -20,10,10,65,0,300,260
tut TutorialPart01	2 --camera 0,0,0,55,0,25,100
