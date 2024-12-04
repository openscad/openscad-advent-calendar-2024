#!/bin/bash

set -euo pipefail

OPENSCAD=openscad-nightly

img() {
(
	N="$1"
	shift
	cd "$N"
	echo "$(date +%FT%T): Image '$N', params $@"
	"$OPENSCAD" -q --imgsize 1600,1600 --view axes,scales "$@" -o "$N".tmp.png "$N".scad
	gm convert "$N".tmp.png -scale 50% "$N".png
	rm -f "$N".tmp.png
)
}

tut() {
(
	N="$1"
	TITLE="$2"
	shift 2
	cd "$N"
	CNT=$(egrep '^step\s*=.*//.*\[[0-9]+:[0-9]+\]' "$N".scad | sed -E 's,^.*\[[0-9]+:(.*)\].*$,\1,')
	echo "$(date +%FT%T): Tutorial '$N', $CNT steps, params $@"
	for step in $(seq 0 $CNT)
	do
		echo -n "$step "
		T=$(printf "${N}.tmp-%04d.png" $step)
		I=$(printf "${N}.%04d.png" $step)
		if [ $step -eq 0 ]; then
			TEXT="$TITLE"
			"$OPENSCAD" -q -Dstep=$step --imgsize 1600,1500 --view axes,scales "$@" -o "$T" /dev/null
		else
			TEXT="Step $step"
			"$OPENSCAD" -q -Dstep=$step --imgsize 1600,1500 --view axes,scales "$@" -o "$T" "$N".scad
		fi
		convert "$T" -background gray80 -font Open-Sans -gravity South -pointsize 60 -splice 0x100 -annotate +0+10 "$TEXT" -gravity Center -append -scale 50% "$I"
	done
	DELAY=500
	MORPHDELAY=8
	MORPHFRAMES=19
	echo -n "animate "
	convert \( "$N".????.png \) \( -clone 0 \) -loop 0 -morph $MORPHFRAMES -delete -1 -set delay "%[fx:(t%($MORPHFRAMES+1)==0)?$DELAY:$MORPHDELAY]" -layers Optimize "$N.gif"
	rm -f "$N".*.png
	echo "done."
)
}

#img Tree		--camera 0,0,35,72,0,60,220
#img Nessie		--camera -20,10,10,65,0,300,260
#tut TutorialPart01	"Tutorial Part 1: Introduction"			--camera 0,0,0,55,0,25,100
#tut TutorialPart02	"Tutorial Part 2: Geometric Primitives"		--render=solid --backend=manifold --camera 0,0,0,55,0,25,100
#tut TutorialPart03	"Tutorial Part 3: Transformations"		--render=solid --backend=manifold --camera 0,0,0,55,0,25,100
#tut TutorialPart04	"Tutorial Part 4: Constructive Solid Geometry (CSG)"	--render=solid --backend=manifold --camera 0,0,0,55,0,25,140
tut TutorialPart05	"Tutorial Part 5: Debugging, Mesh Resolution"		--backend=manifold --camera 10,00,15,85,0,10,100
