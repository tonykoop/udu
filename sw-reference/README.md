# SolidWorks Reference — Udu Drum Family

Per-instrument SW reference folder for the udu packet. This mirrors the
convention from `drone-flutes/sw-reference/`, `tongue-drum/sw-reference/`,
and the rest of Tony's instrument repos: each instrument gets a small
folder that captures the SW MasterLayout convention, the global-equation
list, and the import procedure for the design table.

## Contents

| File | Purpose |
|---|---|
| `MasterLayout-equations.txt` | The global-equation list to paste into `Tools > Equations > Manage Equations` for `UDU-000_MasterLayout` |
| `import-design-table.md` | Step-by-step procedure for importing `../cad/sw-design-table.xlsx` as the embedded SW design table |
| `sketch-hierarchy.md` | The master-sketch dependency graph for the udu body |
| `extract-checklist.md` | What to verify before/after running `Extract_Dimensions.swp` |

## The Udu MasterLayout convention

The udu uses a **single master part** (`UDU-000_MasterLayout.SLDPRT`)
with four configurations driven by `cad/sw-design-table.xlsx`:

| Configuration | Member | Body Ø | Body H | Mouth Ø | Side Ø |
|---|---|---|---|---|---|
| `MASTER_TEMPLATE` | reference template | 10 in | 12 in | 3 in | 2 in |
| `UDU-S` | Small | 8 in | 10 in | 3 in | 2 in |
| `UDU-M` | Medium *(prototype 1)* | 10 in | 12 in | 3 in | 2 in |
| `UDU-L` | Large | 12 in | 14 in | 3 in | 2 in |
| `UDU-XL` | XL concert bass | 14 in | 16 in | 3 in | 2 in |

The 14 globals promoted into the design table from `family-spec.csv`:

```
target_hz_mouth     target_hz_side
body_diam_in        body_height_in        wall_thk_in
mouth_diam_in       side_diam_in
shape_factor        chamber_volume_cuin
predicted_hz_mouth  predicted_hz_side
cents_error_mouth   cents_error_side
master_scale_factor
```

## Round-trip workflow (Excel ↔ SolidWorks)

```
family-spec.csv
      │
      ▼
generate_sw_design_table.py  ──►  cad/sw-design-table.xlsx
                                              │
                                              │ (Insert > Tables > Design Table > From Existing File)
                                              ▼
                                  UDU-000_MasterLayout.SLDPRT
                                  (4 configurations)
                                              │
                                              │ (Run Extract_Dimensions.swp)
                                              ▼
                          cad/dimensions/<date>-<config>.csv
                                              │
                                              │ (ingest_dimension_csv.py)
                                              ▼
                                   findings report (drift report)
```

The contract: `family-spec.csv` is the single source of truth. The Excel
design table and the SW design table are both *views* of it. When Tony
edits a dimension in SW directly, run `Extract_Dimensions.swp` and then
`ingest_dimension_csv.py` to detect drift and update `family-spec.csv`.

See `references/solidworks-integration.md` in the instrument-maker-v4
skill for the canonical doc.

## Pack-and-Go derivation

Once the udu MasterLayout is stable, downstream instruments in the
slip-cast vessel-drum family can be derived via SW Pack-and-Go:

```
UDU-000_MasterLayout.SLDPRT
       │
       ├── Pack-and-Go ──► JEMBE-000_MasterLayout (skin-drum hybrid)
       └── Pack-and-Go ──► WATER-UDU-000_MasterLayout (UDU-P3 variant)
```

This is the same pattern used for `fujara → moseno` in the open-pipe family.
