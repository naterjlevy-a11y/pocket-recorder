// ============================================================
//  THE BAR  —  6 x 6 x 35 mm  voice-note pendant
//  Every real component at its real coordinate.
//
//  VIEW options:
//    "assembled"  - the finished object
//    "ghost"      - see-through case, parts visible inside   <-- start here
//    "internals"  - just the parts, no case
//    "section"    - cut in half lengthways
//    "exploded"   - pulled apart
// ============================================================

VIEW = "ghost";

// ---------- THE BOX ----------
L    = 35.0;   // total length
W    = 6.0;    // width and depth (square)
WALL = 0.3;    // tube wall
CH   = 0.35;   // edge chamfer
CAV  = W - 2*WALL;            // 5.4 cavity

// ---------- ZONES DOWN THE LENGTH ----------
CAP_T  = 2.5;                 // top cap + chain bail
BATT_L = 14.5;                // battery only, thick step
BOARD_L= 13.0;                // board over the thin battery step
TIP_L  = 5.0;                 // black dielectric tip: antenna + light

Y_BATT  = CAP_T;
Y_BOARD = CAP_T + BATT_L;
Y_TIP   = L - TIP_L;

// ---------- BATTERY (custom stepped pouch) ----------
CELL_W  = 4.8;
CELL_T1 = 2.6;   // thin step, sits under the board
CELL_T2 = 4.6;   // thick step, fills the bar above the board

// ---------- BOARD ----------
PCB_W = 3.6;
PCB_T = 0.6;
// board sits on top of the thin battery step, with room underneath for the
// bottom-side components (0.55 tall). cell top = -CAV/2 + CELL_T1 = -0.1
PCB_Z = -CAV/2 + CELL_T1 + 0.55 + PCB_T/2;   // = 0.75

$fn = 40;

// ============================================================
//  HELPERS   (+Y runs DOWN the bar from the top)
// ============================================================

module bar_solid(len, width, ch=CH) {
    hull() {
        translate([0,-len,0]) linear_extrude(.01) square([width-2*ch, width], center=true);
        translate([0,-len,0]) linear_extrude(.01) square([width, width-2*ch], center=true);
        linear_extrude(.01) square([width-2*ch, width], center=true);
        linear_extrude(.01) square([width, width-2*ch], center=true);
    }
}

module tube(len) {
    difference() {
        bar_solid(len, W);
        translate([0,.01,0]) bar_solid(len+.02, CAV, ch=.15);
    }
}

// a component: x = mm from LEFT edge of board, y = mm down the BAR, z-up or z-down
module part(name, xoff, ybar, xs, ys, zh, up=true) {
    zbase = up ? PCB_Z + PCB_T/2 : PCB_Z - PCB_T/2 - zh;
    translate([-PCB_W/2 + xoff, -ybar - ys, zbase])
        cube([xs, ys, zh]);
}

// ============================================================
//  THE CASE
// ============================================================

module case_metal() {
    color("#C2C9CE") difference() {
        union() {
            translate([0,-CAP_T,0]) bar_solid(CAP_T, W);       // top cap
            translate([0,-Y_TIP,0]) tube(Y_TIP - CAP_T);       // the tube
        }
        // button bore, +X side face, centred 22.15 mm down
        translate([W/2, -22.15, 0]) rotate([0,90,0]) translate([0,0,-W]) cylinder(d=2.7, h=W);
        // mic port, +Z front face, 19.15 mm down
        translate([0, -19.15, W/2]) translate([0,0,-W]) cylinder(d=1.2, h=W);
        translate([0, -19.15, W/2-0.25]) cylinder(d=2.6, h=1);   // mesh recess
    }
    // chain bail
    color("#C2C9CE") translate([0, 1.2, 0]) rotate([90,0,0])
        rotate_extrude() translate([1.5,0]) circle(d=0.9);
}

module tip() {
    color("#22282B", 0.9) translate([0,-L,0]) bar_solid(TIP_L, W);
    // two charge pads on the bottom face
    color("#C9A227") for (x=[-1.2,1.2])
        translate([x, -L+0.1, 0]) rotate([90,0,0]) cylinder(d=1.6, h=0.3);
}

module pusher() {
    color("#E3E9ED") translate([W/2-0.05, -22.15, 0]) rotate([0,90,0])
        translate([0,0,-0.9]) cylinder(d=2.6, h=0.9);
    color("#141414") translate([W/2-0.8, -22.15, 0]) rotate([0,90,0])
        rotate_extrude() translate([1.45,0]) circle(d=0.4);
}

