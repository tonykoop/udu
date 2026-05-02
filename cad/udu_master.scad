// =============================================================
// Slip-Cast Ceramic Udu Drum Family — OpenSCAD Master-Shape Starter
// =============================================================
// Generated 2026-05-02 from the UDU-001 parametric design table.
// Units: inches.  Outputs the FIRED body envelope; multiply by
// master_scale_factor to get the printed master geometry.
//
// This is a master-shape STARTER — captures body volume, mouth
// port, and side port. NOT final production CAD: rim radii,
// foot/stand-pad geometry, and surface texture must be refined
// in detailed CAD before mold-making.
//
// Family: S / M / L / XL — each row in `family[]` triggers a
// different fired body envelope from the design table.
// =============================================================

$fn = 96;

// --------- INPUT PARAMETERS (from design table) ---------------

// Speed of sound in air (inches/sec at ~68 F):
c_in_per_sec = 13510;

// Shrinkage (replace with MEASURED value per slip batch):
shrinkage = 0.12;
master_scale_factor = 1 / (1 - shrinkage);   // ~1.136 at 12% shrinkage

// Wall thickness (fired):
wall_in = 0.30;

// Shape factor (1.0 = ellipsoid, <1.0 = pinched, >1.0 = bulged):
shape_factor = 0.7;

// Family block: [name, body_dia_in, body_height_in, mouth_dia_in, side_dia_in]
family = [
    [ "UDU-S",   8.0, 10.0, 3.0, 2.0 ],   // Small  — D#4 mouth / A3 side
    [ "UDU-M",  10.0, 12.0, 3.0, 2.0 ],   // Medium — B3 mouth / G3 side  (PROTOTYPE 1)
    [ "UDU-L",  12.0, 14.0, 3.0, 2.0 ],   // Large  — G#3 mouth / D3 side
    [ "UDU-XL", 14.0, 16.0, 3.0, 2.0 ]    // XL     — F3 mouth / C3 side
];

// Which family member to render full-detail (-1 = all, 0..3 = single):
preview_index = 1;   // Medium by default

// ---------------------- FUNCTIONS ------------------------------

// Volume of an ovoid body (matches workbook formula):
function volume_ovoid(d, h, sf) = (PI/6) * d*d * h * sf;

// Helmholtz frequency (in/in/sec system):
function helmholtz_hz(area, vol, neck) = (c_in_per_sec / (2*PI)) * sqrt( area / (vol * neck) );

// End correction:
function L_eff(wall, area) = wall + 0.6 * sqrt(area / PI);

// Circle area:
function area_circle(d) = PI * (d/2) * (d/2);

// ---------------------- GEOMETRY -------------------------------

module udu_outer(diam, height, sf) {
    // Egg/pot profile — pinched at top, broad at bottom.
    hull() {
        translate([0, 0, height * 0.30])
            scale([diam/2 * 0.95, diam/2 * 0.95, height * 0.45 * sf])
                sphere(r=1);
        translate([0, 0, height * 0.85])
            scale([diam/2 * 0.55, diam/2 * 0.55, height * 0.18])
                sphere(r=1);
        // Floor — slightly flattened.
        translate([0, 0, 0])
            scale([diam/2 * 0.85, diam/2 * 0.85, height * 0.04])
                sphere(r=1);
    }
}

module udu_inner(diam, height, sf) {
    // Inner cavity (offset by wall thickness):
    hull() {
        translate([0, 0, height * 0.30])
            scale([diam/2 * 0.95 - wall_in, diam/2 * 0.95 - wall_in, height * 0.45 * sf - wall_in])
                sphere(r=1);
        translate([0, 0, height * 0.85])
            scale([diam/2 * 0.55 - wall_in, diam/2 * 0.55 - wall_in, height * 0.18 - wall_in])
                sphere(r=1);
        translate([0, 0, 0])
            scale([diam/2 * 0.85 - wall_in, diam/2 * 0.85 - wall_in, height * 0.04 - wall_in])
                sphere(r=1);
    }
}

module udu_body(diam, height, sf, mouth_dia, side_dia) {
    difference() {
        udu_outer(diam, height, sf);
        udu_inner(diam, height, sf);
        // Mouth port (top):
        translate([0, 0, height * 0.95])
            cylinder(h = wall_in * 4, d = mouth_dia, center = true);
        // Side port (left side, comfortable hand height):
        translate([-diam/2, 0, height * 0.55])
            rotate([0, 90, 0])
                cylinder(h = wall_in * 4, d = side_dia, center = true);
    }
}

module udu_master(diam, height, sf, mouth_dia, side_dia) {
    // Master = solid scaled up by shrinkage factor.
    scale([master_scale_factor, master_scale_factor, master_scale_factor])
        udu_outer(diam, height, sf);
}

// --------------------- DEFAULT PREVIEW -------------------------

if (preview_index >= 0) {
    f = family[preview_index];
    udu_body(f[1], f[2], shape_factor, f[3], f[4]);
    // Echo physics:
    V = volume_ovoid(f[1], f[2], shape_factor);
    A_top = area_circle(f[3]);
    A_side = area_circle(f[4]);
    L_top = L_eff(wall_in, A_top);
    L_side = L_eff(wall_in, A_side);
    f_top = helmholtz_hz(A_top, V, L_top);
    f_side = helmholtz_hz(A_side, V, L_side);
    echo(str(f[0], "  V=", V, " in^3  f_top=", f_top, " Hz  f_side=", f_side, " Hz"));
} else {
    // Render whole family side by side:
    for (i = [0 : len(family) - 1]) {
        f = family[i];
        translate([i * 18, 0, 0])
            udu_body(f[1], f[2], shape_factor, f[3], f[4]);
    }
}
