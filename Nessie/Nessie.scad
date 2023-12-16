$fa = 1;
$fs = 0.5;

enableNessie = true;
// Body radius
r1 = 5;
// Loop radius (to center of body)
r2 = 15;
tailA = 90;
eps = 0.1;
snoutL = 10;
snoutR1 = 2;
snoutR2 = 3;
eyePos = 0.6;
eyeAngle = 40;
hatH = 15;
hatDown = 2;
trimH = 2;
ballR = 1.5;

cBody = "green";
cNose = "red";
cEyes = "lightblue";
cTrim = "white";
cHat = "red";
cWater = "blue";

enableWater = true;
waterX = 600;
waterY = 600;
waterStep = 5;
waveLengthX = 60;
waveLengthY = 50;
waveAmpX = 2;
waveAmpY = 1;
waveH = waveAmpX + waveAmpY;
baseH = waveH + 0.5;

platform = false;

function wave(x,y) = waveAmpX*sin(360*x/waveLengthX) + waveAmpY*sin(360*y/waveLengthY);

function translatePoly(pts, o) = [ for (p = pts) p + o ];
function to3(pts) = [ for (p = pts) [p.x, p.y, 0] ];
function rotateY(pts, a) =
    let (m = [
        [ cos(a),  0, sin(a) ],
        [ 0,       1, 0      ],
        [ -sin(a), 0, cos(a) ]
    ])
    [ for (p = pts) p * m ];

module nessie() {
    translate([-r2*4,0,0]) {
        color(cBody) {
            rotate([90,0,0]) rotate_extrude(angle=90) translate([r2,0]) circle(r=r1);
        }
        translate([0,0,r2]) {
            color(cBody) rotate([0,-90,0])
                linear_extrude(height=snoutL, scale=[snoutR1/r1, snoutR2/r1])
                circle(r=r1);
            color(cNose) {
                translate([-snoutL,0,0])
                    scale([snoutR1/snoutR2, 1, snoutR1/snoutR2])
                    sphere(r=snoutR2);
            }
            color(cEyes) translate([-snoutL * eyePos,0,0]) {
                for (a = [eyeAngle,-eyeAngle]) {
                    sc = [1-eyePos*(1-snoutR1/r1), 1-eyePos*(1-snoutR2/r1)];
                    pos = [r1*cos(a)*sc.x, r1*sin(a)*sc.y];
                    translate([0,pos.y,pos.x]) sphere(1);
                }
            }
            translate([0,0,r1-hatDown]) {
                color(cTrim) cylinder(h=trimH, r=r1);
                color(cHat) translate([0,0,eps]) cylinder(h=hatH, r1=r1, r2=0);
                color(cTrim) translate([0,0,hatH-ballR]) sphere(r=ballR);
            }
        }
    }

    color(cBody) rotate([90,0,0]) rotate_extrude(angle=180) translate([r2,0]) circle(r=r1);

    color(cBody) translate([r2*4,0,0]) {
        nSeg = floor(r1*2*PI/$fs);
        c = [
            for(i=[0:nSeg-1])
                let(a=360*i/nSeg)
                r1*[cos(a), sin(a)]
        ];
        nStep = floor(tailA / 2);
        nExtraPoints = 2;
        startCenter = 0;
        endCenter = 1;
        pts = [
            [-r2,0,0],
            each rotateY([[-r2,0,0]], -tailA),
            each for (i = [0:nStep-1]) rotateY(to3(translatePoly((c * (1-i/nStep)), [-r2,0])), -i/nStep*tailA),
        ];
        faces = [
            for (i = [0:nStep-2])
                let(c1 = i*nSeg + nExtraPoints)
                let(c2 = (i+1)*nSeg + nExtraPoints)
                each for (j=[0:nSeg-1]) [
                    [c1+j, c2+j, c1 + (j+1)%nSeg],
                    [c1+(j+1)%nSeg, c2+j, c2 + (j+1)%nSeg]
                ],
            for (j = [0:nSeg-1])
                let(c1 = nExtraPoints)
                [ c1 + j, c1 + (j+1)%nSeg, startCenter ],
            for (j = [0:nSeg-1])
                let(c1 = (nStep-1)*nSeg + nExtraPoints)
                [ c1 + (j+1)%nSeg, c1 + j, endCenter ],
        ];

        polyhedron(pts, faces);
    }
}

module sfc(a, sz) {
    function dataIndex(x, y) = dataBase + x*ny + y;
    nx = len(a);
    ny = len(a[0]);
    corners = 0;
    dataBase = corners + 4;

    pts = [
        [0,    0,    -sz.z],
        [nx-1, 0,    -sz.z],
        [nx-1, ny-1, -sz.z],
        [0,    ny-1, -sz.z],
        for (x = [0:nx-1])
            for (y = [0:ny-1])
                [ x, y, a[x][y] ]
    ];
    faces = [
        [ corners+0, corners+1, corners+2 ],
        [ corners+0, corners+2, corners+3 ],
        [
            each for (x=[0:nx-1]) dataIndex(x,0),
            corners+1,
            corners+0,
        ],
        [
            each for (y=[0:ny-1]) dataIndex(nx-1,y),
            corners+2,
            corners+1,
        ],
        [
            each for (x=[nx-1:-1:0]) dataIndex(x,ny-1),
            corners+3,
            corners+2,
        ],
        [
            each for (y=[ny-1:-1:0]) dataIndex(0,y),
            corners+0,
            corners+3,
        ],
        each for (x=[0:nx-2], y=[0:ny-2]) [
            [ dataIndex(x+1, y), dataIndex(x, y), dataIndex(x, y+1) ],
            [ dataIndex(x+1, y+1), dataIndex(x+1, y), dataIndex(x, y+1) ],
        ],
    ];
    scale([sz.x/(nx-1),sz.y/(ny-1),1])
        polyhedron(pts, faces, convexity=ceil(max(waterX/waveLengthX, waterY/waveLengthY)));
}

if (enableNessie) {
    nessie();
}

if (enableWater) {
    water();
}

if (platform) {
    intersection() {
        scale([1,0.5,1]) cylinder(h=(baseH+waveH)*3, d=150, center=true);
        difference() {
            water();
            for (x=[-r2*3, -r2, r2, r2*3]) {
                translate([x,0,0]) cylinder(h=waveH*2+1, r=r1+0.5);
            }
        }
    }
}
module water() {
    water = [
        let(nx = floor(waterX/waterStep))
        let(xStep = waterX/nx)
        let(ny = floor(waterY/waterStep))
        let(yStep = waterY/ny)
        for (ix = [0:nx]) [
            for (iy=[0:ny])
                wave(ix*xStep, iy*yStep)
        ]
    ];
    color(cWater) translate([-waterX/4,-waterY/4,waveH])
        sfc(water, [waterX, waterY, baseH]);
}