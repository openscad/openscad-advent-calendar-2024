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
	echo -n "mp4 "
	ffmpeg -y -v 0 -i "$N.gif" -movflags faststart -pix_fmt yuv420p -vf "scale=trunc(iw/2)*2:trunc(ih/2)*2" "$N.mp4"
	rm -f "$N".*.png
	echo "done."
)
}

#img Tree		--camera 0,0,35,72,0,60,220
#img Nessie		--camera -20,10,10,65,0,300,260
#tut TutorialPart01	"Tutorial Part 1: Introduction"				--camera 0,0,0,55,0,25,100
#tut TutorialPart02	"Tutorial Part 2: Geometric Primitives"			--render=solid --backend=manifold --camera 0,0,0,55,0,25,100
#tut TutorialPart03	"Tutorial Part 3: Transformations"			--render=solid --backend=manifold --camera 0,0,0,55,0,25,100
#tut TutorialPart04	"Tutorial Part 4: Constructive Solid Geometry (CSG)"	--render=solid --backend=manifold --camera 0,0,0,55,0,25,140
#tut TutorialPart05	"Tutorial Part 5: Modifiers, Mesh Resolution"		--backend=manifold --camera 10,00,15,85,0,10,100
#tut TutorialPart06	"Tutorial Part 6: Math and Functions"			--render=solid --backend=manifold --camera 0,0,0,55,0,25,140
#tut TutorialPart07	"Tutorial Part 7: Mathematical Shape Outlines"		--render=solid --backend=manifold --camera 0,5,20,55,0,25,140
#tut TutorialPart08	"Tutorial Part 8: Extrusion"				--render=solid --backend=manifold --camera 0,0,10,55,0,25,140
#tut TutorialPart09	"Tutorial Part 9: Modules"				--render=solid --backend=manifold --camera 0,0,10,55,0,25,400
#tut TutorialPart10	"Tutorial Part 10: Putting things together"		--backend=manifold --camera 0,0,10,55,0,25,400
#tut TutorialPart11	"Tutorial Part 11: Rounded Rectangles, lots of them!"	--render=solid --backend=manifold --camera 15,10,10,40,0,25,140
#tut TutorialPart12	"Tutorial Part 12: Loops and chain hulls"		--render=solid --backend=manifold --camera 0,0,0,55,0,25,100
#tut TutorialPart13	"Tutorial Part 13: Recursive Snowflakes!"		--render=solid --backend=manifold --colorscheme "Nocturnal Gem" --camera 1,-0.6,1.5,30.5,0,13.8,208
#tut TutorialPart14	"Tutorial Part 14: Polygons and Polyhedrons"		--backend=manifold --camera 0,0,10,55,0,25,250
tut TutorialPart15	"Tutorial Part 15: Assemblies"				--backend=manifold --camera 0,0,130,80,0,25,900
