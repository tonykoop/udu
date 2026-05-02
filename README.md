# Udu — Slip-Cast Ceramic Vessel Drum Family

> *Engineering documentation for a 3D-printed-master, plaster-mold, cone-6-stoneware slip-cast udu drum family — from dual-Helmholtz physics through the parametric design table to a manufacturable build packet.*

![Hero — AI-generated concept render of a Medium slip-cast udu (placeholder until first prototype is photographed)](images/hero-concept.png)
*AI-generated concept render — replace with photo of first UDU-P2 (Medium) prototype after firing. Manufacturing dimensions come from the parametric design table, not from this image.*

## What this is

Engineering documentation for a four-size family (Small / Medium / Large / XL) of slip-cast ceramic udu drums, built around the **dual-Helmholtz coupled-resonator** model and a 3D-printed-master / plaster-mold / Cone-6-stoneware production pipeline. The repository combines:

1. **A parametric design table** ([`udu-design-table.xlsx`](udu-design-table.xlsx)) — body diameter, body height, wall thickness, mouth diameter, side-hole diameter, shape factor, shrinkage, and a four-size family-spec block with target mouth-tone and side-tone frequencies. Master scale factor `1/(1 - measured_shrinkage)` is parameterized; for a 12% shrinkage assumption, the master scales at ~1.136×.
2. **A full build packet** ([`design.md`](design.md), [`bom.csv`](bom.csv), [`sourcing.csv`](sourcing.csv), [`cut-list.csv`](cut-list.csv), [`validation.csv`](validation.csv), [`assembly-manual.md`](assembly-manual.md), [`supplier-rfq.md`](supplier-rfq.md), [`drawing-brief.md`](drawing-brief.md), [`visual-bom-brief.md`](visual-bom-brief.md), [`wolfram-starter.wl`](wolfram-starter.wl)) — the same scaffold used across the [`tonykoop`](https://github.com/tonykoop) musical-instrument catalogue.
3. **A capstone slide deck and printable shop packet** ([`capstone-deck.pptx`](capstone-deck.pptx), [`print-packet.pdf`](print-packet.pdf)) — recruiter-facing artifacts that show the design is documented well enough that someone else could build it.

Sister repos: [`gemshorn`](https://github.com/tonykoop/gemshorn) (slip-cast horn-flute mold workflow), [`ocarina`](https://github.com/tonykoop/ocarina) (single-Helmholtz vessel-flute, sister slip-cast target), [`transverse-flute`](https://github.com/tonykoop/transverse-flute) (slip-cast workflow at larger scale), [`djembe`](https://github.com/tonykoop/djembe) (where Helmholtz-cavity-resonator analysis was originally derived for the bass tone), and [`instrument-maker`](https://github.com/tonykoop/instrument-maker) (the agent skill that generated this packet).

## Background — what makes the udu different

The udu (Igbo: *ụdụ*, "vessel") is a Nigerian clay-vessel drum: a closed ceramic body with a mouth at the top and a single side hole. Striking the mouth with a flat hand produces one resonant tone; striking the side hole produces another; opening, closing, and partly hand-covering each port lets the player slide and sweep between the two pitches. **It is not a generic ceramic bass pot.** Its lineage is specific and the documentation here treats that lineage as fact, not as marketing copy.

The governing model is **two coupled Helmholtz resonators sharing a chamber volume**:

```
f_top  = c/(2π) · √( A_top  / (V · L_top)  )
f_side = c/(2π) · √( A_side / (V · L_side) )
```

with `L = wall_thickness + 0.6·√(A/π)` (flanged-port end correction) and a coupling term that becomes important when both ports are partly open. Single-port formulas are useful **first-order** targets; the coupled-mode behavior — and especially the perceived pitch when a player's hand partly covers either port — has to be measured empirically. See [`design.md`](design.md) and [`wolfram-starter.wl`](wolfram-starter.wl) for the full treatment, including a placeholder eigenvalue model for coupled frequencies.

The practical consequence is that udu tuning is **two parametric pitches plus a player-coupled middle range**. Body volume sets the bass-end ceiling; port diameters set the upper bound; wall thickness and shape factor are secondary. Hand coupling is a sweep, not a discrete control — which is why the design table targets fall within ±50 ¢ rather than the ±25 ¢ used for fixed-pitch instruments like the ocarina.

## Family targets

The first prototype is the **Medium** body (10 in dia × 12 in tall, target mouth tone B3 ≈ 247 Hz, side tone G3 ≈ 196 Hz, chamber volume ≈ 440 in³). Once Medium voicing is stable, the same parametric model drives Small / Large / XL — see [`design.md`](design.md) and the family-spec block of [`udu-design-table.xlsx`](udu-design-table.xlsx).

| Model | Body diameter | Body height | Volume | Mouth tone | Side tone | Use |
|---|---:|---:|---:|---|---|---|
| **Small** | 8 in | 10 in | ~235 in³ | D♯4 | A3 | Tabletop, high tones |
| **Medium** *(prototype 1)* | 10 in | 12 in | ~440 in³ | B3 | G3 | Most versatile standard size |
| **Large** | 12 in | 14 in | ~739 in³ | G♯3 | D3 | Deep bass, traditional feel |
| **XL** | 14 in | 16 in | ~1149 in³ | F3 | C3 | Concert bass; needs stand |

Prototype ladder:

| Prototype | Goal | Success criteria |
|---|---|---|
| **UDU-P0** cup/port tile | Validate clay wall + tap behavior | No cracks; clear ceramic tap; clean port edge |
| **UDU-P1** Small body | Validate slip casting + side-hole slap | Measurable Helmholtz tones, comfortable slap edge |
| **UDU-P2** Medium body | Hit workbook Medium target | Mouth and side tones within ±50 ¢ post-bisque |
| **UDU-P3** Water udu | Pitch-bending volume variant | Smooth tilt-bend without leaking |
| **UDU-P4** Family molds | Scale S/M/L/XL | Predictable pitch trend across sizes |

## Hardware alignment — Bambu printer + ceramic kiln

This repo is one of the **slip-casting targets** for the in-flight Bambu printer + kiln pipeline. The build chain is:

1. Parametric design table sets fired-body dimensions.
2. Master scale factor `1/(1 - measured_shrinkage)` scales the master STL.
3. Bambu print master halves in PLA (or sealable resin); sand layer lines and seal. *Note: the Medium body is right at the edge of the Bambu X1C build envelope; XL will need a print farm split or outsourced master.*
4. Two-piece plaster mother mold around the sealed master.
5. Slip-cast Cone 6 stoneware → demold leather-hard → cut side hole undersized → bisque → tune → glaze (exterior only) → final fire.
6. Validate against [`validation.csv`](validation.csv); fold corrections back into the design table.

The same pipeline serves the [`ocarina`](https://github.com/tonykoop/ocarina), [`gemshorn`](https://github.com/tonykoop/gemshorn), and [`transverse-flute`](https://github.com/tonykoop/transverse-flute) repos.

## Repository structure

```
udu/
├── README.md                       ← you are here
├── LICENSE                         ← CC-BY 4.0
│
├── design.md                       ← dual-Helmholtz model, design intent, prototype ladder
├── udu-design-table.xlsx           ← parametric spreadsheet (formulas, blue inputs, family block)
│
├── bom.csv                         ← bill of materials
├── sourcing.csv                    ← supplier/search tracker
├── cut-list.csv                    ← rough/finished dimensions, tolerances, family scaling
├── validation.csv                  ← target/measured tuning + cents-error log
├── supplier-rfq.md                 ← RFQ template for slip / plaster / consumables
│
├── assembly-manual.md              ← shop-floor build sequence
├── drawing-brief.md                ← required views + critical dimensions for CAD
├── visual-bom-brief.md             ← visual-BOM art-direction brief
├── wolfram-starter.wl              ← dual-Helmholtz physics starter notebook
│
├── capstone-deck.{md,pptx}         ← capstone slide deck (9 slides — v1 codex skill output)
├── print-packet.{md,html,pdf}      ← combined print-ready shop packet
├── capstone-manifest.json          ← orientation manifest
│
├── cad/                            ← parametric body OpenSCAD starter (family-aware)
├── cnc/                            ← (deferred — slip-cast does not need CNC unless turning a wooden master)
├── drawings/                       ← SVG drawings: section, mold split, family scale
└── images/                         ← AI-generated concept renders (placeholders)
```

## Status

| Section | Status |
|---|---|
| Parametric design table + dual-Helmholtz model | ✓ done |
| Build packet (BOM / sourcing / cut-list / validation / RFQ) | ✓ done |
| Assembly manual + drawing brief | ✓ done |
| Wolfram physics starter (with coupled-mode placeholder) | ✓ done |
| Capstone deck + print packet | ✓ done (auto-generated, recruiter-facing) |
| Concept renders (AI-generated, captioned) | ✓ done (placeholders) |
| Parametric CAD (OpenSCAD starter, family-aware) | ✓ done (master-shape only) |
| Dimensioned drawings (SVG) | ✓ done (section + mold split + family scale) |
| Production-ready CAD (.step / .stl) | **deferred** — generated after empirical Medium-body validation |
| Coupled-mode tuning model (eigenvalue fit) | **deferred** — needs Phase-1 measured data |
| First UDU-P1 (Small) prototype build | forthcoming (Bambu + kiln pipeline) |

Tier 3 production files (.step, validated .stl, .dxf, .gcode) are **out of scope until UDU-P2 (Medium) validates wall thickness and port-pitch behavior**. See [`design.md`](design.md) "Open Assumptions" for the deferral reasoning.

## License

Released under [CC-BY 4.0](LICENSE) — original written content, design files, photographs, and physics work in this repository are mine, free to reuse and adapt with credit.

The **udu** as an instrument concept and name belongs to the Igbo people of Nigeria; the lineage attribution in [`design.md`](design.md) is part of the documentation, not a license claim.
