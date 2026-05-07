# Ceramic Vessel Instrument Lab

This folder turns the existing `Ocarina.xlsx` and `Udu.xlsx` design tables into shop-facing build packets, then extends the same Helmholtz-resonator logic into a new vessel-flute research track.

## Source Files

| Instrument | Live design table | Build packet |
| --- | --- | --- |
| Ocarina | `docs/Ocarina.xlsx` | `docs/build-packets/ocarina/` |
| Udu drum family | `docs/Udu.xlsx` | `docs/build-packets/udu-drum-family/` |
| Experimental vessel flutes | TBD design table | `docs/build-packets/vessel-flute-lab/` |

## Program Goal

Use slip casting and 3D-printed mold masters to create repeatable ceramic vessel instruments whose pitch, response, and timbre can be tuned through measured cavity volume, wall thickness, voicing geometry, hole area, and firing shrinkage.

This is a good first ceramic instrument program because the udu, ocarina, water whistle, and sculptural vessel flute all share the same governing model:

```text
f = c/(2*pi) * sqrt(A_open/(V_chamber * L_eff))
```

The interesting part is not just hitting a note. It is learning how fired ceramic moves the model:

- Clay shrinkage changes volume, openings, and wall thickness.
- Wall thickness affects shell tap tone, projection, weight, and drying risk.
- Glaze changes mass, edge sharpness, and hole size.
- Mold drainage time controls cast wall thickness.
- Fipple and labium geometry often dominate playability more than the chamber formula.

## Recommended Build Order

1. **Small udu** - Fastest validation of slip-cast chamber volume, wall thickness, and two-port Helmholtz behavior.
2. **Alto C ocarina test body** - Adds fipple voicing and multi-hole tuning without requiring long straight bores.
3. **Water whistle / bird vessel** - Same physics with water-variable volume and sculptural freedom.
4. **Experimental vessel flute series** - Organic forms, multiple chambers, drone vents, and unusual hand layouts.
5. **Ceramic body electric violin** - Move here after mold repeatability, structural inserts, and firing distortion are under control.

## Shared Measurement Protocol

Every prototype should get a build number and the same measurements:

| Stage | Measurements |
| --- | --- |
| CAD master | Target chamber volume, target opening diameters, wall target, scale factor for shrinkage |
| Printed master | Measured master dimensions, print material, sealant, surface finish |
| Plaster mold | Mold weight, dry time, number of pours, registration quality |
| Green cast | Pour time, drain time, wall thickness sample, leather-hard mass, hole diameters |
| Bone dry | Mass, visible cracks/warps, chamber volume if measurable |
| Bisque | Mass, dimensions, volume, open-hole frequencies, fipple response |
| Glaze fired | Final mass, dimensions, volume, frequencies, cents error, tuning changes |

## Key Research Questions

- How close does the Helmholtz model predict greenware, bisque, and glaze-fired frequencies?
- Does stoneware or porcelain give better voicing stability for small fipple instruments?
- How much does exterior-only glaze shift ocarina/vessel-flute pitch?
- What wall thickness gives the best balance between durability and lively ceramic tap tone?
- Can 3D printed masters create vessel shapes that are hard to hand-build but still mold-release cleanly?
- Can non-round, organic chambers be reduced to measured water volume for reliable tuning?
- Can a vessel flute combine a Native American style breath feel with ocarina-style pitch control?

## Documentation To Keep Together

Each build packet uses this structure:

- `design.md` - source table, model, design intent, assumptions, and next improvements.
- `bom.csv` - material and tool list with workbook estimates where available.
- `sourcing.csv` - supplier/search-term fields without claiming current availability.
- `validation.csv` - tuning, shrinkage, wall-thickness, and build-result log.
- `assembly-manual.md` - shop workflow from CAD master through final tuning.
- `drawing-brief.md` - what the manufacturable drawing or CAD package must show.
- `visual-bom-brief.md` - image/BOM plate direction for future documentation.
- `wolfram-starter.wl` - notebook starter for physics exploration.