module mesh() {
    color("#394146") translate([0,-19.15,W/2-0.22]) cylinder(d=2.6, h=0.22);
}

// ============================================================
//  INTERNALS
// ============================================================

module battery() {
    color("#7A5230", 0.95) {
        // thick step — beside/above the board
        translate([-CELL_W/2, -Y_BOARD, -CELL_T2/2])
            cube([CELL_W, BATT_L, CELL_T2]);
        // thin step — tucked under the board
        translate([-CELL_W/2, -Y_TIP, -CAV/2])
            cube([CELL_W, BOARD_L, CELL_T1]);
    }
}

module board() {
    // the bare PCB
    color("#164D32") translate([-PCB_W/2, -Y_TIP, PCB_Z - PCB_T/2])
        cube([PCB_W, BOARD_L, PCB_T]);

    // ---- BOTTOM SIDE (faces the battery) ----
    color("#101010") part("SoC",     0.57, 17.40, 2.45, 2.25, 0.50, up=false);
    color("#101010") part("flash",   0.55, 20.10, 2.50, 2.50, 0.33, up=false);
    color("#101010") part("charger", 1.00, 23.05, 1.60, 0.90, 0.50, up=false);
    color("#9A8C5A") part("crystal", 1.00, 24.40, 1.60, 1.20, 0.35, up=false);
    color("#3A3A3A") part("rfmatch", 0.90, 26.05, 1.80, 0.30, 0.30, up=false);
    color("#3A3A3A") part("decap",   0.30, 26.80, 3.00, 0.60, 0.30, up=false);
    color("#4A4A4A") part("inductor",1.30, 27.85, 1.00, 0.50, 0.55, up=false);
    color("#B08D3A") part("padsp",   1.20, 28.80, 1.20, 0.80, 0.05, up=false);

    // ---- TOP SIDE (faces the case wall) ----
    color("#2A2A2A") part("mic",     0.48, 17.40, 2.65, 3.50, 0.98, up=true);
    color("#1A1A1A") part("switch",  0.55, 21.35, 2.50, 1.60, 0.80, up=true);
    color("#C94A2E") part("led",     1.30, 29.10, 1.00, 0.50, 0.45, up=true);

    // chip antenna, sitting inside the black tip
    color("#D8D8D8") translate([-1.6, -(L-1.2), -0.65]) cube([3.2, 1.6, 1.3]);
}

module internals() { battery(); board(); }

// ============================================================
//  VIEWS
// ============================================================

module full(explode=0) {
    translate([0,  explode*2, 0]) case_metal();
    translate([0, -explode*2, 0]) tip();
    translate([ explode*3, 0, 0]) pusher();
    translate([0, 0, explode*3]) mesh();
}

if (VIEW == "assembled") { full(); }

else if (VIEW == "ghost") {
    %full();          // transparent case
    internals();
}

else if (VIEW == "internals") { internals(); }

else if (VIEW == "exploded") {
    full(explode=2);
    translate([0,0,-9]) internals();
}

else if (VIEW == "section") {
    difference() { full(); translate([0,-L-2,-W]) cube([W,L+4,2*W]); }
    difference() { internals(); translate([0,-L-2,-W]) cube([W,L+4,2*W]); }
}

// ---------- checks printed to the console ----------
echo(str("LENGTH  ", CAP_T,"+",BATT_L,"+",BOARD_L,"+",TIP_L," = ",
         CAP_T+BATT_L+BOARD_L+TIP_L, " mm   (target ", L, ")"));
echo(str("CAVITY  ", CAV, " mm square"));
echo(str("STACK   mic 0.98 + pcb ", PCB_T, " + bottom 0.55 + cell ", CELL_T1,
         " = ", 0.98+PCB_T+0.55+CELL_T1, " mm  vs cavity ", CAV,
         "  -> margin ", CAV-(0.98+PCB_T+0.55+CELL_T1)));
echo(str("TOP OF MIC at z=", PCB_Z+PCB_T/2+0.98, "  cavity roof z=", CAV/2,
         "  -> clearance ", CAV/2-(PCB_Z+PCB_T/2+0.98)));
echo(str("WIDTH   board ", PCB_W, " in cavity ", CAV, " -> margin ", CAV-PCB_W));
