# Udu Drum Family Build Packet

## Source

- Design table: `docs/Udu.xlsx`
- Sheet: `Udu Drum Family`
- Inspected range: `A1:H146`
- Workbook content observed: design inputs, dual Helmholtz calculator, four-size family, variants, playing techniques, ceramic production workflow, BOM, design notes, and Wolfram notebook notes.

## Design Intent

Build a slip-cast ceramic udu family with repeatable chamber volumes and two playable Helmholtz tones: the main mouth tone and the side-hole slap tone. The first production target is the medium standard udu, followed by a scaled family.

## Governing Model

The udu uses a shared chamber with two main ports:

```text
f_top = c/(2*pi) * sqrt(A_top/(V * L_top))
f_side = c/(2*pi) * sqrt(A_side/(V * L_side))
```

When both ports are open and the player's hands move, the modes couple. The single-port formulas are useful first-order targets; measured prototypes should define the final tuning corrections.

## Current Workbook Inputs

| Field | Current value |
| --- | --- |
| Body diameter | 10 in |
| Body height | 12 in |
| Wall thickness | 0.3 in |
| Mouth diameter | 3 in |
| Side hole diameter | 2 in |
| Shape factor | 0.7 |
| Clay body | Cone 6 stoneware |
| Shrinkage | 0.12 |
| Speed of sound | 13510 in/s |

## Current Family Targets

| Model | Diameter | Height | Volume | Mouth tone | Side tone | Use |
| --- | ---: | ---: | ---: | --- | --- | --- |
| Small | 8 in | 10 in | 235 in3 | D#4 | A3 | Tabletop and high tones |
| Medium | 10 in | 12 in | 440 in3 | B3 | G3 | Most versatile standard size |
| Large | 12 in | 14 in | 739 in3 | G#3 | D3 | Deep bass and traditional feel |
| XL | 14 in | 16 in | 1149 in3 | F3 | C3 | Concert bass, likely needs stand |

## Critical Design Features

- Body volume controls both main tones; slip casting is valuable because it makes volume repeatable.
- Port diameters and effective neck lengths are the main pitch controls.
- Wall thickness controls shell tap tone, durability, drying risk, and weight more than Helmholtz pitch.
- The side hole edge must be comfortable for repeated hand slaps.
- The mouth rim should be rounded enough for comfort but consistent enough for repeatable hand sealing.
- Feet, stand interface, or flat area should be designed before the mold if the instrument needs stability.

## Cultural And Product Note

The udu has Igbo roots and is not just a generic ceramic bass pot. Public-facing copy should be respectful, specific, and verified before publication. For Tony's own build docs, keep the lineage note visible and separate it from product marketing.

## Mold Strategy

Recommended first production mold:

- Two-piece plaster body mold split near the widest diameter.
- Separate mouth/neck core or hand-cut mouth after demold if that gives cleaner release.
- Side hole cut at leather-hard stage so tuning can be adjusted by cutter size and file work.
- Smooth mold split where hand contact will happen.
- Add subtle foot pads or a stand-contact feature if the final instrument should sit safely.

Master scale factor:

```text
scale = 1/(1 - shrinkage)
```

For 12 percent shrinkage, use approximately `1.136` before adjusting for measured clay data.

## Prototype Ladder

| Prototype | Goal | Success criteria |
| --- | --- | --- |
| UDU-P0 cup/port tile | Validate clay wall/tap behavior | No cracks; clear ceramic tap; clean port edge |
| UDU-P1 small body | Validate slip casting and side-hole slap | Measurable Helmholtz tone, comfortable slap edge |
| UDU-P2 medium body | Hit workbook medium target | Mouth and side tones within +/-50 cents after bisque |
| UDU-P3 water udu | Explore pitch-bending volume | Smooth tilt-bend without leaking or handling risk |
| UDU-P4 family molds | Scale S/M/L/XL | Predictable pitch trend across sizes |

## Workbook Improvement Notes

Recommended next workbook additions:

1. Add measured frequency and cents-error fields for mouth, side hole, and both-open condition.
2. Add cast-wall thickness measured at rim, shoulder, belly, and foot.
3. Add water-fill chamber volume after bisque and glaze fire.
4. Add per-size CAD master dimensions and shrinkage-compensated dimensions.
5. Add a coupled-mode experiment table for both ports open, side port covered, and mouth hand-muted.

## Open Assumptions

- Workbook costs are estimates and have not been date-checked.
- The side-hole tuning note in the workbook should be validated empirically; for a simple Helmholtz port, enlarging a port usually raises its open-port resonance, but hand coupling can make perceived playing behavior more complicated.
- Exact mold split and pour/drain design depend on final body shape.

